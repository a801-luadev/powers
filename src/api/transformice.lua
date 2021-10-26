do
	local link = linkMice
	linkMice = function(p1, p2, linked, _cache)
		_cache = _cache or playerCache[p1]
		if _cache then
			if linked then
				_cache.soulMate = p2
			else
				if _cache.soulMate and _cache.soulMate ~= p2 then
					logProcessError("LK_M", "<N>[<V>%s <N>| <V>%s <N>| <V>%s<N>]", tostring(p1),
						tostring(_cache.soulMate), tostring(p2))
				end
				_cache.soulMate = nil
			end
		end

		return link(p1, p2, linked)
	end
end

local checkMinimalistMode = function(mapCode)
	mapCode = tostring(mapCode) -- less expensive than sending disableMinimalistMode twice.

	local firstCharacter = sub(mapCode, 1, 1)
	local hasDecorations, skipChar = firstCharacter == '!', 2
	if not hasDecorations then
		hasDecorations = sub(mapCode, 2, 2) == '!'
		skipChar = 3
	end

	if hasDecorations then
		mapCode = sub(mapCode, skipChar)
	end

	disableMinimalistMode(hasDecorations)

	return mapCode ~= "nil" and mapCode or nil
end

local isMapCode = function(x)
	local strX = sub(x, 1, 1) == '@' and sub(x, 2) or x
	x = sub(strX, 1, 1) == '!' and sub(strX, 2) or strX
	return (tonumber(x) and #strX > 3), strX
end

local enablePowersTrigger = function()
	canTriggerPowers = true
	if currentMap == 2 then
		chatMessage(table_random(getText.tips))
	end
end

local setNextMapIndex = function()
	currentMap = currentMap + 1
	if currentMap > totalCurrentMaps then
		table_shuffle(maps)
		currentMap = 1
	end
end

local nextMap = function()
	nextMapLoadTentatives = nextMapLoadTentatives + 1
	if nextMapLoadTentatives == 4 then
		nextMapLoadTentatives = 0
		nextMapToLoad = nil
		setNextMapIndex()
	end

	newGame(checkMinimalistMode(nextMapToLoad or maps[currentMap]))
end

local strToNickname = function(str, checkDiscriminator)
	str = gsub(lower(str), "%a", upper, 1)
	if checkDiscriminator and not find(str, '#', 1, true) then
		str = str .. "#0000"
	end
	return str
end

local getNicknameAndDiscriminator = function(nickname)
	return sub(nickname, 1, -6), sub(nickname, -4)
end

local prettifyNickname
do
	local nicknameFormat = "<%s>%s<%s><font size='%d'>#%s</font>"

	prettifyNickname = function(nickname, discriminatorSize, discriminator, discriminatorColor,
		nicknameColor)
		if not discriminator then
			nickname, discriminator = getNicknameAndDiscriminator(nickname)
		end

		return format(nicknameFormat, (nicknameColor or 'V'), nickname, (discriminatorColor or 'G'),
			(discriminatorSize or -2), discriminator)
	end
end

local validateNicknameAndGetID = function(str)
	local targetPlayer = strToNickname(str, true)
	local targetPlayerId = room.playerList[targetPlayer]
	targetPlayerId = targetPlayerId and targetPlayerId.id
	if targetPlayerId == 0 then
		targetPlayerId = nil
	end

	return targetPlayerId, targetPlayer
end

local messagePlayersWithPrivilege = function(message)
	for playerName, data in next, room.playerList do
		if playersWithPrivileges[data.id] then
			chatMessage(message, playerName)
		end
	end
end

local messageRoomAdmins = function(message)
	for playerName in next, room.playerList do
		if roomAdmins[playerName] then
			chatMessage(message, playerName)
		end
	end
end