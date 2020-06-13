local permissions = {
	translatorColor    = 2 ^ 00,
	mapReviewerColor   = 2 ^ 01,
	moderatorColor     = 2 ^ 02,
	administratorColor = 2 ^ 03,

	editLocalMapQueue  = 2 ^ 04,
	saveLocalMapQueue  = 2 ^ 05,

	sendRoomMessage    = 2 ^ 06,
	banUser            = 2 ^ 07,
	unbanUser          = 2 ^ 08,
	permBanUser        = 2 ^ 09,

	promoteUser        = 2 ^ 10,
	demoteUser         = 2 ^ 11,
}

local rolePermissions = {
	translator = permissions.translatorColor,

	mapReviewer = permissions.mapReviewerColor
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