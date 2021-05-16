local logCommandUsage = function(playerName, command)
	messagePlayersWithPrivilege(format("<BL>[<VI>•<BL>] %s <BL>[%s] → %s",
		playerCache[playerName].chatNickname, command[1],
		table_concat(command, ' ', 2, min(#command, 5))))
end

logProcessError = function(id, message, ...)
	chatMessage(format("<ROSE><B>/c %s #powers glitch [%s] → %s</B> %s\n<S>%s", module.author,
		room.name, id, format(message, ...), debug.traceback()))
end