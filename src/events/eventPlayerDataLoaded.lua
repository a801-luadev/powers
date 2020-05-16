eventPlayerDataLoaded = function(playerName, data)
	playerData:newPlayer(playerName, data)

	playerCache[playerName].hasPlayerData = true
end