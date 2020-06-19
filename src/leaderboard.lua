local readLeaderboardData = function(data)
	local total
	data, total = str_split(data, ' ', true, tonumber)

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

	local totalRegisters = total / 8 -- 8 fields

	local player = 0
	for i = 1, total, 8 do
		community     = data[i + 0]
		id            = data[i + 1]
		nickname      = data[i + 2]

		discriminator = data[i + 3]
		rounds        = data[i + 4]
		victories     = data[i + 5]
		kills         = data[i + 6]
		xp            = data[i + 7]

		player = player + 1

		l_community    [player] = flags[(flagCodes[community] or "xx")]
		l_id           [player] = id
		l_nickname     [player] = nickname
		l_discriminator[player] = format("%04d", discriminator)
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

		l_full_nickname[player] = nickname .. "#" .. l_discriminator[player]
		l_pretty_nickname[player] = prettifyNickname(nickname, 11, l_discriminator[player], "BL")
	end

	leaderboard.loaded = true
	-- Remove from this function when hits max.
	leaderboard.total_pages = ceil(totalRegisters / 17) -- 17 rows
end

local sortLeaderboard
do
	local sort = function(p1, p2)
		return p1.xp > p2.xp
	end

	sortLeaderboard = function()
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
		local nickname, discriminator, community

		for playerName in next, players.room do
			player = room.playerList[playerName]
			quickPlayerData = playerData[playerName]

			nickname, discriminator = getNicknameAndDiscriminator(playerName)
			community = flagCodesSet[player.community] or flagCodesSet.xx

			playerPosition = l_sets[player.id]
			if playerPosition then -- Already exists, just updates the register
				playerPosition = l_registers[playerPosition]

				-- Player may have changed their community since the last cycle
				playerPosition.community = community
				-- Player may have changed their nickname
				playerPosition.nickname = nickname
				playerPosition.discriminator = discriminator

				playerPosition.rounds = quickPlayerData.rounds
				playerPosition.victories = quickPlayerData.victories
				playerPosition.kills = quickPlayerData.kills
				playerPosition.xp = quickPlayerData.xp
			else
				registersLen = registersLen + 1
				l_registers[registersLen] = {
					community     = community,
					id            = player.id,
					nickname      = nickname,
					discriminator = discriminator,
					rounds        = quickPlayerData.rounds,
					victories     = quickPlayerData.victories,
					kills         = quickPlayerData.kills,
					xp            = quickPlayerData.xp
				}
				l_sets[player.id] = registersLen
			end
		end

		table_sort(l_registers, sort)

		-- No need to slice the table, it will soon be rewritten by eventFileLoaded.
		return l_registers, registersLen
	end
end

local writeLeaderboardData
do
	local dataFormat = "%d %d %s %d %d %d %d %d"
	writeLeaderboardData = function()
		local registers, totalRegisters = sortLeaderboard()

		local data, counter, tmpWritten, register = { }, 0, { }
		for i = 1, totalRegisters do
			register = registers[i]

			if not tmpWritten[register.nickname] then
				tmpWritten[register.nickname] = true

				counter = counter + 1
				data[counter] = format(dataFormat,
					register.community,
					register.id,
					register.nickname,
					register.discriminator,
					register.rounds,
					register.victories,
					register.kills,
					register.xp
				)
			end

			if counter == module.max_leaderboard_rows then break end
		end

		saveFile(table_concat(data, ' '), module.leaderboard_file)
	end
end