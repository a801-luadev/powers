local badges = {
	betaTester  = 2 ^ 00, -- Find major bugs
	killer      = 2 ^ 01, -- >= 666 kills
	superPlayer = 2 ^ 02, -- == 1100 rounds
	anomaly     = 2 ^ 03, -- Summon the anomaly
}

local badgesOrder = {
	[1] = "betaTester",
	[2] = "anomaly",
	[3] = "superPlayer",
	[4] = "killer"
}

local badgeImages = {
	betaTester = "172b0be763b.png",
	anomaly = "172d414212d.png",
	superPlayer = "172d284bb80.png",
	killer = "172d281b9b8.png"
}