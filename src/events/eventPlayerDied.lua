eventPlayerDied = function(playerName)
	if not players.lobby[playerName] then
		players_remove("alive", playerName)
		players_insert("dead", playerName)
		removeLifeBar(playerName)
	end
end