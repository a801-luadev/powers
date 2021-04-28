do
	textAreaCallbacks["temporalDisturbance"] = function(playerName, cache, callback)
		if playerName ~= powers.temporalDisturbance.playerName then return end
		powers.temporalDisturbance:backInTime()
	end
end