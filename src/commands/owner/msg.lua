do
	-- Sends an official message in the chat
	ownerCommands["msg"] = function(playerName, command, rawcmd)
		chatMessage(format(getText.ownerAnnounce, sub(rawcmd, #command[1] + 2)))
	end
end