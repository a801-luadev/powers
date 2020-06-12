do
	-- Bans a player permanently
	commands["permban"] = function(playerName, command)
		-- !permban name reason?
		if not (command[2] and hasPermission(playerName, permissions.permBanUser)) then return end

		table_insert(command, 3, 0)
		commands["ban"](playerName, command, true)
	end
end