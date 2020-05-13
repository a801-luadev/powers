local ownerCommands
do
	local refAbove
	ownerCommands, refAbove = collectionMetatable { }

	-- Sends an official message in the chat
	ownerCommands["msg"] = function(_, command, _, rawcmd)
		chatMessage(format(getText.ownerAnnounce, sub(rawcmd, #command[1] + 2)))
	end

	-- Manages the module maps
	ownerCommands["map"] = { }
	refAbove = ownerCommands["map"]
		refAbove.__init = function(_, command, playerName)
			local totalCurrentMaps = #maps
			if not command[3] then
				return playerName, totalCurrentMaps
			end

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

			return validMaps, totalMaps, totalCurrentMaps, playerName
		end

		-- Adds a new map
		refAbove["add"] = function(_, validMaps, totalMaps, totalCurrentMaps)
			local map
			for i = 1, totalMaps do
				map = validMaps[map]
				if not mapHashes[map] then
					maps[totalCurrentMaps + i] = map
					mapHashes[map] = true
					chatMessage(format(getText.addMap, map))
				end
			end
		end

		-- Removes a map
		refAbove["rem"] = function(_, validMaps, totalMaps, totalCurrentMaps)
			local map
			for i = 1, totalMaps do
				map = validMaps[map]
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
		refAbove["ls"] = function(_, playerName, totalCurrentMaps)
			chatMessage(format(getText.totalMaps, totalCurrentMaps, table_concat(maps, ", ")),
				playerName)
		end

		-- Saves the map queue
		refAbove["save"] = function(_, playerName, totalCurrentMaps)
			if totalCurrentMaps == 0 then return end

			local data = table_concat(maps, '@')
			saveFile(data, module.map_file)

			refAbove["ls"](_, playerName, totalCurrentMaps)
		end
end