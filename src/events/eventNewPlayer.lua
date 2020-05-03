eventNewPlayer = function(playerName)
	if not playerCache[playerName] then
		playerCache[playerName] = {
			powers = { }
		}
	end

	players_insert(players.room, playerName)
	players_insert(players.dead, playerName)

	tfm.exec.lowerSyncDelay(playerName)

	for _, power in next, powers do
		if power.bind then
			power.bind(playerCache)
		end
	end
end