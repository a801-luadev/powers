local hasPermission = function(playerName, permission, _playerId, _playerPermissions)
	_playerId = _playerPermissions or _playerId or room.playerList[playerName].id
	_playerPermissions = _playerPermissions or playersWithPrivileges[_playerId]

	-- p & t > 0
	return _playerPermissions and band(permission, _playerPermissions) > 0
end

local addPermission = function(playerName, permission, _playerId)
	_playerId = _playerId or room.playerList[playerName].id

	local oldPerms = playersWithPrivileges[_playerId]
	if not oldPerms then
		playersWithPrivileges[_playerId] = 0
		oldPerms = 0
	end

	-- t | p
	local currentPerms = bor(playersWithPrivileges[_playerId], permission)
	playersWithPrivileges[_playerId] = currentPerms

	return oldPerms ~= currentPerms
end

local removePermission = function(playerName, permission, _playerId)
	_playerId = _playerId or room.playerList[playerName].id

	local oldPerms = playersWithPrivileges[_playerId]
	-- t & ~p
	local currentPerms = band(playersWithPrivileges[_playerId], bnot(permission))
	playersWithPrivileges[_playerId] = (currentPerms > 0 and currentPerms or nil)

	return oldPerms ~= currentPerms
end