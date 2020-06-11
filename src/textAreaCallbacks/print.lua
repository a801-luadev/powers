do
	textAreaCallbacks["print"] = function(playerName, _, callback)
		-- print_{url}
		chatMessage("https://" .. callback[2], playerName)
	end
end