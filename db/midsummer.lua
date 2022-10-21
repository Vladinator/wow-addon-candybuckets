local _, ns = ...

ns.modules = ns.modules or {}

ns.modules["midsummer"] = {
	event = "midsummer",
	texture = {
		[1] = "Interface\\Icons\\Spell_Fire_MasterOfElements",
		[2] = "Interface\\Icons\\INV_SummerFest_FireSpirit",
		[3] = "Interface\\Icons\\Spell_Shadow_Teleport"
	},
	title = {
		[1] = "Bonfire (Desecrate)",
		[2] = "Bonfire (Honor)",
		[3] = "Bonfire (Phased)"
	},
	quests = {
		{ quest = 11737, side = 2, extra = 1, [17] = {55.20, 15.30} },
		{ quest = 11808, side = 1, extra = 2, [17] = {55.54, 14.89} },
		{ quest = 28917, side = 1, extra = 1, [17] = {46.29, 14.02} },
		{ quest = 28930, side = 2, extra = 2, [17] = {46.00, 14.00} },
		{ quest = 29036, side = 3, extra = 2, [207] = {49.40, 51.40} },
		{ quest = 11580, side = 1, extra = 1, [21] = {49.60, 38.70} },
		{ quest = 11581, side = 2, extra = 1, [52] = {45.20, 62.30} },
		{ quest = 11583, side = 1, extra = 2, [52] = {45.00, 62.00} },
		{ quest = 11584, side = 2, extra = 2, [21] = {50.00, 38.00} },
		{ quest = 11732, side = 2, extra = 1, [14] = {44.58, 46.05} },
		{ quest = 11739, side = 2, extra = 1, [36] = {68.60, 59.90} },
		{ quest = 11742, side = 2, extra = 1, [27] = {53.80, 44.70} },
		{ quest = 11743, side = 2, extra = 1, [47] = {73.20, 54.90} },
		{ quest = 11745, side = 2, extra = 1, [37] = {43.20, 63.00} },
		{ quest = 11749, side = 2, extra = 1, [48] = {32.30, 40.40} },
		{ quest = 11751, side = 2, extra = 1, [49] = {24.40, 53.90} },
		{ quest = 11755, side = 2, extra = 1, [26] = {14.53, 49.80} },
		{ quest = 11756, side = 2, extra = 1, [22] = {43.60, 82.50} },
		{ quest = 11757, side = 2, extra = 1, [56] = {13.30, 47.30} },
		{ quest = 11761, side = 2, extra = 1, [210] = {51.70, 67.30} },
		{ quest = 11764, side = 1, extra = 1, [14] = {69.23, 42.89} },
		{ quest = 11766, side = 1, extra = 1, [15] = {24.20, 37.30} },
		{ quest = 11768, side = 1, extra = 1, [36] = {51.50, 29.30} },
		{ quest = 11776, side = 1, extra = 1, [25] = {54.50, 50.00} },
		{ quest = 11781, side = 1, extra = 1, [51] = {76.62, 14.14} },
		{ quest = 11784, side = 1, extra = 1, [26] = {76.63, 74.63} },
		{ quest = 11786, side = 1, extra = 1, [18] = {56.90, 51.80} },
		{ quest = 11801, side = 1, extra = 1, [210] = {50.60, 70.70} },
		{ quest = 11804, side = 1, extra = 2, [14] = {44.30, 46.02} },
		{ quest = 11810, side = 1, extra = 2, [36] = {68.00, 60.00} },
		{ quest = 11813, side = 1, extra = 2, [27] = {54.00, 45.00} },
		{ quest = 11814, side = 1, extra = 2, [47] = {73.00, 55.00} },
		{ quest = 11816, side = 1, extra = 2, [37] = {43.47, 62.60} },
		{ quest = 11820, side = 1, extra = 2, [48] = {32.00, 40.00} },
		{ quest = 11822, side = 1, extra = 2, [49] = {24.00, 53.00} },
		{ quest = 11826, side = 1, extra = 2, [26] = {14.34, 50.08} },
		{ quest = 11827, side = 1, extra = 2, [22] = {43.00, 82.00} },
		{ quest = 11828, side = 1, extra = 2, [56] = {13.00, 47.00} },
		{ quest = 11832, side = 1, extra = 2, [210] = {51.00, 67.00} },
		{ quest = 11837, side = 2, extra = 2, [210] = {50.00, 70.00} },
		{ quest = 11840, side = 2, extra = 2, [14] = {69.36, 42.58} },
		{ quest = 11842, side = 2, extra = 2, [15] = {23.17, 37.58} },
		{ quest = 11844, side = 2, extra = 2, [36] = {51.00, 29.00} },
		{ quest = 11853, side = 2, extra = 2, [25] = {55.00, 50.00} },
		{ quest = 11857, side = 2, extra = 2, [51] = {76.00, 14.00} },
		{ quest = 11860, side = 2, extra = 2, [26] = {76.63, 74.95} },
		{ quest = 11862, side = 2, extra = 2, [18] = {57.00, 52.00} },
		{ quest = 28910, side = 2, extra = 1, [50] = {51.60, 63.30} },
		{ quest = 28911, side = 1, extra = 1, [50] = {40.70, 52.00} },
		{ quest = 28912, side = 2, extra = 1, [15] = {18.50, 56.10} },
		{ quest = 28916, side = 2, extra = 1, [51] = {70.10, 14.80} },
		{ quest = 28918, side = 1, extra = 1, [22] = {29.10, 56.40} },
		{ quest = 28922, side = 1, extra = 2, [50] = {52.00, 63.60} },
		{ quest = 28924, side = 2, extra = 2, [50] = {40.00, 51.00} },
		{ quest = 28925, side = 1, extra = 2, [15] = {19.00, 56.00} },
		{ quest = 28929, side = 1, extra = 2, [51] = {70.25, 15.74} },
		{ quest = 28931, side = 2, extra = 2, [22] = {29.00, 57.00} },
		{ quest = 28943, side = 2, extra = 1, [241] = {47.00, 28.30} },
		{ quest = 28944, side = 1, extra = 1, [241] = {53.30, 46.50} },
		{ quest = 28945, side = 1, extra = 2, [241] = {47.00, 28.00} },
		{ quest = 28946, side = 2, extra = 2, [241] = {53.00, 46.00} },
		{ quest = 29031, side = 3, extra = 2, [205] = {49.30, 42.00} },
		{ quest = 11734, side = 2, extra = 1, [63] = {86.70, 41.40} },
		{ quest = 11740, side = 2, extra = 1, [62] = {49.00, 22.50} },
		{ quest = 11741, side = 2, extra = 1, [66] = {65.80, 17.00} },
		{ quest = 11744, side = 2, extra = 1, [70] = {62.10, 40.30} },
		{ quest = 11746, side = 2, extra = 1, [69] = {46.60, 43.80} },
		{ quest = 11753, side = 2, extra = 1, [57] = {54.70, 52.70} },
		{ quest = 11760, side = 2, extra = 1, [81] = {60.50, 33.40} },
		{ quest = 11762, side = 2, extra = 1, [71] = {52.70, 30.00} },
		{ quest = 11763, side = 2, extra = 1, [83] = {61.30, 47.10} },
		{ quest = 11765, side = 1, extra = 1, [63] = {51.60, 66.80} },
		{ quest = 11769, side = 1, extra = 1, [66] = {26.10, 77.40} },
		{ quest = 11770, side = 1, extra = 1, [1] = {52.00, 47.00} },
		{ quest = 11771, side = 1, extra = 1, [70] = {33.20, 30.80} },
		{ quest = 11773, side = 1, extra = 1, [69] = {72.50, 47.60} },
		{ quest = 11777, side = 1, extra = 1, [7] = {52.00, 59.30} },
		{ quest = 11780, side = 1, extra = 1, [65] = {53.00, 62.40} },
		{ quest = 11783, side = 1, extra = 1, [10] = {49.90, 54.20} },
		{ quest = 11800, side = 1, extra = 1, [81] = {50.80, 41.60} },
		{ quest = 11802, side = 1, extra = 1, [71] = {49.80, 28.07} },
		{ quest = 11803, side = 1, extra = 1, [83] = {58.13, 47.29} },
		{ quest = 11805, side = 1, extra = 2, [63] = {87.00, 42.00} },
		{ quest = 11811, side = 1, extra = 2, [62] = {49.00, 23.00} },
		{ quest = 11812, side = 1, extra = 2, [66] = {65.00, 17.00} },
		{ quest = 11815, side = 1, extra = 2, [70] = {62.00, 40.00} },
		{ quest = 11817, side = 1, extra = 2, [69] = {47.00, 44.00} },
		{ quest = 11824, side = 1, extra = 2, [57] = {54.80, 52.90} },
		{ quest = 11831, side = 1, extra = 2, [81] = {60.30, 33.50} },
		{ quest = 11833, side = 1, extra = 2, [71] = {52.64, 30.26} },
		{ quest = 11834, side = 1, extra = 2, [83] = {61.24, 47.25} },
		{ quest = 11836, side = 2, extra = 2, [81] = {51.00, 41.00} },
		{ quest = 11838, side = 2, extra = 2, [71] = {49.00, 27.00} },
		{ quest = 11839, side = 2, extra = 2, [83] = {58.22, 47.53} },
		{ quest = 11841, side = 2, extra = 2, [63] = {51.00, 66.00} },
		{ quest = 11845, side = 2, extra = 2, [66] = {26.00, 76.00} },
		{ quest = 11846, side = 2, extra = 2, [1] = {52.00, 47.00} },
		{ quest = 11847, side = 2, extra = 2, [70] = {33.00, 30.00} },
		{ quest = 11849, side = 2, extra = 2, [69] = {72.00, 47.00} },
		{ quest = 11852, side = 2, extra = 2, [7] = {51.00, 59.00} },
		{ quest = 11856, side = 2, extra = 2, [65] = {53.00, 62.00} },
		{ quest = 11859, side = 2, extra = 2, [10] = {50.00, 55.00} },
		{ quest = 28913, side = 2, extra = 1, [199] = {48.20, 72.40} },
		{ quest = 28914, side = 1, extra = 1, [199] = {40.70, 67.20} },
		{ quest = 28915, side = 2, extra = 1, [65] = {49.60, 51.10} },
		{ quest = 28919, side = 1, extra = 1, [76] = {60.40, 53.50} },
		{ quest = 28920, side = 1, extra = 1, [78] = {56.30, 65.80} },
		{ quest = 28921, side = 2, extra = 1, [78] = {60.00, 62.90} },
		{ quest = 28923, side = 2, extra = 2, [76] = {60.78, 53.48} },
		{ quest = 28926, side = 1, extra = 2, [199] = {48.00, 72.00} },
		{ quest = 28927, side = 2, extra = 2, [199] = {41.00, 68.00} },
		{ quest = 28928, side = 1, extra = 2, [65] = {49.00, 51.00} },
		{ quest = 28932, side = 1, extra = 2, [78] = {60.00, 63.00} },
		{ quest = 28933, side = 2, extra = 2, [78] = {56.00, 66.00} },
		{ quest = 28947, side = 2, extra = 1, [249] = {53.40, 32.00} },
		{ quest = 28948, side = 1, extra = 1, [249] = {53.00, 34.40} },
		{ quest = 28949, side = 2, extra = 2, [249] = {53.00, 34.00} },
		{ quest = 28950, side = 1, extra = 2, [249] = {53.00, 32.00} },
		{ quest = 29030, side = 3, extra = 2, [198] = {62.84, 22.69} },
		{ quest = 11735, side = 2, extra = 1, [97] = {44.70, 52.50} },
		{ quest = 11736, side = 2, extra = 1, [105] = {41.80, 65.90} },
		{ quest = 11738, side = 2, extra = 1, [106] = {56.00, 68.50} },
		{ quest = 11747, side = 2, extra = 1, [100] = {61.90, 58.50} },
		{ quest = 11750, side = 2, extra = 1, [107] = {49.70, 69.66} },
		{ quest = 11752, side = 2, extra = 1, [104] = {39.60, 54.30} },
		{ quest = 11754, side = 2, extra = 1, [108] = {54.20, 55.40} },
		{ quest = 11758, side = 2, extra = 1, [102] = {68.69, 52.11} },
		{ quest = 11759, side = 2, extra = 1, [109] = {31.10, 62.70} },
		{ quest = 11767, side = 1, extra = 1, [105] = {49.90, 59.00} },
		{ quest = 11772, side = 1, extra = 1, [94] = {46.30, 50.30} },
		{ quest = 11774, side = 1, extra = 1, [95] = {47.00, 25.90} },
		{ quest = 11775, side = 1, extra = 1, [100] = {57.30, 41.80} },
		{ quest = 11778, side = 1, extra = 1, [107] = {51.12, 34.02} },
		{ quest = 11779, side = 1, extra = 1, [104] = {33.60, 30.30} },
		{ quest = 11782, side = 1, extra = 1, [108] = {51.90, 43.30} },
		{ quest = 11787, side = 1, extra = 1, [102] = {35.60, 51.90} },
		{ quest = 11799, side = 1, extra = 1, [109] = {32.30, 68.40} },
		{ quest = 11806, side = 1, extra = 2, [97] = {44.00, 53.00} },
		{ quest = 11807, side = 1, extra = 2, [105] = {42.00, 66.00} },
		{ quest = 11809, side = 1, extra = 2, [106] = {55.00, 69.00} },
		{ quest = 11818, side = 1, extra = 2, [100] = {62.00, 58.00} },
		{ quest = 11854, side = 2, extra = 2, [107] = {50.91, 34.15} },
		{ quest = 11821, side = 1, extra = 2, [107] = {49.61, 69.47} },
		{ quest = 11823, side = 1, extra = 2, [104] = {40.00, 55.00} },
		{ quest = 11825, side = 1, extra = 2, [108] = {55.00, 55.00} },
		{ quest = 11829, side = 1, extra = 2, [102] = {69.00, 52.00} },
		{ quest = 11830, side = 1, extra = 2, [109] = {31.00, 63.00} },
		{ quest = 11835, side = 2, extra = 2, [109] = {32.00, 68.00} },
		{ quest = 11843, side = 2, extra = 2, [105] = {50.00, 59.00} },
		{ quest = 11848, side = 2, extra = 2, [94] = {46.40, 50.60} },
		{ quest = 11850, side = 2, extra = 2, [95] = {46.00, 26.00} },
		{ quest = 11851, side = 2, extra = 2, [100] = {57.11, 42.05} },
		{ quest = 11855, side = 2, extra = 2, [104] = {33.00, 30.00} },
		{ quest = 11858, side = 2, extra = 2, [108] = {52.00, 43.00} },
		{ quest = 11863, side = 2, extra = 2, [102] = {35.44, 51.61} },
		{ quest = 13440, side = 2, extra = 1, [114] = {55.10, 20.20} },
		{ quest = 13441, side = 1, extra = 1, [114] = {51.10, 11.90} },
		{ quest = 13442, side = 2, extra = 1, [119] = {47.90, 66.00} },
		{ quest = 13443, side = 2, extra = 1, [115] = {75.10, 43.70} },
		{ quest = 13444, side = 2, extra = 1, [117] = {57.70, 15.70} },
		{ quest = 13445, side = 2, extra = 1, [116] = {34.10, 60.70} },
		{ quest = 13446, side = 2, extra = 1, [120] = {41.40, 87.00} },
		{ quest = 13447, side = 2, extra = 1, [127] = {77.70, 74.90} },
		{ quest = 13449, side = 2, extra = 1, [121] = {40.40, 61.00} },
		{ quest = 13450, side = 1, extra = 1, [119] = {47.30, 61.70} },
		{ quest = 13451, side = 1, extra = 1, [115] = {38.50, 48.40} },
		{ quest = 13453, side = 1, extra = 1, [117] = {48.40, 13.50} },
		{ quest = 13454, side = 1, extra = 1, [116] = {19.10, 61.30} },
		{ quest = 13455, side = 1, extra = 1, [120] = {40.30, 85.60} },
		{ quest = 13457, side = 1, extra = 1, [127] = {80.50, 53.00} },
		{ quest = 13458, side = 1, extra = 1, [121] = {43.20, 71.40} },
		{ quest = 13485, side = 1, extra = 2, [114] = {55.00, 20.00} },
		{ quest = 13486, side = 1, extra = 2, [119] = {47.00, 66.00} },
		{ quest = 13487, side = 1, extra = 2, [115] = {75.00, 44.00} },
		{ quest = 13488, side = 1, extra = 2, [117] = {58.00, 16.00} },
		{ quest = 13489, side = 1, extra = 2, [116] = {34.00, 61.00} },
		{ quest = 13490, side = 1, extra = 2, [120] = {42.00, 87.00} },
		{ quest = 13491, side = 1, extra = 2, [127] = {78.00, 75.00} },
		{ quest = 13492, side = 1, extra = 2, [121] = {41.00, 61.00} },
		{ quest = 13493, side = 2, extra = 2, [114] = {51.00, 12.00} },
		{ quest = 13494, side = 2, extra = 2, [119] = {47.00, 62.00} },
		{ quest = 13495, side = 2, extra = 2, [115] = {39.00, 48.00} },
		{ quest = 13496, side = 2, extra = 2, [117] = {48.00, 13.00} },
		{ quest = 13497, side = 2, extra = 2, [116] = {19.00, 61.00} },
		{ quest = 13498, side = 2, extra = 2, [120] = {40.00, 86.00} },
		{ quest = 13499, side = 2, extra = 2, [127] = {80.00, 53.00} },
		{ quest = 13500, side = 2, extra = 2, [121] = {43.00, 71.00} },
		{ quest = 32496, side = 1, extra = 1, [390] = {77.90, 33.90} },
		{ quest = 32497, side = 3, extra = 2, [422] = {56.07, 69.58} },
		{ quest = 32498, side = 3, extra = 2, [371] = {47.20, 47.20} },
		{ quest = 32499, side = 3, extra = 2, [418] = {74.06, 9.46} },
		{ quest = 32500, side = 3, extra = 2, [379] = {71.10, 90.90} },
		{ quest = 32501, side = 3, extra = 2, [388] = {71.50, 56.30} },
		{ quest = 32502, side = 3, extra = 2, [376] = {51.81, 51.32} },
		{ quest = 32503, side = 2, extra = 1, [390] = {79.80, 37.00} },
		{ quest = 32509, side = 2, extra = 2, [390] = {77.80, 33.10} },
		{ quest = 32510, side = 1, extra = 2, [390] = {79.60, 37.20} },
		{ quest = 44570, side = 3, extra = 2, [542] = {48.00, 44.70} },
		{ quest = 44571, side = 3, extra = 2, [535] = {43.50, 71.80} },
		{ quest = 44572, side = 3, extra = 2, [550] = {80.50, 47.70} },
		{ quest = 44573, side = 3, extra = 2, [543] = {43.90, 93.80} },
		{ quest = 44579, side = 1, extra = 2, [539] = {42.60, 36.00} },
		{ quest = 44580, side = 2, extra = 2, [525] = {72.60, 65.00} },
		{ quest = 44583, side = 1, extra = 1, [525] = {72.80, 65.20} },
		{ quest = 44582, side = 2, extra = 1, [539] = {42.80, 35.90} },
		{ quest = 44574, side = 3, extra = 2, [630] = {48.30, 29.70} },
		{ quest = 44575, side = 3, extra = 2, [641] = {44.90, 58.00} },
		{ quest = 44576, side = 3, extra = 2, [650] = {55.50, 84.50} },
		{ quest = 44577, side = 3, extra = 2, [634] = {32.50, 42.10} },
		{ quest = 44613, side = 1, extra = 2, [680] = {23.00, 58.40} },
		{ quest = 44614, side = 2, extra = 2, [680] = {30.40, 45.40} },
		{ quest = 44627, side = 1, extra = 1, [680] = {30.30, 45.40} },
		{ quest = 44624, side = 2, extra = 1, [680] = {22.80, 58.20} },
		{ quest = 54737, side = 1, extra = 2, [895] = {76.35, 49.88} },
		{ quest = 54741, side = 1, extra = 2, [942] = {35.85, 51.33} },
		{ quest = 54743, side = 1, extra = 2, [896] = {40.22, 47.60} },
		{ quest = 54736, side = 2, extra = 1, [895] = {76.33, 49.77} },
		{ quest = 54739, side = 2, extra = 1, [942] = {35.90, 51.42} },
		{ quest = 54742, side = 2, extra = 1, [896] = {40.18, 47.49} },
		{ quest = 54746, side = 1, extra = 1, [863] = {40.09, 74.21} },
		{ quest = 54749, side = 1, extra = 1, [864] = {55.97, 47.70} },
		{ quest = 54744, side = 1, extra = 1, [862] = {53.35, 48.07} },
		{ quest = 54747, side = 2, extra = 2, [863] = {40.03, 74.30} },
		{ quest = 54750, side = 2, extra = 2, [864] = {56.01, 47.76} },
		{ quest = 54745, side = 2, extra = 2, [862] = {53.31, 48.11} },
	},
	patterns = {
		"^%s*[Hh][Oo][Nn][Oo][Rr]%s+[Tt][Hh][Ee]%s+[Ff][Ll][Aa][Mm][Ee]%s*$",
		"^%s*[Ee][Hh][Rr][Tt]%s+[Dd][Ii][Ee]%s+[Ff][Ll][Aa][Mm][Mm][Ee]%s*$",
		"^%s*[Hh][Oo][Nn][Rr][Aa][Rr]%s+[Ll][Aa]%s+[Ll][Ll][Aa][Mm][Aa]%s*$",
		"^%s*[Hh][Oo][Nn][Oo][Rr][Ee][Rr]%s+[Ll][Aa]%s+[Ff][Ll][Aa][Mm][Mm][Ee]%s*$",
		"^%s*[Oo][Nn][Oo][Rr][Aa]%s+[Ii][Ll]%s+[Ff][Aa][Ll][Òò]%s*$",
		"^%s*[Rr][Ee][Vv][Ee][Rr][Ee][Nn][Cc][Ii][Ee]%s+[Aa]%s+[Cc][Hh][Aa][Mm][Aa]%s*$",
		"^%s*[Пп][Оо][Кк][Лл][Оо][Нн][Ее][Нн][Ии][Ее]%s+[Оо][Гг][Нн][Юю]%s*$",
		"^%s*불꽃에%s+경의를%s*$",
		"^%s*祭拜这团火焰%s*$",
		"^%s*[Dd][Ee][Ss][Ee][Cc][Rr][Aa][Tt][Ee]%s+[Tt][Hh][Ii][Ss]%s+[Ff][Ii][Rr][Ee]%s*%!%s*$",
		"^%s*[Ee][Nn][Tt][Ww][Ee][Ii][Hh][Tt]%s+[Dd][Ii][Ee][Ss][Ee][Ss]%s+[Ff][Ee][Uu][Ee][Rr]%s*%!%s*$",
		"^%s*%¡%s*[Pp][Rr][Oo][Ff][Aa][Nn][Aa]%s+[Ee][Ss][Tt][Ee]%s+[Ff][Uu][Ee][Gg][Oo]%s*%!%s*$",
		"^%s*[Dd][Éé][Ss][Aa][Cc][Rr][Aa][Ll][Ii][Ss][Ee][Zz]%s+[Cc][Ee]%s+[Ff][Ee][Uu]%s*%!%s*$",
		"^%s*[Dd][Ii][Ss][Ss][Aa][Cc][Rr][Aa]%s+[Qq][Uu][Ee][Ss][Tt][Oo]%s+[Ff][Aa][Ll][Òò]%s*%!%s*$",
		"^%s*[Pp][Rr][Oo][Ff][Aa][Nn][Ee]%s+[Oo]%s+[Ff][Oo][Gg][Oo]%s*%!%s*$",
		"^%s*[Оо][Сс][Кк][Вв][Ее][Рр][Нн][Ее][Нн][Ии][Ее]%s+[Оо][Гг][Нн][Яя]%s*$",
		"^%s*화톳불%s+모독%s*%!%s*$",
		"^%s*亵渎这团火焰%s*%！%s*$",
	}
}
