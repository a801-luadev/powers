do
	keyboardCallbacks[keyboard.P] = function(playerName, cache, _, targetPlayer)
		if cache.isProfileOpen then
			textAreaCallbacks["closeInterface"](playerName, cache)
		else
			targetPlayer = targetPlayer or playerName
			if playerCache[targetPlayer] and
				not bannedPlayers[tfm.get.room.playerList[targetPlayer].id] then
				displayProfile(playerName, targetPlayer, cache)
			end
		end
	end
end