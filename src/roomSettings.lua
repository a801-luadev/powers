if not room.isTribeHouse then
	local _, roomQuery = find(room.name, "^%*?.?.?%-?#powers%d+()")
	if roomQuery then
		roomQuery = sub(room.name, roomQuery)

		-- Room Admins
		for playerName in gmatch(roomQuery, "%+?%a[%w_][%w_][%w_]*#%d%d%d%d") do
			roomAdmins[strToNickname(playerName)] = true
		end

		-- Lag
		if find(roomQuery, "lagmode") then
			isLowQuality = true
		end

		-- Playground
		if find(roomQuery, "freemode") then
			isFreeMode = true -- Different message
			isReviewMode = true -- All powers enabled
		end

		if find(roomQuery, "noobmode") then -- Lvl < 28
			isNoobMode = true
		elseif find(roomQuery, "promode") then -- Lvl > 34
			isProMode = true
		end
	end
end