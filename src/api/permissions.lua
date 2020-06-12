local hasPermission = function(playerName, permission)
	local playerId = tfm.get.room.playerList[playerName].id
	return playersWithPrivileges[playerId] and band(permission, playersWithPrivileges[playerId]) > 0
end