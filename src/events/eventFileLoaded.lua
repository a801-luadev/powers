eventFileLoaded = function(id, data)
	-- Map load
	data = str_split(data, '@', true)
	mapHashes = table_set(data)
	table_shuffle(data)
	totalCurrentMaps = #data
end