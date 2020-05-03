eventPlayerRespawn = function(playerName)
	players_remove(players.dead, playerName)
	players_insert(players.alive, playerName)
end