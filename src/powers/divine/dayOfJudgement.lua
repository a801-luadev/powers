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
			minDeadMice = 2
		})
		:setUseCooldown(45)
		:setProbability(20)
		:bindChatMessage("^R+A+I+S+E+ T+H+E+ D+E+A+D+$")
		:setEffect(function(self)
			if players._count.dead < self.minDeadMice then return end
			local deadMice = players.dead

			-- Respawns dead mice
			local firstPlayer = next(deadMice, nil)
			local player = firstPlayer
			local lastName

			while player do
				respawnPlayer(player)
				addHealth(player, playerCache[player], self.playerHealthPoints)

				lastPlayer = player
				player = next(deadMice, player)

				linkMice((player or firstPlayer), lastPlayer, true)
			end

			setGameTime(60)
		end)
end