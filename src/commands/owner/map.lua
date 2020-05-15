do
	local noArgMethod = { }
	local argMethod = { }

	-- Manages the module maps
	ownerCommands["map"] = function(playerName, command)
		if not command[2] then return end

		local totalCurrentMaps = #maps
		if not command[3] then
			if noArgMethod[command[2]] then
				noArgMethod[command[2]](playerName, totalCurrentMaps)
				return
			end
		end

		if not argMethod[command[2]] then return end

		local entries, totalEntries = str_split(command[3], "[, ]+")

		local validMaps, totalMaps, tmpMapCode, tmpIsMapCode = { }, 0
		for i = 1, totalEntries do
			tmpIsMapCode, tmpMapCode = isMapCode(entries[i])
			if tmpIsMapCode then
				totalMaps = totalMaps + 1
				validMaps[totalMaps] = tmpMapCode
			end
		end
		if totalMaps == 0 then return end

		argMethod[command[2]](validMaps, totalMaps, totalCurrentMaps)
	end

	-- Adds a new map
	argMethod["add"] = function(validMaps, totalMaps, totalCurrentMaps)
		local map
		for i = 1, totalMaps do
			map = validMaps[i]
			if not mapHashes[map] then
				maps[totalCurrentMaps + i] = map
				mapHashes[map] = true
				chatMessage(format(getText.addMap, map))
			end
		end
	end

	-- Removes a map
	argMethod["rem"] = function()
		local map
		for i = 1, totalMaps do
			map = validMaps[isMapCode]
			if mapHashes[map] then
				for m = 1, totalCurrentMaps do
					if maps[m] == map then
						table_remove(maps, m)
						break
					end
				end

				mapHashes[map] = nil
				chatMessage(format(getText.remMap, map))
			end
		end
	end

	-- Displays the map queue
	noArgMethod["ls"] = function(playerName, totalCurrentMaps)
		chatMessage(format(getText.totalMaps, totalCurrentMaps, table_concat(maps, ", ")),
			playerName)
	end

	-- Saves the map queue
	noArgMethod["save"] = function(playerName, totalCurrentMaps)
		if totalCurrentMaps == 0 then return end
		local data = table_concat(maps, '@')

		saveFile(data, module.map_file)
		noArgMethod["ls"](playerName, totalCurrentMaps)
	end
end