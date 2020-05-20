eventFileLoaded = function(id, data)
	-- Load all maps
	maps = str_split(data, '@', true, tonumber)
	mapHashes = table_set(maps)
	table_shuffle(maps)
	totalCurrentMaps = #maps

	-- Init first map
	setGameTime(0)
end