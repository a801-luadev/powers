eventChatMessage = function(playerName, message)
	local time, cache = playerCanTriggerEvent(playerName)
	if not time then return end

	local src = Power.__chatMessage
	for power = 1, Power.__eventCount.__chatMessage do
		power = src[power]

		-- Not internal, must be explicit
		if find(message, power.messagePattern) then
			return power:trigger(playerName, cache, time)
		end
	end
end