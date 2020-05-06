eventLoop = function(currentTime, remainingTime)
	if remainingTime < 500 then
		if not refreshedTimers then
			refreshedTimers = true
			timer.refresh()
		end
		return
	end
	timer.loop()
end