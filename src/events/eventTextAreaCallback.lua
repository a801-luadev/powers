eventTextAreaCallback = function(id, playerName, callback)
	callback = str_split(callback, '_', true)

	local cbkTrigger = textAreaCallbacks[callback[1]]
	return cbkTrigger and cbkTrigger(playerName, callback)
end