eventPlayerDied = function(playerName)
	if players.lobby[playerName] then return end

	players_remove("alive", playerName)
	players_insert("dead", playerName)
	removeLifeBar(playerName)

	if players._count.alive <= 1 then
		setGameTime(0)
	end

	local cache = playerCache[playerName]
	if cache then
		cache.mouseSkill = 1

		if not cache.lastDamageBy then return end

		if cache.lastDamageTime > time() then
			givePlayerKill(cache.lastDamageBy, playerName, cache)
			playerData:save(cache.lastDamageBy)
		else
			cache.lastDamageBy = nil
			cache.lastDamageTime = nil
		end
	end
end