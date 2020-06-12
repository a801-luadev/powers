local permissions = {
	mapperColor        = 2 ^ 00,
	moderatorColor     = 2 ^ 01,
	administratorColor = 2 ^ 02,

	editLocalMapQueue  = 2 ^ 03,
	saveLocalMapQueue  = 2 ^ 04,

	sendRoomMessage    = 2 ^ 05,
	banUser            = 2 ^ 06,
	unbanUser          = 2 ^ 07,
	permBanUser        = 2 ^ 08,

	promoteUser        = 2 ^ 09,
	demoteUser         = 2 ^ 10,
}

local rolePermissions = {
	mapper = permissions.mapperColor
		+ permissions.editLocalMapQueue
		+ permissions.saveLocalMapQueue,

	moderator = permissions.moderatorColor
		+ permissions.editLocalMapQueue
		+ permissions.sendRoomMessage
		+ permissions.banUser
		+ permissions.unbanUser,

	administrator = 0
}

do
	for _, v in next, permissions do
		rolePermissions.administrator = rolePermissions.administrator + v
	end
end