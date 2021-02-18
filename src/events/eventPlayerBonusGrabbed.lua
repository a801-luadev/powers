eventPlayerBonusGrabbed = function(playerName, id)
	removeImage(id)

	local time, cache = playerCanTriggerEvent(playerName)
	if not time then return end

	if not cache.spawnHearts then return end -- hack?

	addHealth(playerName, cache, powers.soulSucker.healthPoints)
end