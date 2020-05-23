eventPlayerDataLoaded = function(playerName, data)
	playerData:newPlayer(playerName, data)

	local cache = playerCache[playerName]
	cache.level = xpToLvl(playerData:get(playerName, "xp"))
	cache.hasPlayerData = true
end