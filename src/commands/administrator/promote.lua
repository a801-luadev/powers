do
	-- Adds specific permissions to a player
	commands["promote"] = function(playerName, command)
		-- !promote name permissions
		if not (command[3] and hasPermission(playerName, permissions.promoteUser)
			and dataFileContent[2]) then return end

		local targetPlayerId, targetPlayer = validateNicknameAndGetID(command[2])
		if not targetPlayerId then return end

		local prettyTargetPlayer = prettifyNickname(targetPlayer, 10, nil, "/B><G", 'B')

		messagePlayersWithPrivilege(format(getText.internalMessage, prettifyNickname(playerName, 10,
			nil, "/B><G", 'B'), command[1], table_concat(command, ' ', 2)))

		local saveDataFile = false

		local givenPermissions, permissionsCounter = { }, 0
		local rolePerm, perm, permAdded
		for p = 3, #command do
			p = command[p]

			rolePerm = rolePermissions[p]
			perm = rolePerm or permissions[p]

			if perm then
				permAdded = addPermission(playerName, perm, targetPlayerId)
				if permAdded then
					if rolePerm then
						saveDataFile = true
						chatMessage(format(getText.playerGetRole, prettyTargetPlayer, roleColors[p],
							upper(p)))
					else
						permissionsCounter = permissionsCounter + 1
						givenPermissions[permissionsCounter] = p
					end
				end
			end
		end

		if permissionsCounter > 0 then
			saveDataFile = true
			messagePlayersWithPrivilege(format(getText.playerGetPermissions, prettyTargetPlayer,
				table_concat(givenPermissions, "</B> - <B>")))
		end

		if saveDataFile then
			buildAndSaveDataFile()
		end
	end
end