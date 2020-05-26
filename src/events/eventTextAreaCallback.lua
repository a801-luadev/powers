eventTextAreaCallback = function(id, playerName, callback)
	callback = str_split(callback, '_', true)

	local cbkTrigger = callbacks[callback[1]]
	return cbkTrigger and cbkTrigger(playerName, callback, id)
end