eventFileLoaded = function(id, data)
	if id == module.data_file then
		parseDataFile(data)
	elseif id == module.leaderboard_file then
		readLeaderboardData(data)
		writeLeaderboardData()
	end
end