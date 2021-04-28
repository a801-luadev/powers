local timer = { }
do
	timer.start = function(self, callback, ms, times, ...)
		local t = self._timers
		t._count = t._count + 1

		local args = { ... }
		t[t._count] = {
			id = t._count,
			callback = callback,
			args = args,
			defaultMilliseconds = ms,
			milliseconds = ms,
			times = times
		}
		args[#args + 1] = t[t._count]

		return t._count
	end

	timer.delete = function(self, id)
		local ts = self._timers
		ts[id] = nil
		ts._deleted = ts._deleted + 1
	end

	timer.loop = function(self)
		local ts = self._timers
		if ts._deleted >= ts._count then return end

		local t
		for i = 1, ts._count do
			t = ts[i]
			if t then
				t.milliseconds = t.milliseconds - 500
				if t.milliseconds <= 0 then
					t.milliseconds = t.defaultMilliseconds
					t.times = t.times - 1

					t.callback(unpack(t.args))

					if t.times == 0 then
						self:delete(i)
					end
				end
			end
		end
	end

	timer.refresh = function()
		timer._timers = {
			_count = 0,
			_deleted = 0
		}
	end
	timer.refresh()
end

local unrefreshableTimer = { }
do
	unrefreshableTimer.id = 0
	unrefreshableTimer.timers = { }
	unrefreshableTimer.deleteQueue = { }
	unrefreshableTimer.countDeleteQueue = 0

	unrefreshableTimer.remainingMapTime = 0

	unrefreshableTimer.start = function(self, callback, ms, times, ...)
		self.id = self.id + 1

		local t = self.timers
		local args = { ... }
		t[self.id] = {
			id = self.id,
			callback = callback,
			args = args,
			defaultMilliseconds = ms,
			milliseconds = ms,
			times = times
		}
		args[#args + 1] = t[self.id]

		return self.id
	end

	unrefreshableTimer.delete = function(self, id)
		self.countDeleteQueue = self.countDeleteQueue + 1
		self.deleteQueue[self.countDeleteQueue] = id
	end

	unrefreshableTimer.loop = function(self)
		local ts = self.timers

		for i, t in next, ts do
			t.milliseconds = t.milliseconds - 500
			if t.milliseconds <= 0 then
				t.milliseconds = t.defaultMilliseconds
				t.times = t.times - 1

				t.callback(unpack(t.args))

				if t.times == 0 then
					self:delete(i)
				end
			end
		end

		local dq = self.deleteQueue
		for i = 1, self.countDeleteQueue do
			ts[dq[i]] = nil
		end
		self.countDeleteQueue = 0
	end
end