-- Translated by Michipol#0000
translations.pl = {
	greeting = "<FC>Witaj w <B>#powers</B>!\n" ..
		"\t• Naciśnij <B>H</B> albo wpisz <B>!help</B> aby przeczytać więcej o module.\n" ..
		"\t• Naciśnij <B>O</B> albo wpisz <B>!powers</B> aby przeczytać więcej o mocach.",
	kill = "<R>%s<FC> zabił %s",

	mentionWinner = "<FC>%s<FC> wygrywa rundę!",
	noWinner = "<FC>Nikt nie wygrywa rundy. :(",

	minPlayers = "Aby rozpocząć grę muszą być minimum <B>2</B> osoby w pokoju.",

	powers = {
		lightSpeed = "Prędkość światła",
		laserBeam = "Laserowy Promień",
		wormHole = "Tunel Czasoprzestrzenny",
		doubleJump = "Podwójny skok",
		helix = "Spirala",
		dome = "Tarcza",
		lightning = "Błyskawica",
		superNova = "Supernowa",
		meteorSmash = "Wybuch Meteorytu",
		gravitationalAnomaly = "Grawitacyjna Anomalia",
		deathRay = "Promień śmierci",
		atomic = "Atomic",
		dayOfJudgement = "Dzień sądu"
	},
	powersDescriptions = {
		lightSpeed = "Twoja mysz osiąga prędkość światła i popycha przy tym wszystkich wrogów.",
		laserBeam = "Wystrzeliwuje wiązkę laserową, która jest odczuwalna przez wszystkich przeciwników.",
		wormHole = "Teleportuje Cię do przodu używając przy tym tunelu czasoprzestrzennego.",
		doubleJump = "Wykonuje wysoki podójny skok.",
		helix = "Prędkość Twojej myszy wzrasta dzięki potęznej mocny spirali.",
		dome = "Tworzy ochronną tarczę, która odpycha przeciwników.",
		lightning = "Przywołuje potężną błyskawicę, która elektryzuje wrogów.",
		superNova = "Uruchamia supernową , która niszczy wszystkich pobliskich wrogów.",
		meteorSmash = "Wysadza wszystkich wrogów.",
		gravitationalAnomaly = "Rozpoczyna grawitacyjną anomalię.",
		deathRay = "Zalewa wrogów potężnym i tajemniczym promienim śmierci.",
		atomic = "Losowo zmienia rozmiar wszystkich graczy.",
		dayOfJudgement = "Ożywia wszystkich martwych wrogów i łączy ich ze sobą."
	},
	powerType = {
		atk = "ATAK (%d)",
		def = "OBRONA",
		divine = "BOSKI"
	},

	unlockPower = "<FC>[<J>•<FC>] Odblokowałeś nową moc: %s",

	levelName = {
		[000] = { "Mutant", "Mutantka" },
		[010] = { "Nekromanta", "Nekromantka" },
		[020] = "Naukowiec",
		[030] = "Tytan",
		[040] = { "Czarodziej", "Czarodziejka" },
		[050] = { "Władca Rzeczywistości", "Władczyni Rzeczywistości" },
		[060] = { "Władca Czarów", "Władczyni Czarów" },
		[070] = { "Szamański Przywoływacz", "Szamańska Przywoływaczka" },
		[080] = "Jeździec Zarazy",
		[090] = "Jeździec Głodu",
		[100] = "Jeździec Wojny",
		[110] = "Jeździec Śmierci",
		[120] = "Pustka"
	},

	newLevel = "<FC>%s<FC> osiągnął poziom <B>%d</B>!",
	level = "Poziom %d",

	helpTitles = {
		[2] = "Komendy",
		[3] = "Współpraca",
		[4] = "Co nowego?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Twoim celem w tym module jest przetrwać ataki przeciwników.\n\n" ..
			"<N>Jest tutaj wiele mocy <font size='12'>- które są odblokowywane poprzez osiągnięcie wyższych poziomów -</font> do ataku i obrony.\n" ..
			"Wpisz <FC><B>!powers</B><N> aby dowiedzieć się więcej o odblokowanych już mocach!\n\n" ..
			"%s\n\n" ..
			"Ten moduł został stworzony przez %s"
		,
		[2] = "<FC><p align='center'>KOMENDY</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>WSPÓŁPRACA<N>\n\n" ..
			"Uwielbiamy Open Source <font color='#E91E63'>♥</font>! Możesz zobaczyć i zmodyfikować kod źródłowy tego modułu na <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Utrzymanie modułu jest dobrowolne, więc jakakolwiek pomoc w <V>Kod<N>, <V>naprawa błędów i zgłoszenia<N>, <V>sugestie i ulepszenia fukcji<N>, <V>tworzenie map <N>jest mile widziana i bardzo ceniona.\n" ..
			"<p align='left'>• Możesz <FC>zgłosić błędy <N>lub <FC>sugestie <N>na <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> lub na <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Możesz <FC>zgłosić mapy <N>w naszym <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Wątku do zgłoszenia map na Forum.</font></a>.\n\n" ..
			"<p align='center'>Możesz też <FC>wpłacić</FC> dowolną kwotę <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>tutaj</font></a> aby pomóc utrzymać moduł. Wszystkie fundusze zostaną przekazane na nowe aktualizacje i dalsze rozwijanie się modułu.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Wątek na Forum</font></a></p>"
		,
		[4] = "<FC><p align='center'>Co nowego?</p><N>\n\n" ..
			"• Teraz możesz przeczytać opis wszystkich mocy.\n" ..
			"• Moduł ~~stał się~~ oficjalny.\n" ..
			"• Moduł został całkowicie napisany na nowo."
	},

	commandDescriptions = {
		help = "Otwiera to menu.",
		powers = "Otwiera menu z listą wszystkich mocy i informacjami na ich temat.",
		profile = "Otwiera Twój lub kogoś profil.",
		leaderboard = "Otwiera globalną tablice wyników.",

		pw = "Zabezpiecza room hasłem. Wyślij pustą komendę, aby usunąć istniejące już hasło."
	},
	commandsParameters = {
		profile = "[nick_gracza] ",

		pw = "[hasło] "
	},
	["or"] = "lub",

	profileData = {
		rounds = "Rundy",
		victories = "Zwycięstwa",
		kills = "Zabicia",
		xp = "Doświadczenie",
		badges = "Odznaki"
	},

	leaderboard = "Tabela wyników",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] Tabela się wciąż ładuje. Spróbuj ponownie za kilka sekund.",

	addMap = "<BV>[<FC>•<BV>] Mapa <J>@%s</J> została dodana do kolejki.",
	remMap = "<BV>[<FC>•<BV>] Mapa <J>@%s</J> Została usunięta z kolejki.",
	listMaps = "<BV>[<FC>•<BV>] Mapy (<J>#%d</J>): %s",

	enableParticles = "<ROSE>NIE zapomnij o WŁĄCZENIU efektów cząsteczkowych aby wyświetlać moduł prawidłowo. (W \"Menu\" → \"Opcje\", obok \"Lista Room'ów\")</ROSE>",

	ban = "%s <ROSE>został zbanowany z #powers przez %s <ROSE>na %d godzin. Powód: %s",
	unban = "<ROSE>Zostałeś odbanowany przez %s",
	isBanned = "<ROSE>Zostałeś zbanowany z #powers do GMT+2 %s (%d godzin do końca).",
	permBan = "%s <ROSE>został zbanowany na stałe z #powers przez %s<ROSE>. Powód: %s",

	playerGetRole = "<FC>%s <FC>zyskuje rolę <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>traci rolę <font color='#%x'>%s</font>!",

	enableReviewMode = "<BV>[<FC>•<BV>] <FC>Tryb podglądu map<BV> jest włączony. Następne rundy <B>nie</B> będą liczone do statystyk i mapy będą tylko do testu modułu. Wszystkie moce są włączone i bardziej prawdopodobne!",
	disableReviewMode = "<BV>[<FC>•<BV>]<FC>Tryb podglądu map<BV> został wyłączony i wszystko wróci do normalnośći przy następnej rundzie!",

	getBadge = "<FC>%s<FC> odblokował nową #powers odznakę!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>ustawił nowe hasło na %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>usunął haslo z pokoju."
}