local _, ns = ... ---@type any, CandyBucketsNS

ns.modules = ns.modules or {}

ns.modules["brewfest"] = {
	event = "brewfest",
	texture = {
		[1] = "Interface\\Icons\\INV_Cask_04",
	},
	title = {
		[1] = "Bar Tab Barrel",
	},
	quests = {
		{ quest = 76531, side = 3, extra = 1, [2022] = {58.30, 67.60} },
		{ quest = 77095, side = 3, extra = 1, [2022] = {76.30, 35.40} },
		{ quest = 77096, side = 3, extra = 1, [2024] = {46.90, 40.20} },
		{ quest = 77097, side = 3, extra = 1, [2024] = {12.40, 49.30} },
		{ quest = 77099, side = 3, extra = 1, [2023] = {28.60, 60.40} },
		{ quest = 77152, side = 3, extra = 1, [2023] = {59.80, 38.80} },
		{ quest = 77153, side = 3, extra = 1, [2112] = {47.80, 46.90} },
		{ quest = 77155, side = 3, extra = 1, [2025] = {52.20, 81.50} },
		{ quest = 77744, side = 3, extra = 1, [2022] = {47.70, 83.30} },
		{ quest = 77745, side = 3, extra = 1, [2023] = {85.80, 35.40} },
		{ quest = 77746, side = 3, extra = 1, [2024] = {62.80, 57.80} },
		{ quest = 77747, side = 3, extra = 1, [2025] = {50.10, 42.70} },
		{ quest = 84305, side = 3, extra = 1, [2339] = {44.10, 46.07} },
		{ quest = 84306, side = 3, extra = 1, [2248] = {41.86, 74.24} },
		{ quest = 84307, side = 3, extra = 1, [2214] = {44.08, 32.27} },
		{ quest = 84308, side = 3, extra = 1, [2214] = {59.16, 78.84} },
		{ quest = 84310, side = 3, extra = 1, [2215] = {49.23, 39.51} },
		{ quest = 84311, side = 3, extra = 1, [2215] = {42.78, 55.80} },
		{ quest = 84313, side = 3, extra = 1, [2216] = {57.79, 39.85} },
		{ quest = 84314, side = 3, extra = 1, [2213] = {49.80, 21.59} },
		{ quest = 84315, side = 3, extra = 1, [2255] = {77.81, 62.73} },
		{ quest = 84316, side = 3, extra = 1, [2255] = {56.70, 38.68} },
	},
	patterns = {
		"^%s*[Bb][Aa][Rr]%s+[Tt][Aa][Bb]%s+[Bb][Aa][Rr][Rr][Ee][Ll]%s*$",
		"^%s*[Ss][Cc][Hh][Aa][Nn][Kk][Ff][Aa][Ss][Ss]%s*$",
		"^%s*[Bb][Aa][Rr][Rr][Ii][Ll][Ee][Ss]%s+[Pp][Oo][Rr]%s+[Dd][Oo][Qq][Uu][Ii][Ee][Rr]%s*$",
		"^%s*[Tt][Oo][Nn][Nn][Ee][Aa][Uu]%s+[Dd][’'][Aa][Rr][Dd][Oo][Ii][Ss][Ee]%s+[Dd][Ee]%s+[Bb][Aa][Rr]%s*$",
		"^%s*[B][Aa][Rr][Ii][Ll][Oo][Tt][Tt][Oo]%s*$",
		"^%s*[B][Aa][Rr][Rr][Ii][Ll]%s+[Nn][Aa]%s+[Cc][Oo][Nn][Tt][Aa]%s*$",
		"^%s*[П][Оо][Лл][Нн][Аа][Яя]%s+[Бб][Оо][Чч][Кк][Аа]%s*$",
		"^%s*술집%s+외상%s+통%s*$",
		"^%s*熟客酒桶%s*$",
	}
}
