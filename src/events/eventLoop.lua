eventLoop = function(currentTime, remainingTime)
	unrefreshableTimer.remainingMapTime = remainingTime
	unrefreshableTimer:loop()
	if (currentTime > 5000 and remainingTime < 500)
		or players._count.alive <= minPlayersForNextRound then
		if module.new_game_cooldown > time() then -- glitching?!
			logProcessError("EVT_L", "<N>[<V>%s <N>| <V>%s <N>| <V>%s <N>| <V>%s <N>| <V>%s " ..
				"<N>| <V>%s<N>]",
				currentTime, remainingTime, players._count.alive,
				players._count.dead, minPlayersForNextRound, players._count.currentRound)
		end

		if not hasTriggeredRoundEnd then
			eventRoundEnded()
		end
		return nextMap()
	end
	timer:loop()
end