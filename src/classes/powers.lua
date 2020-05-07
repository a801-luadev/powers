local Power = { }
do
	Power.__index = Powers

	Power.new = function(name, type, level, imageData, extraData, resetableData)
		local self = {
			name = name,
			type = type,
			level = level,

			effect = nil,
			bind = nil,

			damage = nil,
			selfDamage = nil,

			defaultUseLimit = (type == powerType.divine and 1 or -1),
			useLimit = nil,
			useCooldown = 1000,

			imageData = nil,

			bindKeys = nil,
			keySequence = nil,
			lenKeySequence = nil,

			resetableData = resetableData
		}
		self.useLimit = self.defaultUseLimit

		if extraData then
			table_add(self, extraData)
		end

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

	Power.selfDamage = function(self, damage)
		self.selfDamage = damage
		return self
	end

	Power.setUseLimit = function(self, limit)
		self.useLimit = limit
		self.defaultUseLimit = limit
		return self
	end

	Power.useCooldown = function(self, cooldown)
		self.useCooldown = cooldown * 1000
		return self
	end

	Power.setBind = function(self, ...)
		if not key then
			self.bind = system.bindMouse
		else
			self.bindKeys = { ... }
			local totalKeys = #self.bindKeys
			self.bind = function(playerName)
				for k = 1, totalKeys do
					system.bindKeyboard(playerName, self.bindKeys[k], true)
				end
			end
		end
		return self
	end

	Power.setKeySequence = function(self, ...)
		self.keySequence = (... and { ... } or self.bindKeys)
		self.lenKeySequence = { _count = #self.keySequence }

		for s = 1, self.lenKeySequence._count do
			self.lenKeySequence[s] = #self.keySequence[s]
		end

		return self
	end

	Power.reset = function(self)
		self.useLimit = self.defaultUseLimit
		if self.resetableData then
			table_add(self, self.resetableData, true)
		end
		return self
	end

	Power.getNewPlayerData = function(self, currentTime)
		return self.type ~= powerType.divine and {
			remainingUses = self.useLimit,
			cooldown = currentTime + self.useCooldown
		} or nil
	end

	Power.damagePlayers = function(self, playerName, args, _method)
		if self.damage then
			(_method or damagePlayers)(playerName, self.damage, unpack(args))
		end
		return self
	end

	local canTrigger = function(self, src, _time, _playerCache)
		local power = src[self.name]
		if power.remainingUses <= 0 then return end

		_time = _time or time()
		if power.cooldown > _time or
			(_playerCache and _playerCache.powerCooldown > _time) then return end
		if _playerCache then
			_playerCache.powerCooldown = _time + 200
		end

		power.remainingUses = power.remainingUses - 1

		return power
	end

	Power.triggerRegular = function(self, playerName, _cache, _time, _x, _y, _ignorePosition, ...)
		_cache = _cache or playerCache[playerName]

		local power = canTrigger(self, _cache.powers, _time, _cache)
		if not power then
			return false
		end

		if not (_ignorePosition or _x) then
			local playerData = tfm.get.room.playerList[playerName]
			_x, _y = playerData.x, playerData.y
		end

		if self.effect then
			local args = {
				self.effect(playerName, _x, _y, _cache.isFacingRight, self, _cache, ...)
			}
			if args[1] then -- return false to perform the damage inside the effect
				self:damagePlayers(playerName, args)
			end
		end

		if self.selfDamage then
			damage(playerName, self.selfDamage, _cache)
		end

		return true
	end

	Power.triggerDivine = function(self, _time, _x, _y)
		local power = canTrigger(self, powers, _time)
		if not power then
			return false
		end

		if self.effect then
			self.effect(self, _x, _y, ...)
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
end