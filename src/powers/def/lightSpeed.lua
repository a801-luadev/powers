-- Level 3
do
	local wind = function(x, y, direction)
		for i = 1, 6, (isLowQuality and 1.5 or 1) do
			displayParticle(35, x, y, direction, i * (i < 4 and -1 or 1))
		end
	end

	powers.lightSpeed = Power
		.new("lightSpeed", powerType.def, 3, {
			smallIcon = "172499c43ff.png",
			icon = "172bb04e693.jpg",
			iconWidth = 92,
			iconHeight = 70
		})
		:setUseCooldown(1.5)
		:bindKeyboard(keyboard.left, keyboard.right)
		:setKeySequence({
			{ keyboard.left, keyboard.left, keyboard.left },
			{ keyboard.right, keyboard.right, keyboard.right }
		})
		:setEffect(function(playerName, x, y, isFacingRight)
			-- Move player
			movePlayer(playerName, x + (isFacingRight and 200 or -200), y)

			-- Move players
			local direction = (isFacingRight and 30 or -30)
			for name in next, getPlayersOnFilter(playerName, inRectangle, x, y - 60, 200, 120,
				isFacingRight) do
				movePlayer(name, 0, 0, true, direction)
			end

			-- Particles
			wind(x, y, (isFacingRight and 15 or -15))
		end)
end