local menu = require "summit.menu"


channel.answer()
channel.play({'/sounds/greeting.wav'})
local digit = channel.gather({play="Press 1 for sales.  Press 2 to delete all messages", maxDigits=1})
if digit == '1' then
    return play_messages
elseif digit == '2' then
    return delete_all_messages
else
    return invalid_input
end


channel.hangup()

