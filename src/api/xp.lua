local xpToLvl = function(xp)
	if xp >= module.max_player_xp then
		return module.max_player_level, 1, 1
	end

	local last, total, level, remain, need = 35, 0, 0, 0, 0
	for i = 1, module.max_player_level do
		local nlast = last + (i - ((i < 26 and 1 or i < 66 and 35 or i < 120 and 55 or 85)))
		local ntotal = total + nlast

		if ntotal >= xp then
			level, remain, need = i - 1, xp - total, ntotal - xp
			return level, remain, remain + need
		else
			last, total = nlast, ntotal
		end
	end
end

local lvlToXp = function(lvl)
	local last, total = 35, 0
	for i = 1, lvl do
		last = last + (i - ((i < 26 and 1 or i < 66 and 35 or i < 120 and 55 or 85)))
		total = total + last
	end

	return total, last
end