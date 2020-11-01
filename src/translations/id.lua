translations.id = {
	-- Main messages
	greeting = "<FC>Selamat datang di <B>#powers</B>!\n" ..
		"\t• Tekan <B>H</B> atau ketik <B>!help</B> untuk mempelajari tentang modul.\n" ..
		"\t• Tekan <B>O</B> atau ketik <B>!powers</B> untuk mempelajari tentang kekuatan.\n" ..
		"\t• Ketik <B>!modes</B> untuk mempelajari mode lain game ini.",
	kill = "<R>%s<FC> membunuh %s",

	gameModes = "<font size='-2'><FC>[<J>•</J>] Mode game baru:\n" ..
		"\t • Module lag? Coba versi ringannya di /room #powers0lagmode\n" ..
		"\t • Ingin naik level lebih cepat? Coba mode pemula (khusus level rendah) di /room #powers0noobmode\n" ..
		"\t • Terlalu pro? Tantang dirimu di mode pro (khusus level tinggi) di /room #powers0promode\n" ..
		"\t • Tidak peduli status dan ingin mencoba semua kekuatan? Coba mode bebas di /room #powers0freemode</FC></font>",

	-- Victory
	mentionWinner = "<FC>%s<FC> memenangkan ronde ini!",
	noWinner = "<FC>Tidak ada pemenang di ronde ini. :(",

	-- Powers
	powers = {
		lightSpeed = "Kecepatan Cahaya",
		laserBeam = "Sinar Laser",
		wormHole = "Lubang Cacing",
		doubleJump = "Lompat Ganda",
		helix = "Spiral",
		dome = "Kubah",
		lightning = "Petir",
		superNova = "Supernova",
		meteorSmash = "Bantingan Meteor",
		gravitationalAnomaly = "Anomali Gravitasi",
		deathRay = "Sinar Kematian",
		atomic = "Atomic",
		dayOfJudgement = "Hari Penghakiman",
		waterSplash = "Cipratan Air"
	},
	powersDescriptions = {
		lightSpeed = "Menggerakkan tikusmu dalam kecepatan cahaya, mendorong semua musuh.",
		laserBeam = "Menembakkan sinar laser yang sangat kuat sehingga musuh bisa merasakannya.",
		wormHole = "Men-teleportasikan tikusmu ke depan melalui Lubang Cacing.",
		doubleJump = "Melakukan lompat ganda yang tinggi.",
		helix = "Mempercepat tikusmu secara diagonal dengan spiral yang kuat.",
		dome = "Menciptakan kubah pelindung yang mendorong semua musuh.",
		lightning = "Memanggil petir kuat yang menyetrum musuh.",
		superNova = "Membuat supernova yang menghancurkan semua musuh di sekitarmu.",
		meteorSmash = "Membanting semua musuh seperti ditabrak meteor.",
		gravitationalAnomaly = "Memulai anomali gravitasi.",
		deathRay = "Memanggang musuh dengan sinar kematian yang kuat dan misterius.",
		atomic = "Mengganti ukuran semua pemain dengan acak.",
		dayOfJudgement = "Menghidupkan kembali semua musuh yang mati, semuanya terhubung satu sama lain.",
		waterSplash = "Memunculkan tetesan air dari Antartika."
	},
	powerType = {
		atk = "SERANGAN (%d)",
		def = "PERTAHANAN",
		divine = "ILAHI"
	},

	unlockPower = "<FC>[<J>•<FC>] Anda telah mendapatkan kekuatan: %s",

	-- Level names
	-- @Translator notes: if it has gender variation, { "male", "female" }, else "neutral".
	levelName = {
		[000] = "Mutan",
		[010] = "Necromancer",
		[020] = "Ilmuwan",
		[030] = "Titan",
		[040] = { "Penyihir", "Penyihir Wanita" },
		[050] = "Pengendali Kenyataan",
		[060] = { "Penguasa Mantra", "Nyonya Mantra" },
		[070] = "Pemanggil Perdukunan",
		[080] = "Penunggang Kuda Wabah",
		[090] = "Penunggang Kuda Kelaparan",
		[100] = "Penunggang Kuda Perang",
		[110] = "Penunggang Kuda Kematian",
		[120] = "Kekosongan"
	},

	newLevel = "<FC>%s<FC> telah mencapai level <B>%d</B>!",
	level = "Level %d",

	-- Help
	helpTitles = {
		[1] = "Powers!", -- @Translator notes: remove this line
		[2] = "Perintah",
		[3] = "Berkontribusi",
		[4] = "Apa yang baru?"
	},
	helpContent = {
		[1] = "<FC><p align='center'>#POWERS!</p>\n\n" ..
			"<J>Tujuan Anda di modul ini adalah untuk bertahan dari serangan lawan.\n\n" ..
			"<N>Ada berbagai macam kekuatan <font size='12'>- yang bisa didapatkan dengan meraih level yang lebih tinggi -</font> untuk menyerang dan bertahan.\n" ..
			"Ketik <FC><B>!powers</B><N> untuk mempelajari lebih lanjut tentang kekuatan yang telah Anda dapatkan sejauh ini!\n\n" ..
			"%s\n\n" .. -- enableParticles
			"Modul ini dikembangkan oleh %s"
		,
		[2] = "<FC><p align='center'>PERINTAH UMUM</p><N>\n\n<font size='12'>", -- commands
		[3] = "<FC><p align='center'>BERKONTRIBUSI<N>\n\n" ..
			"Kami menyukai open source <font color='#E91E63'>♥</font>! Anda bisa melihat dan mengubah kode sumber modul ini di <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n\n" ..
			"Mengurus modul sepenuhnya bersifat sukarela, jadi bantuan apa pun terkait <V>Kode<N>, <V>perbaikan bug dan laporan<N>, <V>saran dan peningkatan fitur<N>, <V>pembuatan peta <N>diterima dan sangat dihargai.\n" ..
			"<p align='left'>• Anda bisa <FC>melaporkan bug <N>atau <FC>membuat saran <N>di <a href='event:print_discord.gg/quch83R'><font color='#087ECC'>Discord</font></a> dan/atau di <a href='event:print_github.com/a801-luadev/powers'><font color='#087ECC'>Github</font></a>.\n" ..
			"• Anda bisa <FC>mensubmit peta <N>di <a href='event:print_atelier801.com/topic?f=6&t=888677'><font color='#087ECC'>Thread submisi peta kami di Forums</font></a>.\n\n" ..
			"<p align='center'>Anda juga bisa <FC>berdonasi</FC> berapapun jumlahnya <a href='event:print_a801-luadev.github.io/?redirect=powers'><font color='#087ECC'>disini</font></a> Untuk membantu memelihara modul. Semua dana yang diperoleh melalui link akan digunakan dalam pembaruan modul yang konstan dan peningkatan umum.\n\n" ..
			"<a href='event:print_atelier801.com/topic?f=6&t=888676'><font size='18' color='#087ECC'>Thread on Forums</font></a></p>"
		,
		[4] = { "<FC><p align='center'>APA YANG BARU?</p><N>\n",
			"• Modul seluruhnya telah ditulis ulang.",
			"• Modul menjadi resmi.",
			"• Anda bisa membaca tentang semua kekuatan sekarang.",
			"• kekuatan baru <B>Cipratan Air</B>.",
			"• Tiga lencana baru.",
			"• Mode ruang yang baru: <B>#powers0lagmode</B>, <B>#powers0freemode</B>, <B>#powers0noobmode</B>, <B>#powers0promode</B>.",
			"• Perintah baru <B>!modes</B>.",
		}
	},

	-- Commands
	commandDescriptions = {
		help = "Membuka menu ini.",
		powers = "Membuka menu yang berisi list seluruh kekuatan dan informasinya.",
		profile = "Membuka profilmu atau profil orang lain.",
		leaderboard = "Membuka papan peringkat global.",
		modes = "Menampilkan mode game.",

		pw = "Melindungi ruangan dengan kata sandi. Kirim kosong untuk menghapusnya.",
    },
	commandsParameters = {
		profile = "[nama_pemain] ",

		pw = "[kata sandi] ",
    },
	["or"] = "atau",

	-- Profile
	profileData = {
		rounds = "Ronde",
		victories = "Kemenangan",
		kills = "Membunuh",
		xp = "Pengalaman",
		badges = "Lencana"
	},

	-- Leaderboard
	leaderboard = "Papan Peringkat",
	leaderboardIsLoading = "<BL>[<VI>•<BL>] Papan peringkat sedang dimuat. Coba lagi dalam beberapa detik.",

	-- Map management
	addMap = "<BV>[<FC>•<BV>] Peta <J>@%s</J> telah ditambahkan ke antrian peta lokal.",
	remMap = "<BV>[<FC>•<BV>] Peta <J>@%s</J> telah dihapus dari antrian peta lokal.",
	listMaps = "<BV>[<FC>•<BV>] Peta (<J>#%d</J>): %s",

	-- Warning
	enableParticles = "<ROSE>JANGAN LUPA untuk AKTIFKAN efek/partikel khusus agar dapat melihat modul dengan benar. (Di 'Menu' → 'Opsi', di samping 'Daftar Kamar')</ROSE>",

	-- Ban
	ban = "%s <ROSE>telah di ban dari #powers oleh %s <ROSE>selama %d hours. Alasan: %s",
	unban = "<ROSE>Anda telah di unban oleh %s",
	isBanned = "<ROSE>Anda di ban dari #powers hingga GMT+2 %s (%d jam lagi).", -- @Translator notes: keep GMT+2
	permBan = "%s <ROSE>telah di ban permanen dari #powers oleh %s<ROSE>. Alasan: %s",

	-- Promotion
	playerGetRole = "<FC>%s <FC>telah di promosikan ke <font color='#%x'>%s</font>!",
	playerLoseRole = "<FC>%s <FC>sudah tidak menjadi <font color='#%x'>%s</font> lagi.",

	-- Review
	enableReviewMode = "<BV>[<FC>•<BV>] <FC>Mode Review Peta<BV> diaktifkan. Ronde selanjutnya <B>tidak</B> akan menghitung status dan peta yang muncul adalah peta yang sedang diuji untuk rotasi peta modul. Semua kekuatan telah diaktifkan dan kekuatan ilahi lebih mungkin terjadi!",
	disableReviewMode = "<BV>[<FC>•<BV>] <FC>Mode Review Peta<BV> telah dimatikan dan semuanya akan kembali normal di ronde selanjutnya!",
	freeMode = "<BV>[<FC>•<BV>] Status <B>tidak akan</B> dihitung di mode ini. Semua kekuatan telah diaktifkan dan kekuatan ilahi lebih mungkin terjadi!",

	-- Badges
	getBadge = "<FC>%s<FC> telah mendapatkan lencana #powers baru!",

	-- Password
	setPassword = "<BL>[<VI>•<BL>] %s <BL>telah mengatur kata sandi menjadi %q.",
	removePassword = "<BL>[<VI>•<BL>] %s <BL>telah menghapus kata sandi ruangan."
}