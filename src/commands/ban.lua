do
	-- Bans a player temporarily
	commands["ban"] = function(playerName, command, isPermanent)
		-- !ban name time? reason?
		if not (command[2] and hasPermission(playerName, permissions.banUser)) then return end

		local targetPlayerId, targetPlayer = validateNicknameAndGetID(command[2])
		if not targetPlayerId then return end

		players_lobby(targetPlayer)

		local time = command[3]
		if not isPermanent then
			time = clamp(tonumber(time) or 24, 1, 360)
		end
		bannedPlayers[targetPlayerId] = time * 60 * 60 * 1000 -- hours

		local prettyTargetPlayer = prettifyNickname(targetPlayer, nil, nil, nil, "ROSE")
		local prettyPlayer = prettifyNickname(playerName, nil, nil, nil, 'J')
		command = table_concat(command, ' ', 4)

		if not isPermanent then
			chatMessage(format(getText.ban, prettyTargetPlayer, prettyPlayer, time, command),
				targetPlayer)
		else
			chatMessage(format(getText.permBan, prettyTargetPlayer, prettyPlayer, command),
				targetPlayer)
		end

		buildAndSaveDataFile()
	end
end