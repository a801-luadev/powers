eventFileSaved = function(fileId)
	if fileId == module.data_file then
		isSaveDataFileScheduled = false
	elseif fileId == module.leaderboard_file then
		loadFile(fileId)
	end
end