do
	local subCommand = { }
	local subCommandPermission = { }

	local hasQueueChanged = false

	-- Manages the module maps
	commands["map"] = function(playerName, command)
		if totalCurrentMaps == 0 or not command[2] and dataFileContent[1] then return end

		if subCommand[command[2]] then
			local permission = subCommandPermission[command[2]]
			if not permission or hasPermission(playerName, permission) then
				subCommand[command[2]](playerName, command)

				if permission then
					logCommandUsage(playerName, command)
				end
			end
		end
	end

	local getValidMaps = function(subParameter)
		local validMaps, totalMaps, tmpMapCode, tmpIsMapCode = { }, 0
		for i = 3, #subParameter do
			tmpIsMapCode, tmpMapCode = isMapCode(subParameter[i])
			if tmpIsMapCode then
				totalMaps = totalMaps + 1
				validMaps[totalMaps] = tmpMapCode
			end
		end

		return totalMaps > 0, validMaps, totalMaps
	end

	-- Adds a new map
	subCommandPermission["add"] = permissions.editLocalMapQueue
	subCommand["add"] = function(playerName, command)
		local hasMaps, validMaps, totalMaps = getValidMaps(command)
		if not hasMaps then return end

		local map
		for i = 1, totalMaps do
			map = validMaps[i]
			if not mapHashes[map] then
				totalCurrentMaps = totalCurrentMaps + 1
				maps[totalCurrentMaps] = map
				mapHashes[map] = true
				hasQueueChanged = true
				chatMessage(format(getText.addMap, map))
			end
		end
	end

	-- Removes a map
	subCommandPermission["rem"] = permissions.editLocalMapQueue
	subCommand["rem"] = function(playerName, command)
		local hasMaps, validMaps, totalMaps = getValidMaps(command)
		if not hasMaps then return end

		local map
		for i = 1, totalMaps do
			map = validMaps[i]
			if mapHashes[map] then
				for m = 1, totalCurrentMaps do
					if maps[m] == map then
						totalCurrentMaps = totalCurrentMaps - 1
						table_remove(maps, m)
						break
					end
				end

				mapHashes[map] = nil
				hasQueueChanged = true
				chatMessage(format(getText.remMap, map))
			end
		end
	end

	-- Displays the map queue
	subCommand["ls"] = function(playerName)
		chatMessage(format(getText.listMaps, totalCurrentMaps, "@" .. table_concat(maps, ", @")),
			playerName)
	end

	-- Saves the map queue
	subCommandPermission["save"] = permissions.saveLocalMapQueue
	subCommand["save"] = function(playerName)
		if not hasQueueChanged then return end
		hasQueueChanged = false
		buildAndSaveDataFile()
		subCommand["ls"](playerName)
	end
end