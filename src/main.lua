local module = {
	author = "Bolodefchoco#0000",
	id = "pw",

	min_players = 4,
	max_players = 18,

	map_file = 7,

	extra_xp_in_round_seconds = 60 * 1000,
	extra_xp_in_round = 10,
	xp_on_victory = 40,
	xp_on_kill = 15,

	max_player_level = 129,
	max_player_xp = nil
}

local isOfficialRoom = byte(tfm.get.room.name, 2) ~= 3

local playerCache = { }

local powers, Power = { }

local isLowQuality = false
local lowQualityCounter = 0

local hasTriggeredRoundEnd = false

local canTriggerPowers = false
local resetPlayersDefaultSize = false

local canSaveData = false

local maps, totalCurrentMaps, mapHashes = { }, 0
local currentMap = 0
local nextMapLoadTentatives = 0

local ignoreRoundData = true