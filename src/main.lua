-- This comment enforces unit-test coverage for this file:
-- coverage: 0

channel.answer()
channel.say("This is an example application. Drew. Enter a number followed by the pound sign. Enter it now.")
local digits = channel.gather()
channel.say(digits)
channel.hangup()

