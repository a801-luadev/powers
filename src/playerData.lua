local playerData = DataHandler.new(module.id, {
	dataVersion = {
		index = 1,
		default = 0
	},
	rounds = {
		index = 2,
		default = 0
	},
	victories = {
		index = 3,
		default = 0
	},
	kills = {
		index = 4,
		default = 0
	},
	xp = {
		index = 5,
		default = module.default_xp
	},
	badges = {
		index = 6,
		default = 0
	},
	missions = {
		index = 7,
		default = { 0 }
	}
})