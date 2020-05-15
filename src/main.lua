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

local hasTriggeredRoundEnd = false

local canTriggerPowers = false
local resetPlayersDefaultSize = false

local totalPlayersInRound = 0
local canSaveData = false