do
	local link = linkMice
	linkMice = function(p1, p2, linked)
		if linked then
			playerCache[p1].soulMate = p2
		else
			playerCache[p1].soulMate = nil
		end

		return link(p1, p2, linked)
	end
end

local isMapCode = function(x)
	if sub(x, 1, 1) == '@' then
		x = sub(x, 2)
	end

	local str = x
	x = tonumber(x)
	return (not not x and #str > 3), x
end

local enablePowersTrigger = function()
	canTriggerPowers = true
	if currentMap == 2 then
		chatMessage(getText.enableParticles)
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
	if isLobby then
		if not wasLobby then
			newGame(module.lobbyMap)
		end
		return
	end

	nextMapLoadTentatives = nextMapLoadTentatives + 1
	if nextMapLoadTentatives == 4 then
		nextMapLoadTentatives = 0
		setNextMapIndex()
	end

	newGame(maps[currentMap])
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
			(discriminatorSize or 10), discriminator)
	end
end

local validateNicknameAndGetID = function(str)
	local targetPlayer = strToNickname(str, true)
	local targetPlayerId = tfm.get.room.playerList[targetPlayer]
	targetPlayerId = targetPlayerId and targetPlayerId.id
	if targetPlayerId == 0 then
		targetPlayerId = nil
	end

	return targetPlayerId, targetPlayer
end

local messagePlayersWithPrivilege = function(message)
	for playerName, data in next, tfm.get.room.playerList do
		if playersWithPrivileges[data.id] then
			chatMessage(message, playerName)
		end
	end
end