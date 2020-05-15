eventChatCommand = function(playerName, command)
	local rawcmd = command
	command = str_split(command, ' ', true)

	-- Owner commands
	if playerName == module.author then
		local cmdTrigger = ownerCommands[command[1]]
		return cmdTrigger and cmdTrigger(playerName, command, rawcmd)
	end
end