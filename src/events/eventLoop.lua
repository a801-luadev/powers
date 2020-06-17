eventLoop = function(currentTime, remainingTime)
	unrefreshableTimer:loop()
	if remainingTime < 500 or (not isLobby and players._count.alive <= minPlayersForNextRound) then
		if not hasTriggeredRoundEnd then
			eventRoundEnded()
		end
		return nextMap()
	end
	timer:loop()
end