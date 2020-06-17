eventTextAreaCallback = function(id, playerName, callback)
	local cache = playerCanTriggerCallback(playerName)
	if not cache then return end

	callback = str_split(callback, '_', true)

	local cbkTrigger = textAreaCallbacks[callback[1]]
	return cbkTrigger and cbkTrigger(playerName, cache, callback)
end