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
	[120] = 0x8B658B,
	[130] = 0x4F2995
}

local roleColors = {
	translator    = 0x6CC19F,
	mapReviewer   = 0x3BA4E6,
	moderator     = 0xE9E654,
	administrator = 0xB69EFD
}
do
	for name, color in next, roleColors do
		roleColors["str_" .. name] = format("font color='#%x'", color)
	end
end

local systemColors = {
	moderation = 0xFCB8A4
}