do
	-- Gives a badge to someone
	command["givebadge"] = function(playerName, command)
		if playerName ~= module.author then return end

		local _, targetPlayer = validateNicknameAndGetID(command[2])
		if not playerCache[targetPlayer] then return end

		giveBadge(targetPlayer, command[3], true)
	end
end