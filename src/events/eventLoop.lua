eventLoop = function(currentTime, remainingTime)
	if remainingTime < 500 then --< DEBUG <--or players._count.alive <= 1 then
		if not hasTriggeredRoundEnd then
			eventRoundEnded()
		end
		return nextMap()
	end
	timer.loop()
end