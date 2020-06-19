do
	local internalMessageFormat = "<BL>[<VI>•<BL>] Data of %s<BL> has been set to {%d,%d,%d,%d}"

	-- Sets the data of a player
	commands["setdata"] = function(playerName, command)
		if playerName ~= module.author then return end

		local _, targetPlayer = validateNicknameAndGetID(command[2])
		local targetData = playerData.playerData[targetPlayer]
		if not targetData then return end

		local dataStructure = playerData.structure

		targetData.rounds = tonumber(command[3]) or dataStructure.rounds.default
		targetData.victories = tonumber(command[4]) or dataStructure.victories.default
		targetData.kills = tonumber(command[5]) or dataStructure.kills.default
		targetData.xp = tonumber(command[6]) or dataStructure.xp.default

		playerData:save(targetPlayer, true)

		messagePlayersWithPrivilege(format(internalMessageFormat,
			playerCache[targetPlayer].chatNickname, targetData.rounds, targetData.victories,
			targetData.kills, targetData.xp))
	end
end