eventLoop = function(currentTime, remainingTime)
	unrefreshableTimer.remainingMapTime = remainingTime
	unrefreshableTimer:loop()
	if remainingTime < 500 or players._count.alive <= minPlayersForNextRound then
		if module.new_game_cooldown > time() then -- glitching?!
			logProcessError("EVT_L", "<N>[<V>%s <N>| <V>%s <N>| <V>%s <N>| <V>%s <N>| <V>%s<N>]",
				module.author, currentTime, remainingTime, players._count.alive,
				players._count.dead, players._count.currentRound, debug.traceback())
		end

		if not hasTriggeredRoundEnd then
			eventRoundEnded()
		end
		return nextMap()
	end
	timer:loop()
end