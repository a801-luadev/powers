eventPlayerDied = function(playerName)
	players_remove(players.alive, playerName)
	players_insert(players.dead, playerName)
end