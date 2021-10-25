-- Level 116
do
	local checkExplosion

	local auxAngleRad = rad(1)
	local splitBomb = function(x, y, totalBombs, power, playerName)
		local arc = 20
		local angle = 270 - ( (totalBombs / 2) * arc)

		local objectId, xDirection, yDirection
		for b = 1, totalBombs do
			xDirection, yDirection = cos(auxAngleRad * angle), sin(auxAngleRad * angle)

			objectId = addShamanObject(9500, x + (xDirection * 25), y + (yDirection * 25),
				angle + 90, xDirection * 8, yDirection * 8, true)
			addImage(interfaceImages.miniBomb, "#" .. objectId, nil, nil, nil, nil, nil,
				nil, 2, .4, .3)

			angle = angle + arc

			timer:start(checkExplosion, 500, power.miniBombExplode, objectId, playerName,
				power.miniBombExplode - 1, power, true)
		end
	end

	checkExplosion = function(objectId, playerName, firstCall, power, isMini, timer)
		local object = room.objectList[objectId]
		if not object or timer.times == firstCall then return end

		if abs(object.vx) + abs(object.vy) > 5 and timer.times ~= 0 then return end

		timer.times = 0
		removeObject(objectId)

		local x, y = object.x, object.y
		if not inRectangle(x, y, -50, -50, 900, 500, true) then return end

		power:damagePlayers(playerName, { nil, pythagoras, x, y, (isMini and 50 or 25) },
			damagePlayersWithAction, nil, (isMini and power.miniBombDamage or power.damage))

		if not isMini then
			Power.basicCircle(x, y, 13, 1, 1, 1.1, 4)
			Power.basicCircle(x, y, 11, 1, 1, 1.1, 5)

			splitBomb(x, y, power.totalMiniBombs, power, playerName)
		else
			Power.basicCircle(x, y, 11, 1, 1, 1.1, 3)
		end
	end

	powers.boom = Power
		.new("boom", powerType.atk, 116, {
			smallIcon = "17cb31e9892.png",
			icon = "17cb9db15d6.png",
			iconWidth = 80,
			iconHeight = 80
		}, {
			inventoryItemClicked = function(self, cache)
				cache.mouseSkill = self.typeId.__mouse
			end,

			bombExplode = 5 * 2,

			miniBombExplode = 4 * 2,
			miniBombDamage = 10,
			totalMiniBombs = 4,
		})
		:setDamage(30)
		:setSelfDamage(25)
		:setUseLimit(1)
		:setUseCooldown(30)
		:setUseOnceForNKills(7)
		:bindMouse()
		:useInventory()
		:setEffect(function(playerName, playerX, playerY, _, self, _, clickX, clickY)
			local angle, xDirection, yDirection =
				Power.getDirectionByPosition(playerX, playerY, clickX, clickY)

			-- Shoot
			local objectId = addShamanObject(8900, playerX + (xDirection * 40),
				playerY + (yDirection * 40), angle, xDirection * 12, yDirection * 12, true)
			addImage(interfaceImages.bomb, "#" .. objectId, nil, nil, nil, nil, nil,
				nil, 2, .4, .3)

			timer:start(checkExplosion, 500, self.bombExplode, objectId, playerName,
				self.bombExplode - 1, self, false)

			return false
		end)
end