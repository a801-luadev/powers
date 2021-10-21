do
	-- Bans a player temporarily
	commands["ban"] = function(playerName, command, isPermanent)
		-- !ban name time? reason?
		if not (command[2] and (not playerName or hasPermission(playerName, permissions.banUser))
			and dataFileContent[2]) then return end
		if not playerName then
			playerName = module.author
		end

		local targetPlayerId, targetPlayer = validateNicknameAndGetID(command[2])
		if not targetPlayerId then return end

		players_lobby(targetPlayer)

		local banTime = command[3]
		if not isPermanent then
			banTime = clamp(tonumber(banTime) or 24, 1, 360)
		end
		bannedPlayers[targetPlayerId] = time() + banTime * 60 * 60 * 1000 -- banTime in hours

		local prettyTargetPlayer = prettifyNickname(targetPlayer, nil, nil, nil, 'V')
		local prettyPlayer = prettifyNickname(playerName, nil, nil, nil, roleColors.str_moderator)
		command = table_concat(command, ' ', 4)

		if not isPermanent then
			chatMessage(format(getText.ban, prettyTargetPlayer, prettyPlayer, banTime, command))
		else
			chatMessage(format(getText.permBan, prettyTargetPlayer, prettyPlayer, command))
		end

		buildAndSaveDataFile()
	end
end