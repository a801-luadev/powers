local powerType = {
	def = 0,
	atk = 1,
	divine = 2
}

local levelColors = {
	[000] = 0xFFA500,
	[010] = 0x4187B1,
	[020] = 0x66CDAA,
	[030] = 0xFEDA7A,
	[040] = 0xDA70D6,
	[050] = 0x4F94CD,
	[060] = 0x9370DB,
	[070] = 0x48D1CC,
	[080] = 0x9ACD32,
	[090] = 0x1C1313,
	[100] = 0x7C1C29,
	[110] = 0xD7ECFF,
	[120] = 0x8B658B
}

local textAreaId = {
	lifeBar = 50,
	gravitationalAnomaly = 100,
	interface = 500,
	lobby = 600
}

local interfaceImages = {
	lifeBar = "172017a8fa6.png",
	levelBar = "17262a19ccf.png",

	rectangle = "1724c8e1e61.jpg",
	highlightRectangleBorder = "1724ca7c279.png",
	smallRectangle = "172642bf9ed.jpg",

	locker = "1724e77bf31.png",

	sword = "17254a44673.png",
	shield = "17254a45de6.png",
	parchment = "17254911060.png",
	heart = "17254b649d2.png",
	explodingBomb = "17254d637be.png",
	megaphone = "1725980b66c.png",

	mouseClick = "172597de49d.png",

	skull = "17263f4dee4.png",
	ground = "17264087ad6.png",
	crown = "1726424a9e4.png"
}

local imageTargets = {
	lifeBar = "&0",
	levelBar = ":10",
	interfaceBackground = ":0",
	interfaceTextAreaBackground = "&0",
	interfaceRectangle = ":10",
	interfaceIcon = ":50"
}

local interfaceBackground = {
	-- x+6, y+10
	[120] = {
		[30] = "17256d5e4ac.png"
	},
	[200] = {
		[200] = "17256d5fc1f.png",
		[300] = "17256d61391.png"
	},
	[280] = {
		--[330] = ''
	},
	[520] = {
		[300] = "17201a440b4.png"
	}
}

local keyboard = {
	left = 0,
	up = 1,
	right = 2,
	down = 3,

	H = byte 'H',
	L = byte 'L',
	O = byte 'O',
	P = byte 'P',

	spacebar = byte ' ',
	ctrl = 17,
	shift = 16
}

local keyboardImages = {
	[keyboard.left] = "17254b845dc.png",
	[keyboard.up] = "17254b98e0f.png",
	[keyboard.right] = "17254b90167.png",
	[keyboard.down] = "17254b8e9f3.png",

	[keyboard.H] = "17254b85d4e.png",
	[keyboard.L] = "17254b88c41.png",
	[keyboard.O] = "17254b874be.png",
	[keyboard.P] = "17254b918d7.png",

	[keyboard.spacebar] = "172583272f1.png",
	[keyboard.ctrl] = "17258353f90.png",
	[keyboard.shift] = "1725832346d.png"
}