local textAreaId = {
	lifeBar = 10,
	gravitationalAnomaly = 50,
	temporalDisturbance = 70,
	interface = 100,
}

local interfaceImages = {
	lifeBar = "172017a8fa6.png",
	levelBar = "17262a19ccf.png",

	rectangle = "1724c8e1e61.jpg", -- Powers
	highlightRectangleBorder = "1724ca7c279.png",
	smallRectangle = "172642bf9ed.jpg", -- Profile
	leaderboardRectangle = "172778a3188.jpg",
	largeRectangle = "172aeae9445.jpg", -- Profile

	-- 30x30
	xButton = "17280a523f6.png",
	heartToken = "177ae37b108.png",

	-- 70x70
	rightArrow = "1729bab289f.png",
	leftArrow = "1729bab4011.png",

	locker = "1724e77bf31.png",

	-- 25x25
	sword = "17254a44673.png",
	shield = "17254a45de6.png",
	parchment = "17254911060.png",
	heart = "17254b649d2.png",
	explodingBomb = "17254d637be.png",
	megaphone = "1725980b66c.png",

	mouseClick = "172bb22eed4.png",

	-- 25x25
	skull = "17263f4dee4.png",
	ground = "17264087ad6.png",
	crown = "1726424a9e4.png",
	star = "17272ad3c14.png"
}

local imageTargets = {
	lifeBar = "&0",
	levelBar = ":10",
	interfaceBackground = ":0",
	interfaceTextAreaBackground = "&0",
	interfaceRectangle = ":10",
	interfaceIcon = ":50",
	tokenIcon = "!0"
}

local interfaceBackground = {
	-- x+8, y+10
	[40] = {
		[40] = "179116efb76.png"
	},
	[120] = {
		[30] = "17256d5e4ac.png"
	},
	[183] = {
		[338] = "177b28caf88.png"
	},
	[280] = {
		[330] = "1726737b74f.png"
	},
	[503] = {
		[278] = "177b28c8f4a.png",
		[338] = "177b263ffb8.png"
	},
	[700] = {
		[330] = "1728a8497f2.png"
	}
}