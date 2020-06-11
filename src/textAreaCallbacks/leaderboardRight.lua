do
	textAreaCallbacks["leaderboardRight"] = function(playerName, cache)
		-- leaderboardRight
		cache.leaderboardPage = cache.leaderboardPage + 1
		if cache.leaderboardPage >= leaderboard.total_pages then
			cache.leaderboardPage = 1
		end

		displayLeaderboard(playerName, cache, cache.lastPrettyUI)
	end
end