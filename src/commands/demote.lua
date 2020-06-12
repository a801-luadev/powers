do
	-- Removes specific permissions from a player
	commands["demote"] = function(playerName, command)
		-- !demote name permissions
		if not (command[3] and hasPermission(playerName, permissions.demoteUser)) then return end

		local targetPlayerId, targetPlayer = validateNicknameAndGetID(command[2])
		if not targetPlayerId then return end

		local prettyTargetPlayer = prettifyNickname(targetPlayer, 10, nil, "/B><G", 'B')

		messagePlayersWithPrivilege(format(getText.privatePlayerUnsetPermissions,
			prettifyNickname(playerName, 10, nil, "/B><G", 'B'), prettyTargetPlayer,
			table_concat(command, " - ", 3)))

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
			messagePlayersWithPrivilege(format(getText.playerLosePermissions, prettyTargetPlayer,
				table_concat(removedPermissions, "</B> - <B>")))
		end

		buildAndSaveDataFile()
	end
end