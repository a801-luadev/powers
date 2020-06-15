do
	commands["pw"] = function(playerName, command)
		if not roomAdmins[playerName] then return end

		command = table_concat(command, ' ', 2)
		setRoomPassword(command)

		playerName = prettifyNickname(playerName, 10, nil, "/B><G", 'B')

		if command ~= '' then
			messageRoomAdmins(format(getText.setPassword, playerName, command))
		else -- no password
			messageRoomAdmins(format(getText.removePassword, playerName))
		end
	end
end