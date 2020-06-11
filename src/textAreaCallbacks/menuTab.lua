do
	textAreaCallbacks["menuTab"] = function(playerName, callback, cache)
		-- menuTab_{tab_id}
		callback = callback[2] * 1
		if cache.menuPage == callback then return end

		updateHelp(playerName, callback, cache)
	end
end