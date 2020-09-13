local getPlayersOnFilter = function(except, filter, ...)
	local data = { }

	local player
	for playerName in next, players.alive do
		if playerName ~= except then
			player = room.playerList[playerName]
			if filter(player.x, player.y, ...) then
				data[playerName] = playerCache[playerName]
			end
		end
	end

	return data
end