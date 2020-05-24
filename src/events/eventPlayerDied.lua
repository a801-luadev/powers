eventPlayerDied = function(playerName)
	if players.lobby[playerName] then return end

	players_remove("alive", playerName)
	players_insert("dead", playerName)
	removeLifeBar(playerName)
end