local totalCurrentMaps, maps, mapHashes = 0
local currentMap = 0

local canLoadNextMap, nextMapLoadTentatives = false, 0

local setNextMapIndex = function()
	currentMap = currentMap + 1
	if currentMap == totalCurrentMaps then
		table_shuffle(maps)
		currentMap = 1
	end
end

system.loadFile(module.map_file)