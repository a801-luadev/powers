eventMouse = function(playerName, x, y)
	if not playerCanTriggerEvent(playerName) then return end

	local time = time()
	local cache = playerCache[playerName]

	local src = Power.__mouse
	for power = 1, Power.__eventCount.__mouse do
		power = src[power]

		if power:trigger(playerName, cache, time, x, y) then
			return
		end
	end
end