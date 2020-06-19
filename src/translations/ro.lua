local translations, getText = { }
translations.ro = {
	-- Main messages
	greeting = "<FC>Bine ai venit la <B>#powers</B>!\n" ..
		"\t• Apasă <B>H</B> sau scrie <B>!help</B> pentru a afla mai multe despre modul.\n" ..
		"\t• Apasă <B>O</B> sau scrie <B>!powers</B> pentru a afla mai multe despre puteri..",

	-- Victory
	mentionWinner = "<FC>%s<FC> a câștigat runda!",
	noWinner = "<FC>Nimeni nu a câștigat runda. :(",

	-- Lobby
	minPlayers = "Trebuie să fie cel puțin <B>2</B> jucători pe sală pentru ca jocul să înceapă.",

	-- Powers
	powers = {
		lightSpeed = "Viteza Luminii",
		laserBeam = "Rază Laser",
		wormHole = "Gaură de Vierme",
		doubleJump = "Săritură dublă",
		helix = "Spirală",
		dome = "Dom",
		lightning = "Fulger",
		superNova = "Supernovă",
		meteorSmash = "Lovitură de Meteorit",
		gravitationalAnomaly = "Anomalie Gravitațională",
		deathRay = "Raza Morții",
		atomic = "Atomic",
		dayOfJudgement = "Ziua Judecății"
	},
	powersDescriptions = {
		lightSpeed = "Moves your mouse in the light speed, pushing all enemies around.",
		laserBeam = "Aruncă o rază laser așa de puternică încât inamicii o pot simți.",
		wormHole = "Îți teleportează șoricelul în față, printr-o Gaură de Vierme.",
		doubleJump = "Performs an auxiliar and high double jump.",
		helix = "Îi dă un impuls șoricelului tău pe diagonală cu o spirală puternică.",
		dome = "Creează un dom protector care împinge toți inamicii din jur.",
		lightning = "Invocă un fulger puternic care electrocutează inamicii.",
		superNova = "Pornește o supernovă care distruge toți inamici din jur..",
		meteorSmash = "Lovește inamicii cu puterea unui meteorit.",
		gravitationalAnomaly = "Pornește o anomalie gravitațională.",
		deathRay = "Prăjește inamicii cu o puternică și misterioasă rază a morții.",
		atomic = "Schimbă mărimea jucătorilor într-un mod aleator.",
		dayOfJudgement = "Reînvie toți inamicii morți și îi leagă unul de celălalt."
	},
	powerType = {
		atk = "ATK (%d)",
		def = "DEF",
		divine = "DVN"
	},

	unlockPower = "<FC>[<J>•<FC>] Ai deblocat următoarele puteri: %s",

	-- Level names
	levelName = {
		[000] = "Mutant",
		[010] = "Necromant",
		[020] = "Om de știință",
		[030] = "Titan",
		[040] = { "Vrăjitor", "Vrăjitoare" },
		[050] = "Controlorul realității",
		[060] = { "Stăpânul vrăjilor", "Stăpâna vrăjilor" },
		[070] = "Invocator Șamanic",
		[080] = "Călărețul molimei",
		[090] = "Călărețul foametei",
		[100] = "Călărețul războiului",
		[110] = "Călărețul morții",
		[120] = "Vidul"
	},

	newLevel = "<FC>%s<FC> tocmai a atins nivelul <B>%d</B>!",
	level = "Nivel %d",

	-- Help
	helpTitles = {
		[1] = "Puteri!",
		[2] = "Comenzi",
		[3] = "Contribuie",
		[4] = "Ce este nou?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Scopul tău în acest modul este de a supraviețui atacurilor inamice.\n\n" ..
			"<N>Există o multitudine de puteri folosite ofensiv sau defensiv <font size='12'>- care sunt deblocate atingând " ..
				"nivele superioare -</font>.\n" ..
			"Scrie <FC><B>!powers</B><N> pentru a afla mai multe despre puterile pe care le-ai deblocat până acum!" ..
				"\n\n" ..
			"%s\n\n" .. -- enableParticles
			"Acest modul a fost dezvoltat de %s"
		,
		[2] = "<FC><p align='center'>COMENZI GENERALE</p><N>\n\n<font size='12'>", -- commands
		[3] = "<FC><p align='center'>CONTRIBUIE<N>\n\n" ..
			"Iubim Open Source <font color='#E91E63'>♥</font>! Poți vedea și schimba " ..
				"codul sursă al acestui modul pe <a href='event:print_" ..
				"github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Mentenanța modului este strict voluntară, deci orice ajutor cu privire la " ..
				"<V>cod<N>, <V>bugfix-uri și raportări<N>, <V>sugestii și" ..
				" îmbunătățiri<N>, <V>crearea hărților <N>este binevenită și apreciată.\n" ..
			"<p align='left'>• Poți <FC>raporta bug-uri <N>sau <FC>să faci sugestii <N>pe " ..
				"<a href='event:print_discord.gg/quch83R'><font color='#087ECC'>" ..
				"Discord</font></a> și/sau pe <a href='event:print_" ..
				"github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Poți <FC>trimite hărți <N>în Thread-ul nostru <a href='event:print_" ..
				"atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Map Submissions " ..
				"de pe Forum</font></a>.\n\n" ..
			"<p align='center'>Poți de asemenea să <FC>donezi</FC> orice sumă la <a href='event:print_" ..
				"a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>aici</font></a>" ..
				" pentru a ajuta la menținerea modulului. Toate fondurile obținute prin link vor fi" ..
				" investite în asigurarea de update-uri constante ale modulului și îmbunătățiri generale.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'>" ..
				"<font size='18' color='#087ECC'>Thread pe Forum</font></a></p>"
		,
		[4] = "<FC><p align='center'>Ce este nou?</p><N>\n\n" ..
			"• Modulul ~~a devenit~~ oficial.\n" ..
			"• Modulul a fost rescris în întregime."
	},

	-- Commands
	commandDescriptions = {
		help = "Deschide meniul.",
		powers = "Deschide un meniu care listează toate puterile și descrierile lor.",
		profile = "Deschide profilul tău sau al altcuiva.",
		leaderboard = "Deschide clasamentul global.",

		pw = "Protejează sala cu o parolă. Trimite necompletat pentru a o scoate.",

		mapEditQueue = "Gestionează rotația hărții în joc.",
		mapSaveQueue = "Salvează rotația hărții în joc.",
		review = "Activează modul de verificare.",
		np = "Încarcă o nouă hartă.",
		npp = "Stabilește harta ce urmează să fie încărcată după cea curentă.",

		msg = "Trimite un mesaj către sală.",
		ban = "Dă ban unui jucător",
		unban = "Scoate ban-ul unui jucător.",
		permban = "Dă ban permanent unui jucător.",

		promote = "Promovează un jucător la un anumit rol sau îi dă permisiuni specifice.",
		demote = "Scoate rolul unui jucător sau îi revocă permisiunile specifice.."
	},
	commandsParameters = {
		profile = "[player_name] ",

		pw = "[password] ",

		mapEditQueue = "[add|rem]<R>*</R> [@map ...]<R>*</R> ",
		mapSaveQueue = "[save]<R>*</R> ",
		np = "[@map]<R>*</R> ",
		npp = "[@map]<R>*</R> ",

		msg = "[message]<R>*</R> ",
		ban = "[player_name]<R>*</R> [ban_time] [reason] ",
		unban = "[player_name]<R>*</R> ",

		permban = "[player_name]<R>*</R> [reason] ",
		promote = "[player_name]<R>*</R> [permission_name|role_name ...]<R>*</R> ",
		demote = "[player_name]<R>*</R> [permission_name|role_name ...]<R>*</R> "
	},
	["or"] = "sau",

	-- Profile
	profileData = {
		rounds = "Runde",
		victories = "Victorii",
		kills = "Kill-uri",
		xp = "Experiență",
		badges = "Insigne"
	},

	-- Leaderboard
	leaderboard = "Clasament",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] Clasamentul se încarcă. Încearcă iar în " ..
		"câteva secunde.",

	-- Map management
	addMap = "<BV>[<FC>•<BV>] Harta <J>@%s</J> a fost adăugată în lista locală de așteptare.",
	remMap = "<BV>[<FC>•<BV>] Harta <J>@%s</J> a fost eliminată din lista locală de așteptare.",
	listMaps = "<BV>[<FC>•<BV>] Hărți (<J>#%d</J>): %s",

	-- Warning
	enableParticles = "<ROSE>NU uita să ACTIVEZI efectele speciale/particulele pentru a " ..
		"vedea modulul cum trebuie. (În 'Meniu' → 'Opțiuni', lângă 'Lista sălilor')</ROSE>",

	-- Ban
	ban = "%s <ROSE>a fost banat de pe #powers de către %s <ROSE>pentru %d ore. Motiv: %s",
	unban = "<ROSE>Ai fost debanat de către %s",
	isBanned = "<ROSE>Ești banat de pe #powers până la GMT+2 %s (încă %d ore).",
	permBan = "%s <ROSE>a fost banat permanent de pe #powers de către %s<ROSE>. Motiv: %s",
	cantPermUnban = "<BL>[<VI>•<BL>] Nu poți scoate banul unui jucător banat permanent.",

	-- Promotion
	playerGetPermissions = "<BL>[<VI>•<BL>] %s <BL>are acum următoarele permisiuni: <B>%s</B>",
	playerLosePermissions = "<BL>[<VI>•<BL>] %s <BL>a avut următoarele permisiuni revocate: " ..
		"<B>%s</B>",
	playerGetRole = "<FC>%s <FC>a fost promovat la <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>nu mai este <font color='#%x'>%s</font>.",

	-- Review
	enableReviewMode = "<BV>[<FC>•<BV>] The <FC>Modul de Revizuire Hărți<BV> este activat. Următoarele runde " ..
		"<B>nu</B> vor lua în considerare statisticile și hărțile care vor apărea sunt testate pentru rotația hărtilor " ..
		"modulului. Au fost activate toate puterile, iar puterile divine au șansă mai mare să se petreacă!",
	disableReviewMode = "<BV>[<FC>•<BV>] The <FC>Modul de Revizuire Hărți<BV> a fost dezactivat și " ..
		"totul va reveni la normal începând cu următoarea rundă!",

	-- Badges
	getBadge = "<FC>%s<FC> tocmai a deblocat o nouă insignă #powers!",

	-- Password
	setPassword = "<BL>[<VI>•<BL>] %s <BL>a pus parola %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>a scos parola de pe sală."
}

