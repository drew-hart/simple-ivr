-- Libraries
local inspect = require "inspect" -- Utility for debugging
local menu = require "summit.menu"
local time = require "summit.time" 
local datastore = require "summit.datastore"
local recording = require "summit.recording"
local sound = require "summit.sound"
local email = require "summit.email"
local log = require "summit.log"

-- ===================================================================
--
-- SETUP - Summit Datastore
--
-- Summit provides you with powerful database tool, where you can
-- store data. You can access datastore through the Summit Dashboard. 
-- To create a Summit account visit http://developers.corvisa.com
-- 
-- Several tables are required for this application to function. You
-- create tables by logging into the dashboard and clicking on 
-- Application > Datastore. From there select your application on the 
-- drop down and create tables by clicking on the plus sign. Below are
-- a list of tables that are used in this application to get you
-- started, but you are welcome to change them to meet your needs.
-- 
-----------------------------------------
--                TABLE 			   --
-----------------------------------------
-- 		Name: Group Numbers
-- 		Type: String
-- 		Key: sales      Value: [your phone number]
-- 		Key: support    Value: [a phone number]
--
-----------------------------------------
--                TABLE 			   --
-----------------------------------------
-- 		Name: Office Hours
-- 		Type: Map
-- 		Key Name: sunday     Key Values: name = start, value = [HHMM]
--							 Key Values: name = end, value = [HHMM]
-- 		Key Name: monday     Key Values: name = start, value = [HHMM]
--							 Key Values: name = end, value = [HHMM]
-- 		Key Name: tuesday    Key Values: name = start, value = [HHMM]
--							 Key Values: name = end, value = [HHMM]
--		... repeat this for each day of the week 
-- 
-----------------------------------------
--                TABLE 			   --
-----------------------------------------
-- 		Name: Office is Closed Message
-- 		Type: String
-- 		Key: message     Value: [the message you want played]
--
-- ===================================================================

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
		email_voicemail(rec_voicemail())
	elseif time.format(now, "%H%M") < hours.data['end'] and
	   	   time.format(now, "%H%M") > hours.data['start'] then
		my_menu()
	else
		channel.say(closed_message)
		email_voicemail(rec_voicemail())
	end
end

---------------------------
--
-- Logic for recording voicemails
--
---------------------------
function rec_voicemail()
	channel.say("Please leave a message. When youre finished, press pound sign or just hang up.")
	channel.play(sound.tone(1000, 300, 250, 1))
	voicemail = channel.record({finishOnKey='#*', maxLength=60, playBeep="false"})
	return voicemail
end

---------------------------
--
-- Logic for emailing voicemails
--
---------------------------
function email_voicemail()
	log.debug("-- Email function running --")
	local cur_time = time.now('US/Central')

	local to_addr 	= "drew@drewhart.com"
	local from_addr = "drew.hart@corvisa.com"
	local subject 	= cur_time
	local body 		= "This is the body of the message. This should be in datastore."
	local options 	= {}


	email.send(to_addr, from_addr, subject, body, options)
end

---------------------------
--
-- Logic for sms
--
---------------------------
function send_sms()
	local to_addr 	= "+18172964129"
	local from_addr = "+14145221801"
	local message 	= "SMS is working"
	sms.send(to_addr, from_addr, message)
	log.debug("sms.send successfully executed")
	log.debug("Ok: ", ok, "Err: ", err)
end
---------------------------
--
-- Main 
--
---------------------------
channel.answer()
email_voicemail()
send_sms()
get_datastore_data()
simple_ivr()
channel.hangup()
