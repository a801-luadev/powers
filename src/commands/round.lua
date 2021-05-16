do
	commands["round"] = function(playerName, command)
		local data = players[command[2]]
		local count = players._count[command[2]]

		if not (data and count) then return end

		local names, index, tmpPlayerList = { }, 0
		for name in next, data do
			tmpPlayerList = room.playerList[name]

			index = index + 1
			names[index] = name ..
				(tmpPlayerList and format(" (%s,%s)", tmpPlayerList.x, tmpPlayerList.y) or '')
		end

		chatMessage(format("<BL>[<VI>•<BL>] <V>Round %s <ROSE>(#%s):<BL>\n\t%s", command[2], count,
			table_concat(names, "\n\t")), playerName)
	end
end