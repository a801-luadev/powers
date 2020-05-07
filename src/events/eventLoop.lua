eventLoop = function(currentTime, remainingTime)
	if remainingTime < 500 then
		if not hasRefreshedTimers then
			hasRefreshedTimers = true
			timer.refresh()
		end
		return
	end
	timer.loop()
end