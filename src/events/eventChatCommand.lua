eventChatCommand = function(playerName, command)
	command = str_split(command, ' ', true)

	local cmdTrigger = commands[command[1]]
	if cmdTrigger then
		return cmdTrigger(playerName, command)
	end
end