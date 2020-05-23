local xpToLvl = function(xp)
	local last, total, level, remain, need = 35, 0, 0, 0, 0
	for i = 1, 666 do
		local nlast = last + (i - ((i < 26 and 1 or i < 66 and 35 or 55)))
		local ntotal = total + nlast

		if ntotal >= xp then
			level, remain, need = i - 1, xp - total, ntotal - xp
			return level, remain, need
		else
			last, total = nlast, ntotal
		end
	end
end

local lvlToXp = function(lvl)
	local last, total = 35, 0
	for i = 1, lvl do
		last = last + (i - ((i < 26 and 1 or i < 66 and 35 or 55)))
		total = total + last
	end

	return last, total
end