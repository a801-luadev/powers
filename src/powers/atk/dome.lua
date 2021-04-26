-- Level 35
do
	local circle = function(x, y, dimension)
		local xPos, yPos
		for i = 90, 110, (isLowQuality and 1.75 or 1) do
			xPos = cos(i) * dimension
			yPos = sin(i) * dimension
			displayParticle(2, x + xPos, y + yPos)
		end

		local yTop = y - dimension
		local yBottom = y + dimension

		local xLeft = x - dimension
		local xRight = x + dimension

		dimension = dimension / 100

		local bottomRight, topLeft
		for i = 1, 5, (isLowQuality and 2 or 1) do
			bottomRight = i * dimension
			topLeft = -i * dimension
			displayParticle(11, x, yTop, 0, bottomRight)
			displayParticle(11, x, yBottom, 0, topLeft)
			displayParticle(11, xLeft, y, bottomRight)
			displayParticle(11, xRight, y, topLeft)
		end
	end

	powers.dome = Power
		.new("dome", powerType.atk, 35, {
			smallIcon = "172499d277f.png",
			icon = "172baf8c5fe.jpg",
			iconWidth = 80,
			iconHeight = 80
		})
		:setDamage(5)
		:setUseLimit(15)
		:setUseCooldown(4)
		:setProbability(3) -- For non-divine players, it only happens for emote triggerers
		:bindEmote(enum_emote.facepaw)
		:bindChatMessage("^P+R+O+T+E+C+T+O+S+$")
		:setEffect(function(_, x, y)
			local dimension = 80

			-- Particles
			circle(x, y, dimension)

			-- Damage
			explosion(x, y, -40, dimension)
			return pythagoras, x, y, dimension
		end)
end