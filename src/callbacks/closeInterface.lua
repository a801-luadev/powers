do
	callbacks["closeInterface"] = function(playerName)
		-- closeInterface
		local cache = playerCache[playerName]
		local prettyUIs = cache.prettyUIs

		for u = 1, cache.totalPrettyUIs do
			if prettyUIs[u] then
				prettyUIs[u]:remove()
			end
		end

		cache.prettyUIs = { }
		cache.totalPrettyUIs = 0
		cache.lastPrettyUI = nil
	end
end