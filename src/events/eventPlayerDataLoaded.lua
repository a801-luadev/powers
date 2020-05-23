eventPlayerDataLoaded = function(playerName, data)
	playerData:newPlayer(playerName, data)

	local cache = playerCache[playerName]
	setPlayerLevel(playerName, cache)

	cache.hasPlayerData = true
end