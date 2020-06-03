local readLeaderboardBString = function(bString)
	bString = byteArray.new(bString)

	local l_community     = leaderboard.community
	--local l_id            = leaderboard.id
	local l_nickname      = leaderboard.nickname
	local l_discriminator = leaderboard.discriminator
	local l_rounds        = leaderboard.rounds
	local l_victories     = leaderboard.victories
	local l_kills         = leaderboard.kills
	local l_xp            = leaderboard.xp

	local lFull_nickname = leaderboard.full_nickname
	local lPretty_nickname = leaderboard.pretty_nickname

	for player = 1, bString:read8() do
		l_community    [player] = bString:read8()
		--[[l_id           [player] =]] bString:read32()
		l_nickname     [player] = bString:readUTF()
		l_discriminator[player] = bString:read16()
		l_rounds       [player] = bString:read32()
		l_victories    [player] = bString:read32()
		l_kills        [player] = bString:read32()
		l_xp           [player] = bString:read32()

		lFull_nickname[player] = l_nickname[player] .. l_discriminator[player]
		lPretty_nickname[player] = prettifyNickname(l_nickname[player], 11, l_discriminator[player],
			"BL")
	end
end