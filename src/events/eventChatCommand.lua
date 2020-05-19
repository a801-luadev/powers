eventChatCommand = function(playerName, command)
	local rawcmd = command
	command = str_split(command, ' ', true)

	local cmdTrigger = commands[command[1]]
	if cmdTrigger then
		return cmdTrigger(playerName, command, rawcmd)
	end

	-- Owner commands
	if playerName == module.author then
		local cmdTrigger = ownerCommands[command[1]]
		return cmdTrigger and cmdTrigger(playerName, command, rawcmd)
	end
end