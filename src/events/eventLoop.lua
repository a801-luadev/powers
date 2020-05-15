eventLoop = function(currentTime, remainingTime)
	if remainingTime < 500 then
		if not hasTriggeredRoundEnd then
			eventRoundEnded()
		end
		if canLoadNextMap then
			nextMapLoadTentatives = nextMapLoadTentatives + 1
			if nextMapLoadTentatives == 4 then
				nextMapLoadTentatives = 0
				setNextMapIndex()
			end
			newGame(maps[currentMap])
		end
		return
	end
	timer.loop()
end