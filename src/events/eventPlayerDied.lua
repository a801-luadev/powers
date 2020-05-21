eventPlayerDied = function(playerName)
	players_remove("alive", playerName)
	players_insert("dead", playerName)

	removeLifeBar(playerName)
end