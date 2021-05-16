do
	-- Limited to 30s.
	local LAST_LOAD_TIME = time() - 32500
	local LAST_SAVE_TIME = time() - 32500

	local load = loadFile
	local save = saveFile

	loadFile = function(fileId)
		local time = time()

		local callTime = max(0, 32500 + (LAST_LOAD_TIME - time))
		unrefreshableTimer:start(load, callTime, 1, fileId)

		LAST_LOAD_TIME = time + callTime
	end

	saveFile = function(data, fileId)
		local time = time()

		local callTime = max(32500 + (LAST_SAVE_TIME - time), 0)
		unrefreshableTimer:start(save, callTime, 1, data, fileId)

		LAST_SAVE_TIME = time + callTime
	end
end

-- Commands
local generateCommandHelp = function(playerId, playerName)
	local playerPermissions = playersWithPrivileges[playerId] or 0
	local isModuleOwner = playerName == module.author

	local commands, totalCommands = { }, 0
	for cmd = 1, #commandsMeta do
		cmd = commandsMeta[cmd]

		if (not cmd.permission or hasPermission(nil, cmd.permission, nil, playerPermissions))
			and (not cmd.isRoomAdmin or roomAdmins[playerName])
			and (not cmd.isModuleOwner or isModuleOwner) then
			totalCommands = totalCommands + 1
			commands[totalCommands] = helpCommands[cmd.index]
		end
	end

	return table_concat(commands, '\n')
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
		dataStr[counter] = format("%x", remainingTime) -- Saves space
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
	maps = str_split(tostring(data[1]), '@', true)
	mapHashes = table_set(maps)
	table_shuffle(maps)
	totalCurrentMaps = #maps
	-- Init first map
	setGameTime(0)

	-- Loads all privileged players
	data[2] = data[2] or ''
	for playerId, permissions in gmatch(data[2], "(%d+)#(%x+)") do
		playersWithPrivileges[playerId * 1] = tonumber(permissions, 16)
	end

	-- Loads all banned players
	data[3] = data[3] or ''
	for playerId, remainingTime in gmatch(data[3], "(%d+)#(%x+)") do
		bannedPlayers[playerId * 1] = tonumber(remainingTime, 16)
	end

	-- Horizontal (un)ban and commands check
	local fileHasChanged = false

	local time, banTime = time()
	for playerName, data in next, room.playerList do
		banTime = bannedPlayers[data.id]
		if banTime then
			if time > banTime then
				bannedPlayers[data.id] = nil
				fileHasChanged = true
			else
				players_lobby(playerName)
				warnBanMessage(playerName, banTime)
			end
		elseif playerCache[playerName] then
			playerCache[playerName].commands = generateCommandHelp(data.id, playerName)
			keyboardCallbacks[keyboard.H](playerName, playerCache[playerName])
		end
	end

	if fileHasChanged then
		buildAndSaveDataFile()
	end
end