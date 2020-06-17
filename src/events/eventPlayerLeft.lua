eventPlayerLeft = function(playerName)
	players_remove_all(playerName)
	playerCache[playerName] = nil
end