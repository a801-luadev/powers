eventPlayerDied = function(playerName)
	if players.lobby[playerName] then return end

	players_remove("alive", playerName)
	players_insert("dead", playerName)
	removeLifeBar(playerName)

	if players._count.alive <= 1 then
		setGameTime(0)
	end

	local cache = playerCache[playerName]
	if cache.lastDamageBy then
		if cache.lastDamageTime > time() then
			givePlayerKill(cache.lastDamageBy)
			playerData:save(cache.lastDamageBy)
		else
			cache.lastDamageBy = nil
			cache.lastDamageTime = nil
		end
	end
end