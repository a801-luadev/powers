do
	local LAST_LOAD_TIME = time() - 62500
	local LAST_SAVE_TIME = time() - 62500

	local load = loadFile
	local save = saveFile

	loadFile = function(fileId)
		local time = time()

		local callTime = max(0, 62500 + (LAST_LOAD_TIME - time))
		unrefreshableTimer:start(load, callTime, 1, fileId)

		LAST_LOAD_TIME = time + callTime
	end

	saveFile = function(data, fileId)
		local time = time()

		local callTime = max(62500 + (LAST_SAVE_TIME - time), 0)
		unrefreshableTimer:start(save, callTime, 1, data, fileId)

		LAST_SAVE_TIME = time + callTime
	end
end

local buildAndSaveDataFile = function()
	-- Maps
	dataFileContent[1] = table_concat(maps, '@')

	-- Players with privileges
	local dataStr, counter = { }, 0
	for playerId, permissions in next, playersWithPrivileges do
		counter = counter + 1
		dataStr[counter] = playerId
		counter = counter + 1
		dataStr[counter] = permissions
	end
	dataFileContent[2] = table_concat(dataStr, '#')

	-- Banned players
	dataStr, counter = { }, 0
	for playerId, remainingTime in next, bannedPlayers do
		counter = counter + 1
		dataStr[counter] = playerId
		counter = counter + 1
		dataStr[counter] = remainingTime
	end
	dataFileContent[3] = table_concat(dataStr, '#')

	-- Save (add to the queue)
	if not isSaveDataFileScheduled then
		isSaveDataFileScheduled = true
		saveFile(table_concat(dataFileContent, ' '), module.data_file)
	end
end