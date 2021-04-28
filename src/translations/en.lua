local translations, getText = { }
translations.en = {
	-- Main messages
	greeting = "<FC>Welcome to <B>#powers</B>!\n" ..
		"\t• Press <B>H</B> or type <B>!help</B> to learn more about the module.\n" ..
		"\t• Press <B>O</B> or type <B>!powers</B> to learn more about the powers.\n" ..
		"\t• Type <B>!modes</B> to learn more about other game modes.",
	kill = "<R>%s<FC> killed %s",

	gameModes = "<font size='-2'><FC>[<J>•</J>] New game modes:\n" ..
		"\t • Laggy module? Try a lighter version at /room #powers0lagmode\n" ..
		"\t • Want to upgrade faster? Try the noob mode (low levels only) at /room #powers0noobmode\n" ..
		"\t • Too pro? Challenge yourself in the pro mode (high levels only) at /room #powers0promode\n" ..
		"\t • Doesn't care about the stats and wants to try all powers? Try the free mode at /room #powers0freemode</FC></font>",

	-- Victory
	mentionWinner = "<FC>%s<FC> won the round!",
	noWinner = "<FC>No one won the round. :(",

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
		dayOfJudgement = "Day of Judgement",
		waterSplash = "Water Splash",
		soulSucker = "Soul Sucker",
		temporalDisturbance = "Temporal Disturbance"
	},
	powersDescriptions = {
		lightSpeed = "Moves your mouse in the speed of light, pushing all enemies around.",
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
		dayOfJudgement = "Revives all dead enemies, them all linked to each other.",
		waterSplash = "Summons some drops of water from Antarctica.",
		soulSucker = "Steals 5 HP from enemies that you kill.",
		temporalDisturbance = "Sends you back in time to undo what has been done."
	},
	powerType = {
		atk = "ATTACK (%d)",
		def = "DEFENSE",
		divine = "DIVINE"
	},

	unlockPower = "<FC>[<J>•<FC>] You have unlocked the following power(s): %s",

	-- Level names
	-- @Translator notes: if it has gender variation, { "male", "female" }, else "neutral".
	levelName = {
		[000] = "Mutant",
		[010] = "Necromancer",
		[020] = "Scientist",
		[030] = "Titan",
		[040] = { "Wizard", "Wizardess" },
		[050] = "Reality Controller",
		[060] = { "Lord of Spells", "Lady of Spells" },
		[070] = "Shamanic Summoner",
		[080] = { "The Pestilence Horseman", "The Pestilence Horsewoman" },
		[090] = { "The Famine Horseman", "The Famine Horsewoman" },
		[100] = { "The War Horseman", "The War Horsewoman" },
		[110] = { "The Death Horseman", "The Death Horsewoman" },
		[120] = "The Void",
		[130] = "Time Lord"
	},

	newLevel = "<FC>%s<FC> just reached level <B>%d</B>!",
	level = "Level %d",

	-- Help
	helpTitles = {
		[1] = "Powers!", -- @Translator notes: remove this line
		[2] = "Commands",
		[3] = "Contribute",
		[4] = "What's new?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Your goal in this module is to survive from opponents' attacks.\n\n" ..
			"<N>There are a variety of powers <font size='12'>- which are unlocked by reaching higher levels -</font> to attack and defend.\n" ..
			"Type <FC><B>!powers</B><N> to learn more about the powers you have unlocked so far!\n\n" ..
			"%s\n\n" .. -- enableParticles
			"This module has been developed by %s"
		,
		[2] = "<FC><p align='center'>GENERAL COMMANDS</p><N>\n\n<font size='12'>", -- commands
		[3] = "<FC><p align='center'>CONTRIBUTE<N>\n\n" ..
			"We love Open Source <font color='#E91E63'>♥</font>! You can view and modify the source code of this module on <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Maintaining the module is strictly voluntary, so any help regarding <V>Code<N>, <V>bugfix and reports<N>, <V>suggestions and feature enhancements<N>, <V>map making <N>is welcome and very well appreciated.\n" ..
			"<p align='left'>• You can <FC>report bugs <N>or <FC>suggest <N>on <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> and/or on <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• You can <FC>submit maps <N>in our <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Map Submissions Thread on Forums</font></a>.\n\n" ..
			"<p align='center'>You can also <FC>donate</FC> any amount <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>here</font></a> to help maintaining the module. All funds obtained through the link are going to be invested in constant module updates and general improvements.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Thread on Forums</font></a></p>"
		,
		[4] = { "<FC><p align='center'>WHAT'S NEW?</p><N>\n",
			"• Module has been entirely rewritten.",
			"• Module became official.",
			"• You can read about all powers now.",
			"• New power <B>Water Splash</B>.",
			"• Three new badges.",
			"• New room modes: <B>#powers0lagmode</B>, <B>#powers0freemode</B>, <B>#powers0noobmode</B>, <B>#powers0promode</B>.",
			"• New command <B>!modes</B>.",
			"• Players with level lower than 35 will receive extra XP.",
			"• Two new badges! 2000 victories / use a divine power.",
			"• New power <B>Soul Sucker</B>.",
			"• New badge for mappers. If you have 3 or more maps in #powers, contact the module developer ingame to obtain it.",
			"• New level <I>(Time Lord)</I>.",
			"• New power <B>Temporal Disturbance</B>."
		}
	},

	-- Commands
	commandDescriptions = {
		help = "Opens this menu.",
		powers = "Opens a menu that lists all powers and their info.",
		profile = "Opens your or someone's profile.",
		leaderboard = "Opens the global leaderboard.",
		modes = "Shows the game modes.",
		perms = "Shows your special permissions in the module, if any.",

		pw = "Protects the room with a password. Send empty to remove it.",

		mapEditQueue = "Manages the map rotation of the game.", -- @Translator notes: remove this line
		mapSaveQueue = "Saves the map rotation of the game.", -- @Translator notes: remove this line
		review = "Enables the review mode.", -- @Translator notes: remove this line
		np = "Loads a new map.", -- @Translator notes: remove this line
		npp = "Schedules the next map to be loaded.", -- @Translator notes: remove this line

		msg = "Sends a message to the room.", -- @Translator notes: remove this line
		ban = "Bans a player from the game.", -- @Translator notes: remove this line
		unban = "Unbans a player from the game.", -- @Translator notes: remove this line
		permban = "Bans permanently a player from the game.", -- @Translator notes: remove this line

		promote = "Promotes a player to a specific role or gives them specific permissions.", -- @Translator notes: remove this line
		demote = "Demotes a player from a specific role or removes specific permissions from them.", -- @Translator notes: remove this line

		givebadge = "Gives a badge to a player.", -- @Translator notes: remove this line
		setdata = "Sets the data of a player.", -- @Translator notes: remove this line
	},
	commandsParameters = {
		profile = "[player_name] ",

		pw = "[password] ",

		mapEditQueue = "[add|rem]<R>*</R> [@map ...]<R>*</R> ", -- @Translator notes: remove this line
		mapSaveQueue = "[save]<R>*</R> ", -- @Translator notes: remove this line
		np = "[@map]<R>*</R> ", -- @Translator notes: remove this line
		npp = "[@map]<R>*</R> ", -- @Translator notes: remove this line

		msg = "[message]<R>*</R> ", -- @Translator notes: remove this line
		ban = "[player_name]<R>*</R> [ban_time] [reason] ", -- @Translator notes: remove this line
		unban = "[player_name]<R>*</R> ", -- @Translator notes: remove this line

		permban = "[player_name]<R>*</R> [reason] ", -- @Translator notes: remove this line
		promote = "[player_name]<R>*</R> [permission_name|role_name ...]<R>*</R> ", -- @Translator notes: remove this line
		demote = "[player_name]<R>*</R> [permission_name|role_name ...]<R>*</R> ", -- @Translator notes: remove this line

		givebadge = "[player_name]<R>*</R> [badge_name]<R>*</R> ", -- @Translator notes: remove this line
		setdata = "[player_name]<R>*</R> [total_rounds]<R>*</R> [total_victories]<R>*</R> [total_kills]<R>*</R> [total_xp]<R>*</R> " -- @Translator notes: remove this line
	},
	["or"] = "or",

	-- Profile
	profileData = {
		rounds = "Rounds",
		victories = "Victories",
		kills = "Kills",
		xp = "Experience",
		badges = "Badges"
	},

	-- Leaderboard
	leaderboard = "Leaderboard",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] The leaderboard is still loading. Try again in a few seconds.",

	-- Map management
	addMap = "<BV>[<FC>•<BV>] The map <J>@%s</J> was added to the local map queue.",
	remMap = "<BV>[<FC>•<BV>] The map <J>@%s</J> was removed from the local map queue.",
	listMaps = "<BV>[<FC>•<BV>] Maps (<J>#%d</J>): %s",

	-- Warning
	enableParticles = "<ROSE>Do NOT forget to ENABLE the special effects/particles in order to see the module properly. (In 'Menu' → 'Options', next to the 'Room List')</ROSE>",

	-- Ban
	ban = "%%s <font color='#%x'>has been banned from #powers by %%s <font color='#%x'>for %%d hours. Reason: %%s",
	unban = "<font color='#%x'>You have been unbanned by %%s",
	isBanned = "<font color='#%x'>You are banned from #powers until GMT+2 %%s (%%d hours to go).", -- @Translator notes: keep GMT+2
	permBan = "%%s <font color='#%x'>has been banned permanently from #powers by %%s<font color='#%x'>. Reason: %%s",
	cantPermUnban = "<BL>[<VI>•<BL>] You cannot unban a user that is banned permanently.", -- @Translator notes: remove this line
	resetData = "<BL>[<VI>•<BL>] Data of %s<BL> has been set to {rounds=%d,victories=%d,kills=%d,xp=%d}", -- @Translator notes: remove this line

	-- Promotion
	playerGetPermissions = "<BL>[<VI>•<BL>] %s <BL>has now the following permissions: <B>%s</B>", -- @Translator notes: remove this line
	playerLosePermissions = "<BL>[<VI>•<BL>] %s <BL>had the following permissions removed: <B>%s</B>", -- @Translator notes: remove this line
	playerGetRole = "<FC>%s <FC>has been promoted to <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>is not <font color='#%x'>%s</font> anymore.",

	-- Review
	enableReviewMode = "<BV>[<FC>•<BV>] The <FC>Map Review Mode<BV> is enabled. Next rounds will <B>not</B> count stats and the maps that appear are in test for the map rotation of the module. All powers have been enabled and divine powers are more likely to happen!",
	disableReviewMode = "<BV>[<FC>•<BV>] The <FC>Map Review Mode<BV> has been disabled and everything will be back to normal in the next round!",
	freeMode = "<BV>[<FC>•<BV>] Stats <B>won't</B> count in this game mode. All powers have been enabled and divine powers are more likely to happen!",

	-- Badges
	getBadge = "<FC>%s<FC> just unlocked a new #powers badge!",

	-- Password
	setPassword = "<BL>[<VI>•<BL>] %s <BL>has set the password to %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>has removed the password of the room."
}