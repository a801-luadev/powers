local commandsMeta = {
	{
		name = "help",
		hotkey = "H"
	},
	{
		name = "powers",
		hotkey = "O"
	},
	{
		name = "profile",
		hotkey = "P"
	},
	{
		name = "leaderboard",
		hotkey = "L"
	},
	{
		name = "modes"
	},

	{
		name = "pw",
		isRoomAdmin = true
	},

	{
		name = "map",
		index = "mapEditQueue",
		permission = permissions.editLocalMapQueue
	},
	{
		name = "map",
		index = "mapSaveQueue",
		permission = permissions.saveLocalMapQueue
	},
	{
		name = "review",
		permission = permissions.enableReviewMode
	},
	{
		name = "np",
		permission = permissions.enableReviewMode
	},
	{
		name = "npp",
		permission = permissions.enableReviewMode
	},

	{
		name = "msg",
		permission = permissions.sendRoomMessage
	},
	{
		name = "ban",
		permission = permissions.banUser
	},
	{
		name = "unban",
		permission = permissions.unbanUser
	},
	{
		name = "permban",
		permission = permissions.permBanUser
	},

	{
		name = "promote",
		permission = permissions.promoteUser
	},
	{
		name = "demote",
		permission = permissions.demoteUser
	}
}

local helpCommands = { }
do
	local commandStr = "%s%s<V><B>!%s</B> %s<N>- %s" -- Two first %s are ignored
	local commandAndHotkeyStr = "<V><B>%s</B> %s <B>!%s</B> %s<N>- %s"

	local commandDescriptions = getText.commandDescriptions
	local commandsParameters = getText.commandsParameters

	for cmd = 1, #commandsMeta do
		cmd = commandsMeta[cmd]

		cmd.index = cmd.index or cmd.name

		helpCommands[cmd.index] = format((cmd.hotkey and commandAndHotkeyStr or commandStr),
			(cmd.hotkey or ''), (cmd.hotkey and getText["or"] or ''), cmd.name,
			(commandsParameters[cmd.index] or ''), commandDescriptions[cmd.index] or '?')
	end
end