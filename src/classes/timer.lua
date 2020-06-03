local timer = { }
do
	timer.start = function(callback, ms, times, ...)
		local t = timer._timers
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

	timer.delete = function(id)
		local ts = timer._timers
		ts[id] = nil
		ts._deleted = ts._deleted + 1
	end

	timer.loop = function()
		local ts = timer._timers
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
						timer.delete(i)
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

local unrefreshableTimer = table_copy(timer)
unrefreshableTimer.refresh = nil