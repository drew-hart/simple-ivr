local menu = require "summit.menu"

channel.answer()

---------------------------
--
-- Logic for invalid option being pressed
--
---------------------------
function invalid_input()
	channel.say("The number you pressed as not valid. Please try again.")	
end

---------------------------
--
-- Logic for Sales group
--
---------------------------
function sales()
	channel.say("Dialing sales now.")
	channel.dial('8172964129')
end

---------------------------
--
-- Logic for Support group
--
---------------------------
function support()
	channel.say("Dialing support now.")
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
my_menu.default()
my_menu.run()

channel.hangup()