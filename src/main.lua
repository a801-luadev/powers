local module = {
	author = "Bolodefchoco#0015",
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
	extra_xp_for_noob = 50,

	is_noob_until_level = 34,

	max_player_level_interface = 666,
	max_player_xp = nil,
	max_player_level = 139,

	max_leaderboard_rows = 100,

	new_game_cooldown = 0,

	leaderboard_total_pages = 0,
	powers_total_pages = 0
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
local isOfficialRoom = not room.isTribeHouse and find(room.name, "^[^@][^#]*#powers%d?$")

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

local logProcessError