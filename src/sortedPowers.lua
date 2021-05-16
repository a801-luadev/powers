-- Powers Sorted By Level
do
	local powerNameByLevel = Power.__nameByLevel

	local powerIndex = 0
	for lvl = 0, module.max_player_level do -- It's a small number, so it's fine for now.
		lvl = powerNameByLevel[lvl]
		if lvl then
			for i = 1, #lvl do
				powerIndex = powerIndex + 1
				powersSortedByLevel[powerIndex] = powers[lvl[i]]
			end
		end
	end

	module.powers_total_pages = #powersSortedByLevel / 16
end