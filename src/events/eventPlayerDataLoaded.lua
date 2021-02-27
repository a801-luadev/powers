eventPlayerDataLoaded = function(playerName, data)
	playerData:newPlayer(playerName, data)

	local cache = playerCache[playerName]
	local playerLevel = setPlayerLevel(playerName, cache)

	if (isNoobMode and playerLevel >= 28) or (isProMode and playerLevel <= module.is_noob_until_level) then return end

	if playerLevel <= module.is_noob_until_level then
		cache.extraXp = module.extra_xp_for_noob
	end

	local badgesGenerated = false
	if playerData:get(playerName, "kills") >= 666 then
		badgesGenerated = giveBadge(playerName, "killer", cache)
	end
	if playerData:get(playerName, "victories") >= 2000 then
		badgesGenerated = giveBadge(playerName, "victorious", cache)
	end
	if playerData:get(playerName, "rounds") >= 1100 then
		badgesGenerated = giveBadge(playerName, "superPlayer", cache)
	end

	if not badgesGenerated then
		generateBadgesList(playerName, cache)
	end

	players_remove("lobby", playerName)
	players_insert("room", playerName)
end