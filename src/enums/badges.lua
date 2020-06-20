local badges = {
	betaTester  = 2 ^ 00, -- Find major bugs
	killer      = 2 ^ 01, -- >= 666 kills
	superPlayer = 2 ^ 02, -- == 1100 rounds
}

local badgesOrder = {
	[1] = "betaTester",
	[2] = "superPlayer",
	[3] = "killer"
}

local badgeImages = {
	betaTester = "172b0be763b.png",
	superPlayer = "172d284bb80.png",
	killer = "172d281b9b8.png"
}