-- Translated by Danielthemouse#6206
translations.he = {
	greeting = "<FC>ברוכים הבאים אל <B>#powers</B>!\n" ..
		"\t• לחצו <B>H</B> או רשמו <B>!help</B> כדי ללמוד עוד על המודול.\n" ..
		"\t• לחצו <B>O</B> או רשמו <B>!powers</B> כדי ללמוד עוד על הכוחות.",

	mentionWinner = "<FC>%s<FC> ניצחו את הסיבוב!",
	noWinner = "<FC>אף אחד לא ניצח את הסיבוב. :(",

	minPlayers = "לפחות <B>2</B> שחקנים צריכים להיות בחדר בשביל שהמשחק יתחיל.",

	powers = {
		lightSpeed = "מהירות האור",
		laserBeam = "קרן לייזר",
		wormHole = "חור תולעת",
		doubleJump = "קפיצה כפולה",
		helix = "הליקס",
		dome = "כיפה",
		lightning = "ברק",
		superNova = "סופר-נובה",
		meteorSmash = "מכת מטאור",
		gravitationalAnomaly = "אנטי-גרביטציה",
		deathRay = "קרן מוות",
		atomic = "אטומי",
		dayOfJudgement = "יום הדין"
	},
	powersDescriptions = {
		lightSpeed = "מזיז את העכבר שלכם במהירות האור, דוחף את כל האויבים שבדרך.",
		laserBeam = "יורה קרן לייזר כל כך חזקה שהאויבים יכולים להרגיש אותה.",
		wormHole = "משגר את העכבר שלכם קדימה בעזרת חור תולעת.",
		doubleJump = "מבצע קפיצה כפולה גבוהה.",
		helix = "מאיץ את העכבר שלכם באלכסון בעזרת הליקס חזק.",
		dome = "יוצר כיפת הגנה שדוחפת את כל האויבים שבסביבה.",
		lightning = "יוצר ברק רב עוצמה שמחשמל את האויבים.",
		superNova = "יוצר סופרנובה שמשמידה את כל האויבים שבסביבה.",
		meteorSmash = "מוחץ את האויבים כמו התרסקות מטאור.",
		gravitationalAnomaly = "יוצר חריגת גרוויטציה.",
		deathRay = "מחמם את האויבים עם קרן לייזר מיסטורית וחזקה.",
		atomic = "משנה באקראיות את הגודל של כל השחקנים.",
		dayOfJudgement = "מחייה את כל השחקנים המתים, אבל כשכולם קשורים אחד לשני."
	},
	powerType = {
		atk = "התקפה (%d)",
		def = "הגנה",
		divine = "אלוהי"
	},

	unlockPower = "<FC>[<J>•<FC>] פתחת את הכוח(ות) הבאים: %s",

	levelName = {
		[000] = { "מוטנט", "מוטנטית" },
		[010] = { "מתקשר עם המתים", "מתקשרת עם המתים" },
		[020] = { "מדען", "מדענית" },
		[030] = "טיטאן",
		[040] = { "מכשף", "מכשפה" },
		[050] = { "שולט במציאות", "שולטת במציאות" },
		[060] = { "לורד הכישופים", "גברת הכישופים" },
		[070] = "מזמן שאמאני",
		[080] = "פרש המגפה",
		[090] = "פרש הרעב",
		[100] = "פרש המלחמה",
		[110] = "פרש המוות",
		[120] = "הלא-כלום"
	},

	newLevel = "<FC>%s<FC> הגיעו לרמה <B>%d</B>!",
	level = "Level %d",

	helpTitles = {
		[2] = "פקודות",
		[3] = "תרמו",
		[4] = "מה חדש?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>המטרה שלכם במשחק היא לשרוד את ההתקפות של האויב.\n\n" ..
			"<N>ישנו מגוון של כוחות <font size='12'>- אשר נפתחים על ידי עלייה לרמות גבוהות יותר -</font>לתקוף ולהגן.\n" ..
			"רשמו <FC><B>!powers</B><N> כדי ללמוד יותר על הכוחות שפתחתם עד עכשיו!\n\n" ..
			"%s\n\n" ..
			"המשחק פותח על ידי %s"
		,
		[2] = "<FC><p align='center'>פקודות כלליות</p><N>\n\n<font size='12'>",
		[3] = "<FC><p align='center'>תרמו<N>\n\n" ..
			"אנחנו אוהבים קוד פתוח <font color='#E91E63'>♥</font>! אתם יכולים לצפות ולשנות את קוד המשחק ב- <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"תחזוק המשחק הוא התנדבותי בלבד, אז כל עזרה בנוגע <V>לקוד<N>, <V>תיקוני באגים ודיווחים<N>, <V>הצעות ושיפור תכונות<N>, <V>והכנת מפות <N>מבורכת ומאוד מוערכת.\n" ..
			"<p align='left'>• אתם יכולים <FC>לדווח על באגים <N>או <FC>להציע דברים <N>ב- <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> ו/או ב- <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• אתם יכולים <FC>להגיש מפות <N> <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>באשכול הגשת המפות בפורומים</font></a>.\n\n" ..
			"<p align='center'>אתם יכולים גם <FC>לתרום</FC> כל כמות <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>כאן</font></a> על מנת לתחזק את המשחק. כל הכספים המושגים דרך הקישור יהיו מושקעים בעדכוני משחק רציפים ושיפורים כלליים.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>אשכול בפורומים</font></a></p>"
		,
		[4] = "<FC><p align='center'>מה חדש?</p><N>\n\n" ..
			"• You can read about powers now.\n" ..
			"•המודול הפך לרשמי.\n" ..
			"•המודול נכתב מחדש לגמרי."
	},

	commandDescriptions = {
		help = "פותח את התפריט הזה.",
		powers = "פותח תפריט שמציג את כל הכוחות ותיאורם.",
		profile = "פותח את הפרופיל שלך או של אדם אחר.",
		leaderboard = "פותח את טבלת המובילים העולמית.",

		pw = "מגן על החדר עם סיסמה. שלחו ריק כדי להסירה."
	},
	commandsParameters = {
		profile = "[שם_השחקן] ",

		pw = "[סיסמה] "
	},
	["or"] = "או",

	profileData = {
		rounds = "סיבובים",
		victories = "נצחונות",
		kills = "הריגות",
		xp = "ניסיון",
		badges = "תגים"
	},

	leaderboard = "טבלת המובילים",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] טבלת המובילים עדיין טוענת. נסה שוב בעוד כמה שניות.",

	addMap = "<BV>[<FC>•<BV>] המפה <J>@%s</J> נוספה לתור המפות המקומי.",
	remMap = "<BV>[<FC>•<BV>] המפה <J>@%s</J> הוסרה מתור המפות המקומי.",
	listMaps = "<BV>[<FC>•<BV>] המפות (<J>#%d</J>): %s",

	enableParticles = "<ROSE>אל תשכחו לסמן 'הפעל אפקטים' בהגדרות בשביל לראות את המשחק בצורה הרגילה. ('תפריט' ← 'אפשרויות', ליד 'רשימת החדרים')</ROSE>",

	ban = "%s <ROSE>הורחק מ- #powers על ידי %s <ROSE>ל- %d שעות. סיבה: %s",
	unban = "<ROSE>הורחקת על ידי %s",
	isBanned = "<ROSE>אתה מורחק מ- #powers עד GMT+2 %s (%d שעות נשארו).",
	permBan = "%s <ROSE>הורחק לצמיתות מ- #powers על ידי %s<ROSE>. סיבה: %s",

	playerGetRole = "<FC>%s <FC>קודמו לדרגת <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>הם לא <font color='#%x'>%s</font> יותר.",

	enableReviewMode = "<BV>[<FC>•<BV>] <FC>מצב סיקור המפות<BV> לא דלוק. סיבובים הבאים <B>לא</B> יחשיבו נתונים והמפות שיופיעו הן במצב בדיקה לסיבוב המפה של המודול. כל הכוחות הופעלו ויש סיכוי גדול יותר שכוחות אלוהיות יופיעו!",
	disableReviewMode = "<BV>[<FC>•<BV>] <FC>מצב סקירת המפות<BV> כובה והכול יחזור לקדמותו בסיבוב הבא!",

	getBadge = "<FC>%s<FC> פתח תג #powers חדש!",

	setPassword = "<BL>[<VI>•<BL>] %s <BL>קבע את הסיסמה ל- %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>הסיר את הסיסמה של החדר."
}