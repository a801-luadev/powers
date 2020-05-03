local Power = { }
do
	Power.__index = Powers

	Power.new = function(name, type, level, imageData)
		return setmetatable({
			name = name,
			type = type,
			level = level,

			effect = nil,
			damage = 0,
			selfDamage = 0,

			useLimit = -1,
			useCooldown = 1000,

			imageData = nil
		}, Power)
	end

	Power.setEffect = function(self, effect)
		self.effect = effect
		return self
	end

	Power.setDamage = function(self, damage)
		self.damage = damage
		return self
	end

	Power.selfDamage = function(self, selfDamage)
		self.selfDamage = selfDamage
		return self
	end

	Power.setUseLimit = function(self, useLimit)
		self.useLimit = useLimit
		return self
	end

	Power.useCooldown = function(self, useCooldown)
		self.useCooldown = useCooldown * 1000
		return self
	end

	Power.getNewPlayerData = function(self, currentTime)
		return {
			remainingUses = self.useLimit,
			cooldown = currentTime + self.useCooldown
		}
	end
end