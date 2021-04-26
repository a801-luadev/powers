do
	-- Sends an official message in the chat
	commands["msg"] = function(playerName, command)
		if not hasPermission(playerName, permissions.sendRoomMessage) then return end

		chatMessage("<FC><B>[#powers]</B> " .. table_concat(command, ' ', 2))

		logCommandUsage(playerName, command)
	end
end