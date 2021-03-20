local badges = {
	betaTester  = 2 ^ 00, -- Find major bugs
	killer      = 2 ^ 01, -- == 666 kills
	superPlayer = 2 ^ 02, -- == 1100 rounds
	anomaly     = 2 ^ 03, -- Summon the anomaly
	victorious  = 2 ^ 04, -- == 2000 victories
	divine      = 2 ^ 05, -- Summon a divine power
	mapper      = 2 ^ 06, -- Mapper (3 maps)
}

local badgesOrder = {
	[1] = "betaTester",
	[2] = "divine",
	[3] = "anomaly",
	[4] = "superPlayer",
	[5] = "killer",
	[6] = "victorious",
	[7] = "mapper"
}

local badgeImages = {
	betaTester = "172b0be763b.png",
	divine = "177add565b4.png",
	anomaly = "172d414212d.png",
	superPlayer = "172d284bb80.png",
	killer = "172d281b9b8.png",
	victorious = "17851f296e1.png",
	mapper = "17851e709bc.png"
}