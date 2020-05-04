eventLoop = function(currentTime, remainingTime)
	if remainingTime < 500 then
		if not refreshedTimer then
			refreshedTimer = true
			timer.refresh()
		end
		return
	end
	timer.loop()
end