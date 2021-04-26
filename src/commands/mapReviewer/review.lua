do
	-- Enables/disables the review mode
	commands["review"] = function(playerName, command)
		if not hasPermission(playerName, permissions.enableReviewMode)
			or nextMapToLoad or isFreeMode then return end -- Can't change state when !npp is active

		isReviewMode = not isReviewMode
		if isReviewMode then
			chatMessage(getText.enableReviewMode)
		else
			chatMessage(getText.disableReviewMode)
		end

		logCommandUsage(playerName, command)
	end
end