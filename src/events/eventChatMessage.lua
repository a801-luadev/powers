eventChatMessage = function(playerName, message)
	if not playerCanTriggerEvent(playerName) then return end

	local time = time()
	local cache = playerCache[playerName]

	local src = Power.__chatMessage
	for power = 1, Power.__eventCount.__chatMessage do
		power = src[power]

		-- Not internal, must be explicit
		if find(message, power.messagePattern) then
			return power:trigger(playerName, cache, time, nil, nil, true)
		end
	end
end