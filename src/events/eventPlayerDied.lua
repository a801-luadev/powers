eventPlayerDied = function(playerName)
	players_remove("alive", playerName)
	players_insert("dead", playerName)

	playerCache[playerName].health = 0
	removeLifeBar(playerName)
end