-- Level 110
do
	powers.dayOfJudgement = Power
		.new("dayOfJudgement", powerType.divine, 110, {
			smallIcon = "172499dd0d6.png",
			icon = "172baf80263.jpg",
			iconWidth = 77,
			iconHeight = 80
		}, {
			seconds = 10,
			playerHealthPoints = 35,
			minDeadMice = 2,

			triggered = false,
			breakProcess = function(self)
				if not self.triggered then return end

				for playerName, cache in next, playerCache do
					if not cache.soulMate then
						for _playerName, _cache in next, playerCache do
							if playerName ~= _playerName then
								linkMice(playerName, _playerName, false, cache)
							end
						end
					else
						linkMice(playerName, cache.soulMate, false, cache)
					end
				end

				self.triggered = false
			end
		})
		:setUseCooldown(45)
		:setProbability(18)
		:bindChatMessage("^R+A+I+S+E+ T+H+E+ D+E+A+D+$")
		:setEffect(function(self)
			if players._count.dead < self.minDeadMice then return end
			self.triggered = true

			local deadMice = players.dead

			-- Respawns dead mice
			local firstPlayer = next(deadMice, nil)
			local player, tmpPlayerCache = firstPlayer, playerCache[firstPlayer]
			local lastName

			while player do
				respawnPlayer(player)
				addHealth(player, tmpPlayerCache, self.playerHealthPoints)

				lastPlayer = player
				player = next(deadMice, player)
				tmpPlayerCache = playerCache[player]

				linkMice((player or firstPlayer), lastPlayer, true, tmpPlayerCache)
			end

			setGameTime(60)
		end)
end