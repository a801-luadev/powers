local module = {
	author = "Bolodefchoco#0000",
	id = "pw",
	min_players = 4,
	max_players = 18,
	map_file = 7
}

local playerCache = { }

local isLowQuality = false
local lowQualityCounter = 0

local refreshedTimers = false

local canTriggerPowers = false