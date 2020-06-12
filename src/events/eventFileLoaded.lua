eventFileLoaded = function(id, data)
	if id == module.data_file then
		--[[
			data[1] -> Maps
			data[2] -> Privileges
			data[3] -> Banned
		]]
		data = str_split(data, ' ', true)
		dataFileContent = data

		-- Loads all maps
		maps = str_split(tostring(data[1]), '@', true, tonumber)
		mapHashes = table_set(maps)
		table_shuffle(maps)
		totalCurrentMaps = #maps
		-- Init first map
		setGameTime(0)

		-- Loads all privileged players
		for playerId, permissions in gmatch(tostring(data[2]), "(.-)#(%d+)") do
			playersWithPrivileges[playerId] = permissions * 1
		end

		-- Loads all banned players
		for playerId, remainingTime in gmatch(tostring(data[3]), "(.-)#(%d+)") do
			bannedPlayers[playerId] = remainingTime * 1
		end
	elseif id == module.leaderboard_file then
		readLeaderboardData(data)
		writeLeaderboardData()
	end
end