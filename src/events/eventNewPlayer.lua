eventNewPlayer = function(playerName)
	if not playerCache[playerName] then
		playerCache[playerName] = {
			health = 0,
			isFacingRight = true,
			powers = { },
			extraHealth = 0,
			powerCooldown = 0,
			soulMate = nil
		}
	end

	players_insert("room", playerName)
	players_insert("dead", playerName)

	tfm.exec.lowerSyncDelay(playerName)

	for _, power in next, powers do
		if power.bind then
			power.bind(playerCache)
		end
	end
end