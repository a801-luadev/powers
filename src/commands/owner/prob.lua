do
	-- Enables/disables higher chances of divine powers in a room.
	commands["prob"] = function(playerName)
		-- !prob
		if playerName ~= module.author then return end

		isCurrentMapOnReviewMode = not isCurrentMapOnReviewMode

		chatMessage("<BL>[<VI>•<BL>] Is Current Map On Review Mode: <V>" ..
			upper(tostring(isCurrentMapOnReviewMode)))
	end
end