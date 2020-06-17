do
	textAreaCallbacks["helpTab"] = function(playerName, cache, callback)
		-- helpTab_{tab_id}
		callback = callback[2] * 1
		if cache.helpPage == callback then return end

		updateHelp(playerName, callback, cache)
	end
end