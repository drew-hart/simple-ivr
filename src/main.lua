local menu = require "summit.menu"

channel.answer()
channel.play({'/sounds/a-team_intro.wav'})

local my_menu = menu.Menu()
my_menu.add("1", "Press 1 to contact sales", play_messages)
my_menu.add("2", "Press 2 to contact support", delete_all_messages)
my_menu.default(invalid_input)
my_menu.run()

channel.hangup()