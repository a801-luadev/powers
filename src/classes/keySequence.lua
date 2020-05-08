local KeySequence = { }
do
	KeySequence.__index = KeySequence

	KeySequence.new = function(self, queue)
		return setmetatable({
			queue = (queue or { }),
			_count = (queue and #queue or 0),
			_nextStrokeTolerance = 0
		}, self)
	end

	local checkQueue = function(self)
		local time = time()
		if time > self._nextStrokeTolerance then
			self._count = 0
			self._nextStrokeTolerance = 0
			self.queue = { }
		else
			self._nextStrokeTolerance = time + 300
		end
	end

	KeySequence.insert = function(self, key)
		checkQueue(self)
		self._count = self._count + 1
		self.queue[self._count] = key
	end

	KeySequence.release = function(self)
		self._nextStrokeTolerance = 0
		checkQueue(self)
	end

	KeySequence.invertQueue = function(self)
		local count = self._count
		local queue = self.queue

		-- O(n/2)
		for i = 1, count / 2 do
			queue[i], queue[count] = queue[count], queue[i]
			count = count - 1
		end

		return self
	end

	KeySequence.isEqual = function(src, comp)
		local srcLen = src._count
		if srcLen < comp._count then
			return false
		end
		srcLen = srcLen + 1

		local srcQueue, compQueue = src.queue, comp.queue
		for i = 1, comp._count do
			if compQueue[i] ~= srcQueue[srcLen - i] then
				return false
			end
		end

		src:release()

		return true
	end
end