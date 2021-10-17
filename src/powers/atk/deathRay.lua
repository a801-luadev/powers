-- Level 100
do
	local ray = function(x, y, arcWidth, arcHeight, size, direction)
		arcWidth = arcWidth * direction

		local ySin = 0
		local xPos = x
		local yPos = 0
		local xSpeed = 0
		local ySpeed = 0

		local xDirection = .1 * direction

		size = size * 3
		for i = 0, size, (isLowQuality and 2 or 1) do
			displayParticle(9, xPos, y + yPos, xSpeed, -ySpeed)

			i = i + 1
			ySin = sin(i)
			xPos = x + i*arcWidth
			yPos = ySin*arcHeight
			xSpeed = i * xDirection
			ySpeed = ySin * .55

			displayParticle(2, xPos, y - yPos, xSpeed, ySpeed)
		end

		xSpeed = direction*(size/2 - 1) + direction
		for i = 1, (isLowQuality and 1 or 2) do
			displayParticle(13, x, y, xSpeed)
		end
	end

	powers.deathRay = Power
		.new("deathRay", powerType.atk, 100, {
			smallIcon = "172499d9bcf.png",
			icon = "172bb0d9761.jpg",
			iconWidth = 150,
			iconHeight = 28
		})
		:setDamage(30)
		:setSelfDamage(20)
		:setUseLimit(1)
		:setUseCooldown(20)
		:setUseOnceForNKills(2)
		:bindKeyboard(keyboard.left, keyboard.up, keyboard.right, keyboard.down)
		:setKeySequence({
			{ keyboard.left, keyboard.up, keyboard.right, keyboard.down },
			{ keyboard.right, keyboard.up, keyboard.left, keyboard.down }
		})
		:setEffect(function(_, x, y, isFacingRight)
			-- Particles
			ray(x, y, 10, 8, 6, (isFacingRight and 1 or -1))

			-- Damage
			return inRectangle, x, y - 40, 250, 80, isFacingRight
		end)
end