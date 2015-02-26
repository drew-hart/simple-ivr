local menu = require "summit.menu"
local time = require('summit.time')

local sales_phone   = '8172964129'
local support_phone = '2622271450'

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
	channel.dial(suport_phone, {timeout=5})
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
my_menu.run()

channel.hangup()