do
	-- Enables/disables status in a room.
	commands["status"] = function(playerName)
		-- !status
		if playerName ~= module.author then return end

		isOfficialRoom = not isOfficialRoom

		chatMessage("<BL>[<VI>•<BL>] Is Official Room: <V>" .. upper(tostring(isOfficialRoom)))
	end
end