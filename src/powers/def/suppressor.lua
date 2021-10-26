-- Level 66
do
	local changePowerState = function(playerName, x, y, enable, playersList)
		local list = { }

		for name, cache in next,
			playersList or getPlayersOnFilter(playerName, pythagoras, x, y, 200) do

			list[name] = cache
			cache.canTriggerPowers = enable

			removeImage(cache.tmpImg) -- to avoid duplication
			if cache.tmpImg then
				cache.tmpImg = nil
			else
				cache.tmpImg = addImage(interfaceImages.supressedCircle, "$" .. name, nil, nil, nil,
					nil, nil, nil, nil, .5, .5)
			end
		end

		return list
	end

	local suppress = function(objectId, playerName, supressionTime)
		local object = room.objectList[objectId]
		if not object then return end

		-- Particle
		Power.basicCircle(object.x, object.y, 9, 200, .75, 1, -8)
		removeObject(objectId)

		-- Effect
		local playersList = changePowerState(playerName, object.x, object.y, false)
		timer:start(changePowerState, supressionTime, 1, playerName, 0, 0, true, playersList)
	end

	powers.suppressor = Power
		.new("suppressor", powerType.def, 66, {
			smallIcon = "17ca00bb742.png",
			icon = "17ca01b4acb.png",
			iconWidth = 80,
			iconHeight = 80
		}, {
			inventoryItemClicked = function(self, cache)
				cache.mouseSkill = self.typeId.__mouse
			end,

			potionExplode = 4000,
			supressionTime = 6500
		})
		:setUseLimit(2)
		:setUseCooldown(10)
		:setUseOnceForNKills(3)
		:bindMouse()
		:useInventory()
		:setEffect(function(playerName, playerX, playerY, _, self, _, clickX, clickY)
			local angle, xDirection, yDirection =
				Power.getDirectionByPosition(playerX, playerY, clickX, clickY)

			-- Throw supression possion
			local objectId = addShamanObject(8900, playerX + (xDirection * 40),
				playerY + (yDirection * 40), angle, xDirection * 10, yDirection * 10)
			addImage(interfaceImages.supressionPotion, "#" .. objectId, nil, nil, nil, nil, nil,
				nil, nil, .5, .6)

			timer:start(suppress, self.potionExplode, 1, objectId, playerName, self.supressionTime)
		end)
end