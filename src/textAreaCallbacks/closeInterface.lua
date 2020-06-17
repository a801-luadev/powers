do
	textAreaCallbacks["closeInterface"] = function(playerName, cache)
		-- closeInterface
		if not cache.isInterfaceOpen then return end
		cache.isInterfaceOpen = false

		local prettyUIs = cache.prettyUIs

		cache.lastPrettyUI = nil
		for u = 1, cache.totalPrettyUIs do
			if prettyUIs[u] then
				prettyUIs[u]:remove()
			end
		end

		cache.prettyUIs = { }
		cache.totalPrettyUIs = 0

		cache.helpTabs = { }
		cache.powerInfoIdSelected = nil
		cache.powerInfoSelectionImageId = nil

		cache.isHelpOpen = false
		cache.isPowersOpen = false
		cache.isProfileOpen = false
		cache.isLeaderboardOpen = false
	end
end