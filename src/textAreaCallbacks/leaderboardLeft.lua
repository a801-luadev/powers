do
	textAreaCallbacks["leaderboardLeft"] = function(playerName)
		-- leaderboardLeft
		local cache = playerCache[playerName]

		cache.leaderboardPage = cache.leaderboardPage - 1
		if cache.leaderboardPage <= 0 then
			cache.leaderboardPage = leaderboard.total_pages
		end

		displayLeaderboard(playerName, cache, cache.lastPrettyUI)
	end
end