local players = {
	room  = { },
	alive = { },
	dead  = { },
	lobby = { },
	_count = {
		room = 0,
		alive = 0,
		dead = 0,
		lobby = 0
	}
}

local players_insert = function(where, playerName)
	if not players[where][playerName] then
		players._count[where] = players._count[where] + 1
		players[where][playerName] = playerName
	end
end

local players_remove = function(where, playerName)
	if players[where][playerName] then
		players._count[where] = players._count[where] - 1
		players[where][playerName] = nil
	end
end

local players_remove_all = function(playerName)
	for k, v in next, players do
		if k ~= "_count" then
			players_remove(k, playerName)
		end
	end
end

local enablePowersTrigger = function()
	canTriggerPowers = true
end

local playerCanTriggerEvent = function(playerName, noCooldown)
	local time = time()
	local cache = playerCache[playerName]

	if not noCooldown and cache.powerCooldown > time then return end

	if canTriggerPowers and not tfm.get.room.playerList[playerName].isDead then
		return time, cache
	end
end

local giveExperience = function()
	for playerName in next, players.alive do
		playerData
			:set(playerName, "xp", module.extra_xp_in_round, true)
			:save(playerName)
	end
end