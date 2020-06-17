if isOfficialRoom then
	local _, roomQuery = find(tfm.get.room.name, "^%*?.?.?%-?#powers%d+()")
	if roomQuery then
		roomQuery = sub(tfm.get.room.name, roomQuery)

		for playerName in gmatch(roomQuery, "%+?%a[%w_][%w_][%w_]*#%d%d%d%d") do
			roomAdmins[strToNickname(playerName)] = true
		end
	end
end