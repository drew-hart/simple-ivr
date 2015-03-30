---------------------------
--
-- Imports
--
---------------------------

-- Utilities
local inspect = require "inspect"

-- Summit imports
local log = require "summit.log"
local menu = require "summit.menu"
local time = require "summit.time" 
local http = require "summit.http"
local sound = require "summit.sound"
local email = require "summit.email"
local datastore = require "summit.datastore"
local recording = require "summit.recording"

---------------------------
--
-- Get Settings from Datastore
--
---------------------------
function get_settings()

	-- Get group numbers
	local group_numbers, err = datastore.get_table("Group Numbers Map", "map")
	if err then
		log.debug("Error in get_data_store: ", err)
	else
		sales_settings = group_numbers:get_row_by_key('sales')
		support_settings = group_numbers:get_row_by_key('support')
	end

	-- Get office hours
	local office_hours, err = datastore.get_table("Office Hours", "map")
	if err then
		print("Error in get_data_store: ", err)
	else
		now = time.now('US/Central')
		local today = time.weekday_name(now)
	 	hours = office_hours:get_row_by_key(today)
	end

	-- Get close office message
	local office_closed, err = datastore.get_table("Office is Closed Message", "string")
	if err then
		print("Error in get_data_store: ", err)
	else
		closed_message = office_closed:get_row_by_key('message').data
	end
end

---------------------------
--
-- Logic for Sales group
--
---------------------------
function call_sales()
	time.sleep(1)
	channel.say("Dialing sales now.")
	channel.dial(sales_settings.data['phone'], {timeout=20})
	voicemail = rec_voicemail()
	if (voicemail and voicemail.duration ~= 1) then
		email_voicemail(sales_settings.data['email'], voicemail)
	end
end

---------------------------
--
-- Logic for Support group
--
---------------------------
function call_support()
	time.sleep(1)
	channel.say("Dialing support now.")
	channel.dial(sales_settings.data['phone'], {timeout=20})
	voicemail = rec_voicemail()
	if (voicemail and voicemail.duration ~= 1) then
		email_voicemail(support_settings.data['email'], voicemail)
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
	my_menu.add("1", "Press 1 to contact sales", call_sales)
	my_menu.add("2", "Press 2 to contact support", call_support)
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
---------------------------
function email_voicemail(address, recording)
	local to_addr 	= address
	local from_addr = "drew.hart@corvisa.com"
	local subject 	= "Voicemail for " .. sales_settings.data['name']
	local body 		= "A voicemail message is attached"
	
	res, err = email.send(to_addr, from_addr, subject, body, {file={['recording.mp3']=recording}})
	if err then
		print("Error: ", err)
	else
		log.info("voicemail sent successfully to ", address, " - ", recording )
	end
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
