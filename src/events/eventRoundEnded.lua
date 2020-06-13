eventRoundEnded = function()
	wasLobby = isLobby
	isLobby = (not isReviewMode and players._count.room <= 1)

	hasTriggeredRoundEnd = not isLobby

	if wasLobby then
		if isLobby then
			setGameTime(5)
			return
		else
			removeTextArea(textAreaId.lobby)
		end
	end

	canTriggerPowers = false

	-- Clears all current timers
	timer.refresh()

	if currentMap == 0 then return end

	-- Resets divine powers
	removeTextArea(textAreaId.gravitationalAnomaly)

	local alivePlayers, lobbyPlayers = players.alive, players.lobby
	local winners, winnerCount = { }, 0

	for name, cache in next, playerCache do
		-- Only players that played in this round
		if not lobbyPlayers[name] then
			if resetPlayersDefaultSize then
				changePlayerSize(name, 1)
			end

			if cache.soulMate then
				linkMice(name, cache.soulMate, false)
			end

			if alivePlayers[name] then
				winnerCount = winnerCount + 1
				winners[winnerCount] = prettifyNickname(name, 10, nil, "/B><G", 'B')

				playerData
					:set(name, "xp", module.xp_on_victory, true)
					:set(name, "victories", 1, true)

				giveCheese(name)
				playerVictory(name)
			end
			playerData
				:set(name, "rounds", 1, true)
				:save(name)

			-- Checks player level
			checkPlayerLevel(name, cache)
		end
	end
	resetPlayersDefaultSize = false

	-- Announce winner
	if winnerCount > 0 then
		chatMessage(format(getText.mentionWinner, table_concat(winners, "<FC>, ")))
	else
		chatMessage(getText.noWinner)
	end
end