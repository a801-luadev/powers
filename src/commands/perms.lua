do
	local internalPermissionFormat = "\t<BL>%s <N>→ <V>0x%x"

	commands["perms"] = function(playerName, command)
		if not ((hasPermission(playerName, permissions.promoteUser) or
			hasPermission(playerName, permissions.demoteUser)) and playerCache[command[2]]) then
			command[2] = playerName
		end

		local perms, index = { }, 0
		for name, value in next, permissions do
			if hasPermission(command[2], value) then
				index = index + 1
				perms[index] = format(internalPermissionFormat, name, value)
			end
		end

		chatMessage(format("<BL>[<VI>•<BL>] <V>%s:\n%s", playerCache[command[2]].chatNickname,
			table_concat(perms, '\n')), playerName)
	end
end