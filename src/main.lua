local sms = require "summit.sms"

channel.answer()
	local resp, err = sms.send("+18172964129", "+14145338385", "Way to Go!")

	if err then
		channel.say(err)
	else
		channel.say("Your SMS Message was succesfully sent")
	end
channel.hangup()
