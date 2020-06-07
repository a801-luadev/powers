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
		judgmentDay = "Judgment Day"
	},
	powersDescriptions = {
		lightSpeed = "Moves your mouse in the light speed, pushing all enemies around.",
		laserBeam = "Shoots a laser beam so strong that enemies can feel it.",
		wormHole = "Teleports your mouse ahead through a Worm Hole.",
		doubleJump = "Performs an auxiliar and high double jump.",
		helix = "Speeds up your mouse diagonally with a powerful helix.",
		dome = "Creates a protector dome that pushes all enemies around.",
		lightning = "Summons a potent lightning that electrifies the enemies.",
		superNova = "Starts a supernova that destroys all enemies around.",
		meteorSmash = "Smashes the enemies like a meteor crash.",
		gravitationalAnomaly = "Starts a gravitational anomaly.",
		deathRay = "Toasts the enemies with the powerful and mysterious death ray.",
		atomic = "Randomly changes all players' size.",
		judgmentDay = "Revives all dead enemies, them all linked to each other."
	},

	unlockPower = "You have unlocked the following power(s): %s",

	-- Level names
	levelName = {
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
		[1] = "Powers!",
		[2] = "Commands",
		[3] = "Contribute",
		[4] = "What's new?"
	},
	menuContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Your goal in this game is to survive from opponents' attacks.\n\n" ..
			"<N>There are a variety of powers <font size='12'>- which are unlocked by reaching " ..
				"higher levels -</font> to attack and defend.\n" ..
			"Type <FC><B>!powers</B><N> to learn more about the powers you have unlocked so far!" ..
				"\n\n" ..
			"<ROSE>%s</ROSE>\n\n" .. -- enableParticles
			"This game has been developed by <font color='#8FE2D1'>Bolodefchoco</font><G>#0000"
		,
		[2] = "<FC><p align='center'>GENERAL COMMANDS</p><N>\n\n", -- commands
		[3] = "<FC><p align='center'>CONTRIBUTE<N>\n\n" ..
			"We love Open Source <font color='#E91E63'>♥</font>! You can view and modify " ..
				"the source code of this game on <a href='event:print_" ..
				"github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Maintaining the game is strictly voluntary, so any help regarding " ..
				"<V>Code<N>, <V>bugfix and reports<N>, <V>suggestions and feature" ..
				" enhancements<N>, <V>map making <N>is welcome and very well appreciated.\n" ..
			"<p align='left'>• You can <FC>report bugs <N>or <FC>suggest <N>on " ..
				"<a href='event:print_discord.gg/quch83R'><font color='#087ECC'>" ..
				"Discord</font></a> and/or on <a href='event:print_" ..
				"github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• You can <FC>submit maps <N>in our <a href='event:print_" ..
				"atelier801.com/topic?f=5&t=918371'><font color='#087ECC'>Map Submissions " ..
				"Thread on Forums</font></a>.\n\n" ..
			"<p align='center'>You can also <FC>donate</FC> any amount <a href='event:print_" ..
				"a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>here</font></a>" ..
				" to help maintaining the game. All funds obtained through the link are going" ..
				" to be invested in constant game updates and general improvements.</p>"
		,
		[4] = "<FC><p align='center'>WHAT'S NEW?</p><N>\n\n" ..
			"• Module ~~became~~ official.\n" ..
			"• Module has been entirely rewritten."
	},

	-- Lobby
	minPlayers = "At least <B>2</B> players must be in the room for the game to start.",

	-- Profile
	profileData = {
		rounds = "Rounds",
		victories = "Victories",
		kills = "Kills",
		xp = "Experience"
	},

	-- Leaderboard
	leaderboard = "Leaderboard",

	-- Warning
	enableParticles = "Do NOT forget to ENABLE the special effects/particles in order to see the" ..
		" game properly. (In 'Menu' → 'Options', next to the 'Room List')",

	-- Commands
	commands = {
		help = "Opens this menu.",
		powers = "Opens a menu that lists all powers and their info.",
		profile = "Opens your or someone's profile.",
		leaderboard = "Opens the global leaderboard."
	},
	commandsParameters = {
		profile = "[player_name] "
	}
}