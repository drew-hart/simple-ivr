-- Libraries
local inspect = require "inspect" -- Utility for debugging
local menu = require "summit.menu"
local time = require "summit.time" 
local datastore = require "summit.datastore"

-- Static variables
-- TODO: Move to datastore

-- Get group numbers from datastore
local group_numbers, err = datastore.get_table("Group Numbers", "string")

if not err then
	sales_phone   = group_numbers:get_row_by_key('sales')
	support_phone = group_numbers:get_row_by_key('support')
end
-- End datastore testing

-- Let it being!!!
channel.answer()

---------------------------
--
-- Logic for Sales group
--
---------------------------
function sales()
	time.sleep(1)
	channel.say("Dialing sales now.")
	channel.dial(sales_phone.data, {timeout=5})
end

---------------------------
--
-- Logic for Support group
--
---------------------------
function support()
	time.sleep(1)
	channel.say("Dialing support now.")
	channel.dial(support_phone.data, {timeout=5})
	-- the timeout feature does not work as of 2/26/15
end

---------------------------
--
-- Main
--
---------------------------
local my_menu = menu.Menu()
my_menu.intro("Thanks for calling.")
my_menu.add("1", "Press 1 to contact sales", sales)
my_menu.add("2", "Press 2 to contact support", support)
-- TODO: Add an invalid option using my_menu.default function
my_menu.run()

channel.hangup()
