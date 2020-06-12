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