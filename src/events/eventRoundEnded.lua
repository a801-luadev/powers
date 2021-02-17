eventRoundEnded = function()
	hasTriggeredRoundEnd = true
	canTriggerPowers = false

	-- Clears all current timers
	timer.refresh()

	if currentMap == 0 then return end

	-- Resets divine powers
	removeTextArea(textAreaId.gravitationalAnomaly)

	local alivePlayers = players.alive
	local winners, winnerCount, winnerName = { }, 0

	local cache
	for playerName in next, players.currentRound do
		-- Only players that played in this round
		cache = playerCache[playerName]
		if cache then
			if resetPlayersDefaultSize then
				changePlayerSize(playerName, 1)
			end

			if cache.soulMate then
				linkMice(playerName, cache.soulMate, false)
			end

			if alivePlayers[playerName] then
				winnerCount = winnerCount + 1
				winners[winnerCount] = cache.chatNickname
				winnerName = playerName

				-- Ties won't give XP anymore.
				playerData:set(playerName, "victories", 1, true)

				if playerData:get(playerName, "victories") == 2000 then
					giveBadge(playerName, "victorious", cache)
				end

				giveCheese(playerName)
				playerVictory(playerName)
			end
			playerData
				:set(playerName, "rounds", 1, true)
				:save(playerName)

				if playerData:get(playerName, "rounds") == 1100 then
					giveBadge(playerName, "superPlayer", cache)
				end

			-- Checks player level
			checkPlayerLevel(playerName, cache)
		end
	end
	resetPlayersDefaultSize = false

	-- Announce winner
	if winnerCount > 0 then
		chatMessage(format(getText.mentionWinner, table_concat(winners, "<FC>, ")))

		if winnerCount == 1 then -- Only rounds with one winner give XP
			playerData
				:set(winnerName, "xp", module.xp_on_victory, true)
				:save(winnerName)
		end
	else
		chatMessage(getText.noWinner)
	end
end