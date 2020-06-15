do
	-- Removes specific permissions from a player
	commands["demote"] = function(playerName, command)
		-- !demote name permissions
		if not (command[3] and hasPermission(playerName, permissions.demoteUser)
			and dataFileContent[2]) then return end

		local targetPlayerId, targetPlayer = validateNicknameAndGetID(command[2])
		if not targetPlayerId then return end

		local prettyTargetPlayer = prettifyNickname(targetPlayer, 10, nil, "/B><G", 'B')

		messagePlayersWithPrivilege(format(getText.internalMessage, prettifyNickname(playerName, 10,
			nil, "/B><G", 'B'), command[1], table_concat(command, ' ', 2)))

		local saveDataFile = false

		local removedPermissions, permissionsCounter = { }, 0
		local rolePerm, perm, permRemoved
		for p = 3, #command do
			p = command[p]

			rolePerm = rolePermissions[p]
			perm = rolePerm or permissions[p]

			if perm then
				permRemoved = removePermission(playerName, perm, targetPlayerId)
				if permRemoved then
					if rolePerm then
						saveDataFile = true
						chatMessage(format(getText.playerLoseRole, prettyTargetPlayer,
							roleColors[p], upper(p)))
					else
						permissionsCounter = permissionsCounter + 1
						removedPermissions[permissionsCounter] = p
					end
				end
			end
		end

		if permissionsCounter > 0 then
			saveDataFile = true
			messagePlayersWithPrivilege(format(getText.playerLosePermissions, prettyTargetPlayer,
				table_concat(removedPermissions, "</B> - <B>")))
		end

		if saveDataFile then
			buildAndSaveDataFile()
		end
	end
end