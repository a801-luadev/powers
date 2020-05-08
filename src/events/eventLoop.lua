eventLoop = function(currentTime, remainingTime)
	if remainingTime < 500 then
		if not hasTriggeredRoundEnd then
			eventRoundEnded()
		end
		return
	end
	timer.loop()
end