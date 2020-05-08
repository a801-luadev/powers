eventRoundEnded = function()
	hasTriggeredRoundEnd = true

	if not hasRefreshedTimers then
		hasRefreshedTimers = true
		timer.refresh()
	end

	for name, cache in next, playerCache do
		if resetPlayersDefaultSize then
			changePlayerSize(name, 1)
		end

		if cache.soulMate then
			linkMice(name, cache.soulMate, false)
		end
	end
end