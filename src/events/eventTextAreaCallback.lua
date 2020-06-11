eventTextAreaCallback = function(id, playerName, callback)
	local cache = playerCache[playerName]
	local time = time()

	if time > cache.interfaceActionCooldown then return end
	cache.interfaceActionCooldown = time + 1000

	callback = str_split(callback, '_', true)

	local cbkTrigger = textAreaCallbacks[callback[1]]
	return cbkTrigger and cbkTrigger(playerName, cache, callback)
end