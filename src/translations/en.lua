local translations, getText = { }
translations.en = {
	-- Official message
	ownerAnnounce = "<B>[#powers] %s</B>",

	-- Maps
	addMap = "<BL>The map <J>@%s</J> was added to the local map queue.",
	remMap = "<BL>The map <J>@%s</J> was removed from the local map queue.",
	totalMaps = "<BL>Total maps: <J>#%s</J>: %s",

	-- Powers
	powers = {
		lightSpeed = "Light Speed",
		laserBeam = "Laser Beam",
		wormHole = "Worm Hole",
		doubleJump = "Double Jump",
		helix = "Helix",
		dome = "Dome",
		lightning = "Lightning",
		superNova = "Supernova",
		meteorSmash = "Meteor Smash",
		gravitationalAnomaly = "Gravitational Anomaly",
		deathRay = "Death Ray",
		atomic = "Atomic",
		raiseOfTheDead = "Raise of the Dead"
	},

	unlockPower = "You have unlocked the following power(s): %s",

	-- Level names
	level = {
		[000] = "Mutant",
		[010] = "Necromancer",
		[020] = "Scientist",
		[030] = "Titan",
		[040] = { "Wizard", "Wizardess" },
		[050] = "Reality Controller",
		[060] = { "Lord of Spells", "Lady of Spells" },
		[070] = "Shamanic Summoner",
		[080] = "The Pestilence Horseman",
		[090] = "The Famine Horseman",
		[100] = "The War Horseman",
		[110] = "The Death Horseman",
		[120] = "The Void"
	},

	newLevel = "%s just reached level %d!",
	level = "Lv %d",

	-- Winner
	noWinner = "No one won the round.",
	mentionWinner = "%s won the round!",

	-- Menu
	menuTitles = {
		[1] = "Title 1",
		[2] = "Title 2",
		[3] = "Title 3",
		[4] = "Title 4"
	},
	menuContent = {
		[1] = "Content 1",
		[2] = "Content 2",
		[3] = "Content 3",
		[4] = "Content 4"
	},

	-- Lobby
	minPlayers = "At least <B>2</B> players must be in the room for the game to start."
}