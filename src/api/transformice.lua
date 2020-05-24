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

local setNextMapIndex = function()
	currentMap = currentMap + 1
	if currentMap >= totalCurrentMaps then
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