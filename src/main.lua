local menu = require "summit.menu"
local time = require "summit.time" 
local datastore = require "summit.datastore"
local sales_phone   = '8172964129'
local support_phone = '2622271450'

local table, err = datastore.get_table("group_phone_numbers", "set")

if not err then 
	print ("No errors on getting the datastore")
	local row, err = table:get_row_by_key('sales')
	print ("Table: ", row.key)
	print ("Data:  ", row.data)
end


channel.answer()

---------------------------
--
-- Logic for Sales group
--
---------------------------
function sales()
	time.sleep(1)
	channel.say("Dialing sales now.")
	channel.dial(sales_phone, {timeout=5})
end

---------------------------
--
-- Logic for Support group
--
---------------------------
function support()
	time.sleep(1)
	channel.say("Dialing support now.")
	channel.dial(suport_phone)
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