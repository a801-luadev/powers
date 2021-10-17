eventKeyboard = function(playerName, key, isDown, x, y)
	local cache = playerCache[playerName]

	if key == 0 then
		cache.isFacingRight = false
	elseif key == 2 then
		cache.isFacingRight = true
	elseif keyboardCallbacks[key] then
		if playerCanTriggerCallback(playerName, cache, key == keyboard.G) then
			keyboardCallbacks[key](playerName, cache, isDown)
		end
		return
	end

	local time = playerCanTriggerEvent(playerName, cache)
	if not time then return end

	local playerKs = cache.keySequence
	playerKs:insert(key)

	local playerPowers = cache.powers

	local matchCombo = false
	local src = Power.__keyboard
	for power = 1, Power.__eventCount.__keyboard do
		power = src[power]
		if playerPowers[power.name] then
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
end