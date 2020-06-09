local readLeaderboardBString = function(bString)
	bString = byteArray.new(bString)

	local community, id, nickname, discriminator, rounds, victories, kills, xp

	local l_community     = leaderboard.community
	local l_id            = leaderboard.id
	local l_nickname      = leaderboard.nickname
	local l_discriminator = leaderboard.discriminator
	local l_rounds        = leaderboard.rounds
	local l_victories     = leaderboard.victories
	local l_kills         = leaderboard.kills
	local l_xp            = leaderboard.xp

	local l_registers = leaderboard.registers
	local l_sets = leaderboard.sets

	local l_full_nickname = leaderboard.full_nickname
	local l_pretty_nickname = leaderboard.pretty_nickname

	for player = 1, bString:read8() do
		community     = bString:read8()
		id            = bString:read32()
		nickname      = bString:readUTF()
		discriminator = format("%04d", bString:read16())
		rounds        = bString:read32()
		victories     = bString:read32()
		kills         = bString:read32()
		xp            = bString:read32()

		l_community    [player] = community
		l_id           [player] = id
		l_nickname     [player] = nickname
		l_discriminator[player] = discriminator
		l_rounds       [player] = rounds
		l_victories    [player] = victories
		l_kills        [player] = kills
		l_xp           [player] = xp

		l_registers[player] = {
			community     = community,
			id            = id,
			nickname      = nickname,
			discriminator = discriminator,
			rounds        = rounds,
			victories     = victories,
			kills         = kills,
			xp            = xp
		}

		l_sets[id] = player

		l_full_nickname[player] = nickname .. "#" .. discriminator
		l_pretty_nickname[player] = prettifyNickname(nickname, 11, discriminator, "BL")
	end

	leaderboard.loaded = true
end

local sortLeaderboard
do
	local sort = function(p1, p2)
		return p1.xp > p2.xp
	end

	sortLeaderboard = function()
		local bString = byteArray.new()

		local l_community     = leaderboard.community
		local l_id            = leaderboard.id
		local l_nickname      = leaderboard.nickname
		local l_discriminator = leaderboard.discriminator
		local l_rounds        = leaderboard.rounds
		local l_victories     = leaderboard.victories
		local l_kills         = leaderboard.kills
		local l_xp            = leaderboard.xp

		local l_registers = leaderboard.registers
		local l_sets = leaderboard.sets

		local registersLen = #l_registers

		local playerData, quickPlayerData = playerData.playerData
		local player, playerPosition
		local nickname, discriminator

		for playerName in next, players.room do
			player = tfm.get.room.playerList[playerName]
			quickPlayerData = playerData[playerName]

			nickname, discriminator = getNicknameAndDiscriminator(playerName)

			playerPosition = l_sets[player.id]
			if playerPosition then -- Already exists, just updates the register
				playerPosition = l_registers[playerPosition]

				-- Player may have changed their community since the last cycle
				playerPosition.community = player.community
				-- Player may have changed their nickname
				playerPosition.nickname = nickname
				playerPosition.discriminator = discriminator

				playerPosition.rounds = quickPlayerData.rounds
				playerPosition.victories = quickPlayerData.victories
				playerPosition.kills = quickPlayerData.kills
				playerPosition.xp = quickPlayerData.xp
			elseif quickPlayerData.xp > module.default_xp then -- Skips profiles with 0 data
				registersLen = registersLen + 1
				l_registers[registersLen] = {
					community     = player.community,
					id            = player.id,
					nickname      = nickname,
					discriminator = discriminator,
					rounds        = quickPlayerData.rounds,
					victories     = quickPlayerData.victories,
					kills         = quickPlayerData.kills,
					xp            = quickPlayerData.xp
				}
			end
		end

		table_sort(l_registers, sort)

		-- No need to slice the table, it will soon be rewritten by eventFileLoaded.
		return l_registers, registersLen
	end
end

local writeLeaderboardBString = function()
	local registers, totalRegisters = sortLeaderboard()
	totalRegisters = min(totalRegisters, module.max_leaderboard_rows)

	local bString = byteArray
		.new()
		:write8(totalRegisters)

	for i = 1, totalRegisters do
		i = registers[i]

		bString
			:write8(flagCodesSet[i.community] or flagCodesSet.xx)
			:write32(i.id)
			:writeUTF(i.nickname)
			:write16(i.discriminator)
			:write32(i.rounds)
			:write32(i.victories)
			:write32(i.kills)
			:write32(i.xp)
	end

	saveFile(tostring(bString), module.leaderboard_file)
end