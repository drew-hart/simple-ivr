---------------------------
--
-- Imports
--
---------------------------
local inspect = require "inspect" -- Utility for debugging
local menu = require "summit.menu"
local time = require "summit.time" 
local datastore = require "summit.datastore"
local recording = require "summit.recording"
local sound = require "summit.sound"
local email = require "summit.email"
local http = require "summit.http"
local log = require "summit.log"


---------------------------
--
-- Get Settings from Datastore
--
---------------------------
function get_settings()

	-- Get group numbers
	local group_numbers, err = datastore.get_table("Group Numbers", "string")
	if not err then
		sales_phone   = group_numbers:get_row_by_key('sales')
		support_phone = group_numbers:get_row_by_key('support')
	else
		print("Error in get_data_store: ", err) --TODO: Log these errors 
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
	channel.dial(sales_phone.data, {timeout=30})
	voicemail = rec_voicemail()
	if (voicemail and voicemail.duration ~= 1) then
		email_voicemail(voicemail)
	end
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
	voicemail = rec_voicemail()
	if (voicemail and voicemail.duration ~= 1) then
		email_voicemail(voicemail)
	end
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
-- TODO: use the business hours function
---------------------------
function simple_ivr()
	if hours.data['end'] == hours.data['start'] then
		channel.say(closed_message)
	elseif time.format(now, "%H%M") < hours.data['end'] and 
	   	   time.format(now, "%H%M") > hours.data['start'] then
		my_menu()
	else
		channel.say(closed_message)
	end
end

---------------------------
--
-- Email voicemail
--
-- TODO: Wire this up to Datastore
---------------------------
function email_voicemail(recording)
		local to_addr 	= "drew.hart@corvisa.com"
		local from_addr = "drew@drewhart.com"
		local subject 	= "test"
		local body 		= "This is the body of the message. This should be in datastore."
		email.send(to_addr, from_addr, subject, body, {files={['recording.mp3']=recording}})
end

---------------------------
--
-- Voicemail recording function
--
---------------------------
function rec_voicemail()
	channel.say("If you would like to leave a message, then please do so after the beep. Otherwise, please hangup.")
	voicemail = channel.record({finishOnKey='#', maxLength=300, playBeep="true"})
	if voicemail then
		return voicemail
	end
end

---------------------------
--
-- Main 
--
---------------------------
channel.answer()
get_settings()
simple_ivr()
channel.hangup()
