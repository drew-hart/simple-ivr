-- Libraries
local inspect = require "inspect" -- Utility for debugging
local menu = require "summit.menu"
local time = require "summit.time" 
local datastore = require "summit.datastore"
local recording = require("summit.recording")
local sound = require("summit.sound")

-- Static variables
-- TODO: Move to datastore

---------------------------
--
-- Get Datastore values
--
---------------------------
function get_datastore_data()
	-- Get group numbers
	local group_numbers, err = datastore.get_table("Group Numbers", "string")
	if not err then
		sales_phone   = group_numbers:get_row_by_key('sales')
		support_phone = group_numbers:get_row_by_key('support')
	else
		print("Error in get_data_store: ", err)
	end

	-- Get office hours
	local office_hours, err = datastore.get_table("Office Hours", "map")
	if not err then
		now = time.now('US/Central')
		local today = time.weekday_name(now)
	 	hours = office_hours:get_row_by_key(today)
	else
		print("Error in get_data_store: ", err)
	end

	-- Get close office message
	local office_closed, err = datastore.get_table("Office is Closed Message", "string")
	if not err then
		closed_message = office_closed:get_row_by_key('message').data
	else
		print("Error in get_data_store: ", err)
	end
end


---------------------------
--
-- Logic for Sales group
--
---------------------------
function sales()
	time.sleep(1)
	channel.say("Dialing sales now.")
	channel.dial(sales_phone.data, {timeout=20})
end

---------------------------
--
-- Logic for Support group
--
---------------------------
function support()
	time.sleep(1)
	channel.say("Dialing support now.")
	channel.dial(support_phone.data, {timeout=20})
	-- the timeout feature does not work as of 2/26/15
end

---------------------------
--
-- Menu logic
--
---------------------------
function my_menu()
	local my_menu = menu.Menu()
	my_menu.intro("Thanks for calling.")
	my_menu.add("1", "Press 1 to contact sales", sales)
	my_menu.add("2", "Press 2 to contact support", support)
	-- TODO: Add an invalid option using my_menu.default function
	my_menu.timeout(30)
	my_menu.default(invalid_option)
	my_menu.run()
end

---------------------------
--
-- IVR logic
--
---------------------------
function simple_ivr()
	if hours.data['end'] == hours.data['start'] then
		channel.say(closed_message)
		rec_voicemail()
	elseif time.format(now, "%H%M") < hours.data['end'] and
	   	   time.format(now, "%H%M") > hours.data['start'] then
		my_menu()
	else
		channel.say(closed_message)
		rec_voicemail()
	end
end

---------------------------
--
-- Logic for recording voicemail
--
---------------------------
function rec_voicemail()
	channel.say("Please leave a message. When youre finished, press pound or just hang up.")
	channel.play(sound.tone(1000, 300, 500, 1))
	my_voicemail = channel.record({finishOnKey='#*', maxLength=60, playBeep="false"})
	-- test that the recording
	my_recording = recording(my_voicemail.id)
	channel.play(my_recording)
end

---------------------------
--
-- Main 
--
---------------------------
channel.answer()
get_datastore_data()
simple_ivr()
channel.hangup()
