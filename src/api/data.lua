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
		dataStr[counter] = format("%x", permissions) -- Saves space
	end
	dataFileContent[2] = table_concat(dataStr, '#')

	-- Banned players
	dataStr, counter = { }, 0
	for playerId, remainingTime in next, bannedPlayers do
		counter = counter + 1
		dataStr[counter] = playerId
		counter = counter + 1
		dataStr[counter] = format("%x", remainingTime / (60 * 60 * 1000)) -- Saves space
	end
	dataFileContent[3] = table_concat(dataStr, '#')

	-- Save (add to the queue)
	if not isSaveDataFileScheduled then
		isSaveDataFileScheduled = true
		saveFile(table_concat(dataFileContent, ' '), module.data_file)
	end
end

local parseDataFile = function(data)
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
	for playerId, permissions in gmatch(tostring(data[2]), "(%d+)#(%x+)") do
		playersWithPrivileges[playerId * 1] = tonumber(permissions, 16)
	end

	-- Loads all banned players
	for playerId, remainingTime in gmatch(tostring(data[3]), "(%d+)#(%x+)") do
		bannedPlayers[playerId * 1] = tonumber(remainingTime, 16) * (60 * 60 * 1000)
	end
	-- Horizontal ban check
	for playerName, data in next, tfm.get.room.playerList do
		local data = bannedPlayers[data.id]
		if data then
			players_lobby(playerName)
			warnBanMessage(playerName, data)
		end
	end
end