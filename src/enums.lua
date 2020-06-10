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
	leaderboardRectangle = "172778a3188.jpg",

	-- 30x30
	xButton = "17280a523f6.png",

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

	mouseClick = "172597de49d.png",

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
	interfaceIcon = ":50"
}

local interfaceBackground = {
	-- x+8, y+10
	[120] = {
		[30] = "17256d5e4ac.png"
	},
	[183] = {
		[279] = "17256d61391.png"
	},
	[280] = {
		[330] = "1726737b74f.png"
	},
	[503] = {
		[278] = "17201a440b4.png"
	},
	[700] = {
		[330] = "1728a8497f2.png"
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

local keyboardImagesWidths = {
	[keyboard.spacebar] = 124,
	[keyboard.ctrl] = 42,
	[keyboard.shift] = 29
}

local emoteImages = {
	[enum_emote.facepaw] = "1728baa8d88.png"
}

local flags = {
	xx = "1651b327097.png",
	ar = "1651b32290a.png",
	bg = "1651b300203.png",
	br = "1651b3019c0.png",
	cn = "1651b3031bf.png",
	cz = "1651b304972.png",
	de = "1651b306152.png",
	ee = "1651b307973.png",
	es = "1651b309222.png",
	fi = "1651b30aa94.png",
	fr = "1651b30c284.png",
	gb = "1651b30da90.png",
	hr = "1651b30f25d.png",
	hu = "1651b310a3b.png",
	id = "1651b3121ec.png",
	il = "1651b3139ed.png",
	it = "1651b3151ac.png",
	jp = "1651b31696a.png",
	lt = "1651b31811c.png",
	lv = "1651b319906.png",
	nl = "1651b31b0dc.png",
	ph = "1651b31c891.png",
	pl = "1651b31e0cf.png",
	ro = "1651b31f950.png",
	ru = "1651b321113.png",
	tr = "1651b3240e8.png",
	vk = "1651b3258b3.png"
}

local flagCodes, flagCodesSet = {
	[01] = "xx",
	[02] = "ar",
	[03] = "bg",
	[04] = "br",
	[05] = "cn",
	[06] = "cz",
	[07] = "de",
	[08] = "ee",
	[09] = "es",
	[10] = "fi",
	[11] = "fr",
	[12] = "gb",
	[13] = "hr",
	[14] = "hu",
	[15] = "id",
	[16] = "il",
	[17] = "it",
	[18] = "jp",
	[19] = "lt",
	[20] = "lv",
	[21] = "nl",
	[22] = "ph",
	[23] = "pl",
	[24] = "ro",
	[25] = "ru",
	[26] = "tr",
	[27] = "vk"
}