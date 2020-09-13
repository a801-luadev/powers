do
	commands["profile"] = function(playerName, command)
		command[2] = command[2] and strToNickname(command[2]) or playerName
		if playerCache[command[2]] and
			not bannedPlayers[room.playerList[command[2]].id] then
			displayProfile(playerName, command[2], cache)
		end
	end
end