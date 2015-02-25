local menu = require "summit.menu"

local sales_phone   = '8172964129'
local support_phone = '2622271450'

channel.answer()

---------------------------
--
-- Logic for invalid option being pressed
--
---------------------------
function invalid_input()
	channel.say("The number you pressed is not a valid option")	
	my_menu.run()
end

---------------------------
--
-- Logic for Sales group
--
---------------------------
function sales()
	channel.say("Dialing sales now.")
	channel.dial(sales_phone)
end

---------------------------
--
-- Logic for Support group
--
---------------------------
function support()
	channel.say("Dialing support now.")
	channel.dial(support_phone)
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
my_menu.invalid(invalid_input)
my_menu.run()

channel.hangup()