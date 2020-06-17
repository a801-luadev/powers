do
	local msgFormat = "<FC><B>[#powers]</B> "
	local internalMessageFormat = "<BL>[<VI>•<BL>] %s <BL>[%s] → %s"

	-- Sends an official message in the chat
	commands["msg"] = function(playerName, command)
		if not hasPermission(playerName, permissions.sendRoomMessage) then return end

		chatMessage(msgFormat .. table_concat(command, ' ', 2))

		messagePlayersWithPrivilege(format(internalMessageFormat, prettifyNickname(playerName, 10,
			nil, "/B><G", 'B'), command[1], table_concat(command, ' ', 2, min(#command, 5))))
	end
end