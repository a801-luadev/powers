do
	textAreaCallbacks["temporalDisturbance"] = function(playerName, cache, callback)
		if playerName == powers.temporalDisturbance.playerName then
			powers.temporalDisturbance:backInTime()
		else
			commands["ban"](nil,
				{ nil, playerName, 24, "[auto] attempt to trigger unavailable power" })
		end
	end
end