do
	-- Gives a badge to someone
	commands["givebadge"] = function(playerName, command)
		-- !givebadge name badge_name
		if playerName ~= module.author then return end

		if not command[2] then
			return chatMessage("<BL>[<VI>•<BL>] Available badges: <V>" ..
				table_concat(badgesOrder, "</V> | <V>"), playerName)
		end

		local _, targetPlayer = validateNicknameAndGetID(command[2])
		local cache = playerCache[targetPlayer]
		if not cache then return end

		giveBadge(targetPlayer, command[3], cache, true)
	end
end