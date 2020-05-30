do
	commands["profile"] = function(playerName, command)
		command[2] = command[2] and strToNickname(command[2]) or playerName
		displayProfile(playerName, command[2])
	end
end