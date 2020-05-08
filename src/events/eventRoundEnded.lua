eventRoundEnded = function()
	canTriggerPowers = false
	timer.refresh()

	for name, cache in next, playerCache do
		if resetPlayersDefaultSize then
			changePlayerSize(name, 1)
		end

		if cache.soulMate then
			linkMice(name, cache.soulMate, false)
		end
	end
end