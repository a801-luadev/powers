local logCommandUsage
do
	local internalMessageFormat = "<BL>[<VI>•<BL>] %s <BL>[%s] → %s"

	logCommandUsage = function(playerName, command)
		messagePlayersWithPrivilege(format(internalMessageFormat,
			playerCache[playerName].chatNickname, command[1],
			table_concat(command, ' ', 2, min(#command, 5))))
	end
end