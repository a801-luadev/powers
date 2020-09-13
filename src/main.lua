local module = {
	author = "Bolodefchoco#0000",
	author_id = 7903955,

	id = "pw",

	min_players = 4,
	max_players = 18,

	data_file = '7',
	leaderboard_file = '8',

	default_xp = 36,
	extra_xp_in_round_seconds = 60 * 1000,
	extra_xp_in_round = 10,
	xp_on_victory = 40,
	xp_on_kill = 15,

	max_player_level = 129,
	max_player_xp = nil,

	max_leaderboard_rows = 100
}

-- Important tables
local playerCache = { }

local powers = { }

local maps = { }

local dataFileContent = {
	[1] = nil, -- Maps
	[2] = nil, -- Privileges
	[3] = nil -- Banned
}

local leaderboard = {
	loaded = false,
	total_pages = 0,

	community = { },
	id = { },
	nickname = { },
	discriminator = { },
	rounds = { },
	victories = { },
	kills = { },
	xp = { },

	full_nickname = { },
	pretty_nickname = { },

	registers = { },
	sets = { }
}

local powersSortedByLevel = { }

local playersWithPrivileges = { }

local bannedPlayers = { }

local roomAdmins = {
	[module.author] = true
}

-- Important settings
local isOfficialRoom = byte(room.name, 2) ~= 3

local canSaveData = false
local canTriggerPowers = false
local isLowQuality = false -- Rooms #powers0lag

local totalCurrentMaps, currentMap, nextMapLoadTentatives, mapHashes = 0, 0, 0
local nextMapToLoad

local hasTriggeredRoundEnd = false
local isReviewMode, isCurrentMapOnReviewMode, isFreeMode = false, false, false
local minPlayersForNextRound = 1

local isSaveDataFileScheduled = false

local resetPlayersDefaultSize = false

local Power

local isNoobMode, isProMode = false, false