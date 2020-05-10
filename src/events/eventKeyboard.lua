eventKeyboard = function(playerName, key, isDown, x, y)
	if not playerCanTriggerEvent(playerName) then return end

	local cache = playerCache[playerName]

	local playerKs = cache.keySequence
	playerKs:insert(key)

	local time = time()

	local matchCombo = false
	local src = Power.__keyboard
	for power = 1, Power.__eventCount.__keyboard do
		power = src[power]

		-- Not internal, must be explicit
		if power.triggererKey then
			matchCombo = (key == power.triggererKey)
		else
			local powerKs = power.keySequences
			for ks = 1, power.totalKeySequences do
				if playerKs:isEqual(powerKs[ks]) then
					matchCombo = true
					break
				end
			end
		end

		if matchCombo then
			return power:trigger(playerName, cache, time, x, y)
		end
	end
end