do
	-- Gives a badge to someone
	commands["givebadge"] = function(playerName, command)
		if playerName ~= module.author then return end

		local _, targetPlayer = validateNicknameAndGetID(command[2])
		local cache = playerCache[targetPlayer]
		if not cache then return end

		giveBadge(targetPlayer, command[3], cache, true)
	end
end