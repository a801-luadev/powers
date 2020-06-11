do
	commands["profile"] = function(playerName, command)
		command[2] = command[2] and strToNickname(command[2]) or playerName
		keyboardCallbacks[keyboard.P](playerName, playerCache[playerName], nil, command[2])
	end
end