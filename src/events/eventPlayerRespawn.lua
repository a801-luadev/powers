eventPlayerRespawn = function(playerName)
	players_remove("dead", playerName)
	players_insert("alive", playerName)
end