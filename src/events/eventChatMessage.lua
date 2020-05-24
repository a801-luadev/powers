eventChatMessage = function(playerName, message)
	local time, cache = playerCanTriggerEvent(playerName)
	if not time then return end

	local playerPowers = cache.powers

	local src = Power.__chatMessage
	for power = 1, Power.__eventCount.__chatMessage do
		power = src[power]

		-- Not internal, must be explicit
		if playerPowers[power.name] and find(message, power.messagePattern) then
			return power:trigger(playerName, cache, time)
		end
	end
end