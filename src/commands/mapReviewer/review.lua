do
	-- Enables/disables the review mode
	commands["review"] = function(playerName)
		if not hasPermission(playerName, permissions.enableReviewMode) then return end

		isReviewMode = not isReviewMode
		if isReviewMode then
			chatMessage(getText.enableReviewMode)
		else
			chatMessage(getText.disableReviewMode)
		end
	end
end