eventNewGame = function()
	players.dead = { _count = 0 }
	players.alive = table_copy(players.room)

	local currentTime = os.time()
	for playerName in next, players.alive do
		playerName = playerCache[playerName].powers
		for name, obj in next, powers do
			playerName[name] = obj:getNewPlayerData(currentTime)
		end
	end
end