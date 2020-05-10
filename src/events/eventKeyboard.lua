eventKeyboard = function(playerName, key, isDown, x, y)
	if not playerCanTriggerEvent(playerName) then return end

	local cache = playerCache[playerName]
	cache.keySequence:insert(key)
end