eventFileLoaded = function(id, data)
	if id == module.map_file then
		-- Load all maps
		maps = str_split(data, '@', true, tonumber)
		mapHashes = table_set(maps)
		table_shuffle(maps)
		totalCurrentMaps = #maps

		-- Init first map
		setGameTime(0)
	elseif id == module.leaderboard_file then
		readLeaderboardBString(data)
		writeLeaderboardBString()
	end
end