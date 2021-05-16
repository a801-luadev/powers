-- Level 50
do
	local changeSize = function(self, timer)
		if timer.times == 0 then
			for name in next, players.currentRound do
				changePlayerSize(name, 1)
			end
			resetPlayersDefaultSize = false
		else
			for name in next, players.alive do
				changePlayerSize(name, random(5, 35) / 10)
			end
		end
	end

	powers.atomic = Power
		.new("atomic", powerType.divine, 50, {
			smallIcon = "172499db327.png",
			icon = "172baf7e255.jpg",
			iconWidth = 76,
			iconHeight = 80
		}, {
			seconds = 10
		})
		:setUseCooldown(25)
		:setProbability(10)
		:bindChatMessage("^A+T+O+M+I+C+$")
		:setEffect(function(self)
			resetPlayersDefaultSize = true
			timer:start(changeSize, 500, self.seconds * 2, self)
		end)
end