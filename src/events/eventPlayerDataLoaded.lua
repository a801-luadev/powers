eventPlayerDataLoaded = function(playerName, data)
	playerData:newPlayer(playerName, data)

	local cache = playerCache[playerName]
	setPlayerLevel(playerName, cache)

	players_remove("lobby", playerName)
	players_insert("room", playerName)
end