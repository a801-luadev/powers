do
	-- Unbans a player
	commands["unban"] = function(playerName, command)
		-- !unban name
		if not (command[2] and hasPermission(playerName, permissions.unbanUser)) then return end

		local targetPlayer = strToNickname(command[2], true)
		local targetPlayerId = tfm.get.room.playerList[targetPlayer]
		targetPlayerId = targetPlayerId and targetPlayerId.id

		local time = bannedPlayers[targetPlayerId]
		if not time then return end

		-- Can't unban permbanned users unless they have permission to
		if time == 0 and not hasPermission(playerName, permissions.permBanUser) then
			return chatMessage(getText.cantPermUnban, playerName)
		end

		chatMessage(format(getText.unban, prettifyNickname(playerName, nil, nil, nil, 'J')),
			targetPlayer)
	end
end