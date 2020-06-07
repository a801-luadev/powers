do
	textAreaCallbacks["closeInterface"] = function(playerName, _, _cache)
		-- closeInterface
		_cache = _cache or playerCache[playerName]

		if not _cache.isInterfaceOpen then return end
		_cache.isInterfaceOpen = false

		local prettyUIs = _cache.prettyUIs

		_cache.lastPrettyUI = nil
		for u = 1, _cache.totalPrettyUIs do
			if prettyUIs[u] then
				prettyUIs[u]:remove()
			end
		end

		_cache.prettyUIs = { }
		_cache.totalPrettyUIs = 0

		_cache.menuTabs = { }
		_cache.powerInfoIdSelected = nil
		_cache.powerInfoSelectionImageId = nil

		_cache.isHelpOpen = false
		_cache.isPowersOpen = false
		_cache.isProfileOpen = false
		_cache.isLeaderboardOpen = false
	end
end