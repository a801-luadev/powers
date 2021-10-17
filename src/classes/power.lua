Power = { }
do
	Power.__index = Power

	-- References
	Power.__keyboard    = { }
	Power.__mouse       = { }
	Power.__chatMessage = { }
	Power.__emotePlayed = { }
	Power.__inventory   = { }

	Power.__eventCount  = {
		__keyboard    = 0,
		__mouse       = 0,
		__chatMessage = 0,
		__emotePlayed = 0,
		__inventory   = 0
	}

	Power.__nameByLevel = { }

	Power.new = function(name, type, level, imageData, extraData, resetableData)
		local self = {
			name = name,
			type = type,
			level = level,
			typeId = { },

			effect = nil,

			defaultUseLimit = (type == powerType.divine and 1 or -1),
			useLimit = nil,
			defaultUseCooldown = 1000,
			useCooldown = 1000,
			triggerPossibility = nil,
			oncePerNKills = 0,

			damage = nil,
			selfDamage = nil,

			bindControl = nil,

			keysToBind = nil,
			totalKeysToBind = nil,

			triggererKey = nil,
			keySequences = nil,
			totalKeySequences = nil,

			clickRange = nil,

			messagePattern = nil,

			triggererEmote = nil,

			inInventory = false,

			imageData = imageData,
			resetableData = resetableData
		}
		self.useLimit = self.defaultUseLimit

		if extraData then
			table_add(self, extraData)
		end

		local nameByLevel = Power.__nameByLevel
		if not nameByLevel[level] then
			nameByLevel[level] = { }
		end
		nameByLevel = nameByLevel[level]
		nameByLevel[#nameByLevel + 1] = name

		return setmetatable(self, Power)
	end

	Power.setEffect = function(self, f)
		self.effect = f
		return self
	end

	Power.setDamage = function(self, damage)
		self.damage = damage
		return self
	end

	Power.setSelfDamage = function(self, damage)
		self.selfDamage = damage
		return self
	end

	Power.setUseLimit = function(self, limit)
		self.useLimit = limit
		self.defaultUseLimit = limit
		return self
	end

	Power.setUseCooldown = function(self, cooldown)
		self.defaultUseCooldown = cooldown * 1000
		self.useCooldown = self.defaultUseCooldown
		return self
	end

	Power.setUseOnceForNKills = function(self, totalKills)
		self.oncePerNKills = totalKills
		return self
	end

	local bindKeys = function(self, playerName)
		local keysToBind = self.keysToBind
		for k = 1, self.totalKeysToBind do
			bindKeyboard(playerName, keysToBind[k], true, true)
		end
	end

	local bindClick = function(_, playerName)
		bindMouse(playerName, true)
	end

	local setEventType = function(self, type)
		local count = Power.__eventCount
		local power = Power[type]
		count[type] = count[type] + 1
		power[count[type]] = self
		self.typeId[type] = count[type]
	end

	Power.bindChatMessage = function(self, message)
		self.messagePattern = message
		setEventType(self, "__chatMessage")

		return self
	end

	Power.bindKeyboard = function(self, ...)
		self.keysToBind = { ... }
		self.totalKeysToBind = #self.keysToBind
		if self.totalKeysToBind == 1 then
			self.triggererKey = self.keysToBind[1] -- No keystroke sequence if it is a single key
		end
		self.bindControl = bindKeys

		setEventType(self, "__keyboard")

		return self
	end

	Power.bindMouse = function(self, range)
		self.clickRange = range or 0
		self.bindControl = bindClick

		setEventType(self, "__mouse")

		return self
	end

	Power.bindEmote = function(self, emoteId)
		self.triggererEmote = emoteId

		setEventType(self, "__emotePlayed")

		return self
	end

	Power.useInventory = function(self, emoteId)
		self.inInventory = true

		setEventType(self, "__inventory")

		return self
	end

	Power.setKeySequence = function(self, keySequences)
		self.triggererKey = nil

		local totalKeySequences = #keySequences
		self.totalKeySequences = totalKeySequences

		for i = 1, totalKeySequences do
			keySequences[i] = KeySequence.new(keySequences[i]):invertQueue()
		end
		self.keySequences = keySequences

		return self
	end

	Power.setProbability = function(self, triggerPossibility)
		-- Inverse probability, less means higher chances
		self.triggerPossibility = triggerPossibility
		return self
	end

	Power.reset = function(self)
		self.useLimit = self.defaultUseLimit
		self.useCooldown = time() + self.defaultUseCooldown
		if self.resetableData then
			table_add(self, self.resetableData, true)
		end
		return self
	end

	Power.getNewPlayerData = function(self, playerLevel, currentTime)
		return (playerLevel >= self.level or isCurrentMapOnReviewMode) and {
			remainingUses = self.useLimit,
			cooldown = currentTime + self.useCooldown
		} or nil
	end

	Power.damagePlayers = function(self, playerName, args, _method, _cache)
		if self.damage then
			_cache = _cache or playerCache[playerName];
			(_method or damagePlayers)(playerName, self.damage * _cache.damageRate, unpack(args))
		end
		return self
	end

	Power.canTriggerRegular = function(self, cache, _time, _isCheck)
		local playerPowerData = cache.powers[self.name]
		if not playerPowerData or
			playerPowerData.remainingUses == 0 then return end -- x < 0 means infinity

		if cache.roundKills < self.oncePerNKills then return end -- allow once for every N kills

		_time = _time or time()
		if playerPowerData.cooldown > _time then return end

		if _isCheck then
			return true
		end

		playerPowerData.cooldown = _time + self.useCooldown
		cache.powerCooldown = _time + 800 -- General cooldown

		playerPowerData.remainingUses = playerPowerData.remainingUses - 1

		if self.oncePerNKills > 0 then
			cache.roundKills = cache.roundKills - self.oncePerNKills
		end

		return true
	end

	Power.triggerRegular = function(self, playerName, _cache, _time, _x, _y, _ignorePosition, ...)
		_cache = _cache or playerCache[playerName]

		if self.bindControl == bindClick then -- before checking permission to avoid glitches
			_cache.mouseSkill = 1
		end

		if not self:canTriggerRegular(_cache, _time) then
			return false
		end

		if not (_ignorePosition or _x) then
			local playerData = room.playerList[playerName]
			_x, _y = playerData.x, playerData.y
		end

		if self.effect then
			local args = {
				self.effect(playerName, _x, _y, _cache.isFacingRight, self, _cache, ...)
			}
			if args[1] then -- return false to perform the damage inside the effect
				self:damagePlayers(playerName, args, nil, _cache)
			end
		end

		if self.selfDamage then
			damagePlayer(playerName, self.selfDamage, _cache)
		end

		return true
	end

	Power.checkTriggerPossibility = function(self, _playerName)
		if self.triggerPossibility then
			local possibility = self.triggerPossibility

			if isCurrentMapOnReviewMode then
				possibility = 5
			end

			if random(possibility) ~= random(possibility) then
				if _playerName then
					chatMessage("<BL>[<VI>•<BL>] :(", _playerName)
				end
				return false
			end
			if _playerName then
				chatMessage("<BL>[<VI>•<BL>] :)", _playerName)
			end
		end
		return true
	end

	local canTriggerDivine = function(self, playerName, _time)
		local powerData = powers[self.name]
		if powerData.useLimit == 0 then return end -- x < 0 means infinity

		_time = _time or time()
		if powerData.useCooldown > _time then return end
		powerData.useCooldown = _time + 5000 -- Wait a bit before trying again if on failure

		if not self:checkTriggerPossibility(playerName) then return end

		powerData.useCooldown = _time + self.defaultUseCooldown
		powerData.useLimit = powerData.useLimit - 1

		return true
	end

	-- It has weird arguments because of @trigger that uses the same parameters of @triggerRegular
	Power.triggerDivine = function(self, playerName, _, _time, _, _, _, ...)
		if not canTriggerDivine(self, playerName, _time) then
			return false
		end

		if self.effect then
			self.effect(self, playerName, ...)
			if not isReviewMode then
				giveBadge(playerName, "divine")
			end
		end

		return true
	end

	Power.trigger = function(self, ...)
		if self.type == powerType.divine then
			return self:triggerDivine(...)
		else
			return self:triggerRegular(...)
		end
	end

	Power.basicCircle = function(x, y, particleId, dimension, normalRate, lowQualityRate, force)
		local xCos, ySin
		for i = 90, 110, (isLowQuality and lowQualityRate or normalRate) do
			xCos = cos(i)
			ySin = sin(i)

			displayParticle(particleId, x + xCos*dimension, y + ySin*dimension, xCos * force,
				ySin * force)
		end
	end
end