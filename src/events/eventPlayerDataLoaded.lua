eventPlayerDataLoaded = function(playerName, data)
	playerData:newPlayer(playerName, data)

	local cache = playerCache[playerName]
	local playerLevel = setPlayerLevel(playerName, cache)

	if (isNoobMode and playerLevel >= 28) or (isProMode and playerLevel <= 34) then return end

	local badgesGenerated = false
	if playerData:get(playerName, "kills") >= 666 then
		badgesGenerated = giveBadge(playerName, "killer", cache)
	end
	if not badgesGenerated then
		generateBadgesList(playerName, cache)
	end

	players_remove("lobby", playerName)
	players_insert("room", playerName)
end