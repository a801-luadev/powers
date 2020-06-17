local permissions = {
	translatorColor    = 2 ^ 00,
	mapReviewerColor   = 2 ^ 01,
	moderatorColor     = 2 ^ 02,
	administratorColor = 2 ^ 03,

	editLocalMapQueue  = 2 ^ 04,
	saveLocalMapQueue  = 2 ^ 05,
	enableReviewMode   = 2 ^ 06,

	sendRoomMessage    = 2 ^ 07,
	banUser            = 2 ^ 08,
	unbanUser          = 2 ^ 09,
	permBanUser        = 2 ^ 10,

	promoteUser        = 2 ^ 11,
	demoteUser         = 2 ^ 12,
}

local rolePermissions = {
	translator = permissions.translatorColor,

	mapReviewer = permissions.mapReviewerColor
		+ permissions.editLocalMapQueue
		+ permissions.saveLocalMapQueue
		+ permissions.enableReviewMode,

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