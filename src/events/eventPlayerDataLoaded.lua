eventPlayerDataLoaded = function(playerName, data)
	playerData:newPlayer(playerName, data)

	local cache = playerCache[playerName]
	local playerLevel = setPlayerLevel(playerName, cache)

	if (isNoobMode and playerLevel >= 28) or (isProMode and playerLevel <= 34) then return end

	if playerData:get(playerName, "kills") >= 666 then
		giveBadge(playerName, "killer", cache)
	else
		generateBadgesList(playerName, cache)
	end

	players_remove("lobby", playerName)
	players_insert("room", playerName)
end