do
	-- Sends an official message in the chat
	commands["msg"] = function(playerName, command)
		if not hasPermission(playerName, permissions.sendRoomMessage) then return end

		chatMessage(format(getText.ownerAnnounce, table_concat(command, ' ', 2)))

		messagePlayersWithPrivilege(format(getText.internalMessage, prettifyNickname(playerName, 10,
			nil, "/B><G", 'B'), command[1], table_concat(command, ' ', 2, 5)))
	end
end