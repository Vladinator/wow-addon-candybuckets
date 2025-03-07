local _, ns = ... ---@type any, CandyBucketsNS

ns.modules = ns.modules or {}

ns.modules["hallow"] = {
	event = "hallow",
	texture = {
		[1] = "Interface\\Icons\\Achievement_Halloween_Candy_01",
		[2] = "Interface\\Icons\\Spell_Shadow_Teleport",
		[3] = "Interface\\Icons\\Achievement_Halloween_Candy_01",
		[4] = "Interface\\GossipFrame\\GossipGossipIcon"
	},
	title = {
		[1] = "Candy Bucket",
		[2] = "Candy Bucket (Phased)",
		[3] = "Candy Bucket (Requires Reputation)",
		[4] = "Zidormi (Change Phase)"
	},
	quests = {
		{ quest = 12349, side = 1, [70] = {66.60, 45.30} },
		{ quest = 28960, side = 1, [17] = {60.70, 14.20} },
		{ quest = 28961, side = 1, [17] = {44.40, 87.70} },
		{ quest = 28960, side = 1, extra = 4, style = 2, waypoint = false, [17] = {48.16, 7.28} },
		{ quest = 28961, side = 1, extra = 4, style = 2, waypoint = false, [17] = {48.16, 7.28} },
		{ quest = 28959, side = 2, [17] = {40.50, 11.40} },
		{ quest = 28959, side = 2, extra = 4, style = 2, waypoint = false, [17] = {48.16, 7.28} },
		{ quest = 12404, side = 3, extra = 3, [111] = {56.20, 81.80} },
		{ quest = 12409, side = 3, extra = 3, [104] = {56.30, 59.80} },
		{ quest = 12340, side = 1, extra = 2, [52] = {56.76, 47.31} },
		{ quest = 12340, side = 1, extra = 2, [52] = {52.90, 53.60} },
		{ quest = 12364, side = 2, [94] = {48.10, 47.80} },
		{ quest = 12369, side = 2, [110] = {79.60, 57.90} },
		{ quest = 12370, side = 2, [110] = {67.60, 73.20} },
		{ quest = 12383, side = 2, [70] = {36.80, 32.40} },
		{ quest = 12398, side = 3, [70] = {41.90, 74.10} },
		{ quest = 13463, side = 3, [125] = {48.30, 40.80} },
		{ quest = 13472, side = 3, [126] = {37.95, 59.99} },
		{ quest = 28973, side = 2, [241] = {53.40, 42.90} },
		{ quest = 28974, side = 2, [241] = {45.10, 76.70} },
		{ quest = 28975, side = 2, [241] = {75.30, 54.80} },
		{ quest = 28976, side = 2, [241] = {75.40, 16.50} },
		{ quest = 28977, side = 1, [241] = {60.40, 58.20} },
		{ quest = 28978, side = 1, [241] = {49.60, 30.40} },
		{ quest = 28979, side = 1, [241] = {43.60, 57.30} },
		{ quest = 28980, side = 1, [241] = {79.50, 78.50} },
		{ quest = 28999, side = 3, [198] = {63.00, 24.10} },
		{ quest = 29000, side = 3, [198] = {18.70, 37.30} },
		{ quest = 29001, side = 3, [198] = {42.70, 45.60} },
		{ quest = 29016, side = 3, [249] = {26.60, 7.30} },
		{ quest = 29016, side = 3, extra = 2, [1527] = {26.60, 7.30} },
		{ quest = 29016, side = 3, extra = 4, style = 2, waypoint = false, [1527] = {56.02, 35.14} },
		{ quest = 29017, side = 3, [249] = {54.70, 33.00} },
		{ quest = 29017, side = 3, extra = 2, [1527] = {54.70, 33.00} },
		{ quest = 29017, side = 3, extra = 4, style = 2, waypoint = false, [1527] = {56.02, 35.14} },
		{ quest = 32020, side = 2, [418] = {28.25, 50.74} },
		{ quest = 32022, side = 2, [392] = {58.30, 76.90} },
		{ quest = 32034, side = 3, [418] = {51.45, 77.33} },
		{ quest = 32036, side = 3, [418] = {75.96, 6.96} },
		{ quest = 32047, side = 2, [418] = {61.03, 25.14} },
		{ quest = 32052, side = 1, [393] = {37.30, 67.10} },
		{ quest = 29019, side = 2, [207] = {51.20, 50.00} },
		{ quest = 29020, side = 1, [207] = {47.40, 51.70} },
		{ quest = 12286, side = 1, [37] = {43.70, 66.00} },
		{ quest = 12332, side = 1, [27] = {54.50, 50.70} },
		{ quest = 12335, side = 1, [87] = {18.60, 51.30} },
		{ quest = 12336, side = 1, [84] = {60.50, 75.20} },
		{ quest = 12339, side = 1, [48] = {35.50, 48.40} },
		{ quest = 12342, side = 1, [49] = {26.40, 41.60} },
		{ quest = 12343, side = 1, [56] = {10.80, 60.90} },
		{ quest = 12344, side = 1, [47] = {73.90, 44.40} },
		{ quest = 12351, side = 1, [26] = {14.20, 44.70} },
		{ quest = 12363, side = 2, [18] = {60.90, 51.50} },
		{ quest = 12363, side = 2, extra = 2, [2070] = {60.90, 51.50} },
		{ quest = 12363, side = 2, extra = 4, style = 2, waypoint = false, [2070] = {69.45, 62.80} },
		{ quest = 12368, side = 2, [90] = {67.70, 37.90} },
		{ quest = 12371, side = 2, [21] = {46.40, 42.80} },
		{ quest = 12376, side = 2, [25] = {57.90, 47.30} },
		{ quest = 12380, side = 2, [14] = {69.00, 33.40} },
		{ quest = 12380, side = 2, extra = 4, style = 2, waypoint = false, [14] = {38.25, 90.09} },
		{ quest = 12382, side = 2, [50] = {37.30, 51.70} },
		{ quest = 12384, side = 2, [51] = {46.90, 56.70} },
		{ quest = 12387, side = 2, [26] = {78.20, 81.40} },
		{ quest = 12397, side = 3, [210] = {40.90, 73.80} },
		{ quest = 12402, side = 3, [24] = {41.02, 90.77} },
		{ quest = 28954, side = 1, [14] = {40.10, 49.00} },
		{ quest = 28954, side = 1, extra = 4, style = 2, waypoint = false, [14] = {38.25, 90.09} },
		{ quest = 28955, side = 3, [15] = {65.90, 35.80} },
		{ quest = 28956, side = 1, [15] = {20.90, 56.20} },
		{ quest = 28957, side = 2, [15] = {18.30, 42.80} },
		{ quest = 28962, side = 2, [25] = {60.30, 63.80} },
		{ quest = 28963, side = 1, [48] = {82.90, 63.60} },
		{ quest = 28964, side = 1, [50] = {53.10, 66.90} },
		{ quest = 28965, side = 3, [32] = {39.40, 66.10} },
		{ quest = 28966, side = 2, [21] = {44.30, 20.40} },
		{ quest = 28967, side = 3, [51] = {71.70, 14.00} },
		{ quest = 28968, side = 1, [51] = {29.00, 32.60} },
		{ quest = 28969, side = 2, [210] = {35.10, 27.20} },
		{ quest = 28970, side = 1, [26] = {66.20, 44.40} },
		{ quest = 28971, side = 2, [26] = {31.90, 57.90} },
		{ quest = 28972, side = 2, [18] = {83.00, 72.00} },
		{ quest = 28972, side = 2, extra = 2, [2070] = {83.00, 72.00} },
		{ quest = 28972, side = 2, extra = 4, style = 2, waypoint = false, [2070] = {69.45, 62.80} },
		{ quest = 28981, side = 3, [201] = {63.40, 60.20} },
		{ quest = 28982, side = 3, [205] = {49.20, 41.90} },
		{ quest = 28983, side = 1, [205] = {49.70, 57.40} },
		{ quest = 28984, side = 2, [205] = {51.50, 62.50} },
		{ quest = 28985, side = 1, [204] = {54.70, 72.20} },
		{ quest = 28986, side = 2, [204] = {51.30, 60.60} },
		{ quest = 28987, side = 2, [22] = {48.20, 63.70} },
		{ quest = 28988, side = 1, [22] = {43.40, 84.50} },
		{ quest = 28990, side = 1, [56] = {26.10, 25.90} },
		{ quest = 28991, side = 1, [56] = {58.10, 39.20} },
		{ quest = 12331, side = 1, [57] = {55.40, 52.30} },
		{ quest = 12334, side = 1, [89] = {62.20, 33.00} },
		{ quest = 12345, side = 1, [63] = {37.00, 49.30} },
		{ quest = 12347, side = 1, [65] = {40.60, 17.70} },
		{ quest = 12348, side = 1, [66] = {66.30, 6.70} },
		{ quest = 12350, side = 1, [69] = {46.30, 45.20} },
		{ quest = 12361, side = 2, [1] = {51.60, 41.70} },
		{ quest = 12362, side = 2, [7] = {46.80, 60.40} },
		{ quest = 12366, side = 2, [85] = {53.80, 78.80} },
		{ quest = 12367, side = 2, [88] = {45.70, 64.50} },
		{ quest = 12374, side = 2, [10] = {49.50, 58.00} },
		{ quest = 12377, side = 2, [63] = {73.90, 60.70} },
		{ quest = 12378, side = 2, [65] = {50.40, 63.80} },
		{ quest = 12381, side = 2, [66] = {24.10, 68.30} },
		{ quest = 12386, side = 2, [69] = {74.80, 45.10} },
		{ quest = 12396, side = 3, [10] = {67.30, 74.70} },
		{ quest = 12399, side = 3, [71] = {52.60, 27.10} },
		{ quest = 12400, side = 3, [83] = {59.80, 51.20} },
		{ quest = 12401, side = 3, [81] = {55.50, 36.70} },
		{ quest = 28951, side = 1, [62] = {50.80, 18.80} },
		{ quest = 28952, side = 1, [69] = {51.10, 17.80} },
		{ quest = 28953, side = 2, [63] = {50.20, 67.20} },
		{ quest = 28958, side = 2, [63] = {38.60, 42.40} },
		{ quest = 28989, side = 2, [63] = {13.00, 34.10} },
		{ quest = 28992, side = 2, [76] = {57.10, 50.20} },
		{ quest = 28993, side = 3, [66] = {56.80, 50.00} },
		{ quest = 28994, side = 3, [77] = {44.60, 28.90} },
		{ quest = 28995, side = 1, [77] = {61.80, 26.70} },
		{ quest = 28996, side = 2, [69] = {41.40, 15.60} },
		{ quest = 28998, side = 2, [69] = {52.00, 47.70} },
		{ quest = 29002, side = 2, [10] = {56.30, 40.10} },
		{ quest = 29003, side = 2, [10] = {62.50, 16.60} },
		{ quest = 29004, side = 2, [199] = {39.30, 20.10} },
		{ quest = 29005, side = 2, [199] = {40.70, 69.30} },
		{ quest = 29006, side = 1, [199] = {39.00, 11.00} },
		{ quest = 29007, side = 1, [199] = {65.60, 46.60} },
		{ quest = 29008, side = 1, [199] = {49.10, 68.50} },
		{ quest = 29009, side = 2, [65] = {66.50, 64.20} },
		{ quest = 29010, side = 1, [65] = {71.00, 79.10} },
		{ quest = 29011, side = 1, [65] = {59.10, 56.30} },
		{ quest = 29012, side = 1, [65] = {39.50, 32.80} },
		{ quest = 29013, side = 1, [65] = {31.50, 60.70} },
		{ quest = 29014, side = 3, [71] = {55.70, 60.90} },
		{ quest = 29018, side = 3, [78] = {55.20, 62.10} },
		{ quest = 12333, side = 1, [97] = {48.50, 49.10} },
		{ quest = 12337, side = 1, [103] = {59.30, 19.20} },
		{ quest = 12341, side = 1, [106] = {55.70, 59.90} },
		{ quest = 12352, side = 1, [100] = {54.30, 63.60} },
		{ quest = 12353, side = 1, [100] = {23.40, 36.50} },
		{ quest = 12354, side = 1, [102] = {67.20, 49.00} },
		{ quest = 12355, side = 1, [102] = {41.90, 26.20} },
		{ quest = 12356, side = 1, [108] = {56.60, 53.20} },
		{ quest = 12357, side = 1, [107] = {54.20, 75.80} },
		{ quest = 12358, side = 1, [105] = {35.80, 63.80} },
		{ quest = 12359, side = 1, [105] = {61.00, 68.10} },
		{ quest = 12360, side = 1, [104] = {37.10, 58.20} },
		{ quest = 12365, side = 2, [94] = {43.70, 71.10} },
		{ quest = 12373, side = 2, [95] = {48.60, 32.00} },
		{ quest = 12388, side = 2, [100] = {56.80, 37.50} },
		{ quest = 12389, side = 2, [100] = {26.90, 59.60} },
		{ quest = 12390, side = 2, [102] = {30.70, 50.90} },
		{ quest = 12391, side = 2, [108] = {48.80, 45.20} },
		{ quest = 12392, side = 2, [107] = {56.70, 34.60} },
		{ quest = 12393, side = 2, [105] = {53.40, 55.50} },
		{ quest = 12394, side = 2, [105] = {76.20, 60.40} },
		{ quest = 12395, side = 2, [104] = {30.30, 27.80} },
		{ quest = 12403, side = 3, [102] = {78.50, 62.90} },
		{ quest = 12406, side = 3, [105] = {62.90, 38.30} },
		{ quest = 12407, side = 3, [109] = {32.00, 64.40} },
		{ quest = 12408, side = 3, [109] = {43.40, 36.10} },
		{ quest = 12940, side = 3, [121] = {59.30, 57.20} },
		{ quest = 12941, side = 3, [121] = {40.80, 66.00} },
		{ quest = 12944, side = 1, [116] = {32.00, 60.20} },
		{ quest = 12945, side = 1, [116] = {59.60, 26.40} },
		{ quest = 12946, side = 2, [116] = {20.90, 64.70} },
		{ quest = 12947, side = 2, [116] = {65.40, 47.00} },
		{ quest = 12950, side = 3, [119] = {26.70, 59.20} },
		{ quest = 13433, side = 1, [117] = {58.40, 62.80} },
		{ quest = 13434, side = 1, [117] = {30.80, 41.50} },
		{ quest = 13435, side = 1, [117] = {60.50, 15.90} },
		{ quest = 13436, side = 1, [114] = {58.50, 67.90} },
		{ quest = 13437, side = 1, [114] = {57.10, 18.80} },
		{ quest = 13438, side = 1, [115] = {29.00, 56.20} },
		{ quest = 13439, side = 1, [115] = {77.50, 51.30} },
		{ quest = 13448, side = 1, [120] = {28.70, 74.30} },
		{ quest = 13452, side = 3, [117] = {25.40, 59.80} },
		{ quest = 13456, side = 3, [115] = {60.10, 53.50} },
		{ quest = 13459, side = 3, [115] = {48.20, 74.70} },
		{ quest = 13460, side = 3, [114] = {78.40, 49.20} },
		{ quest = 13461, side = 3, [120] = {41.10, 85.90} },
		{ quest = 13462, side = 3, [120] = {30.90, 37.20} },
		{ quest = 13464, side = 2, [117] = {49.50, 10.80} },
		{ quest = 13465, side = 2, [117] = {52.10, 66.20} },
		{ quest = 13466, side = 2, [117] = {79.20, 30.60} },
		{ quest = 13467, side = 2, [114] = {76.70, 37.40} },
		{ quest = 13468, side = 2, [114] = {41.80, 54.40} },
		{ quest = 13469, side = 2, [115] = {37.80, 46.40} },
		{ quest = 13470, side = 2, [115] = {76.80, 63.20} },
		{ quest = 13471, side = 2, [120] = {67.60, 50.60} },
		{ quest = 13473, side = 1, [125] = {42.50, 63.50} },
		{ quest = 13474, side = 2, [125] = {66.60, 30.10} },
		{ quest = 13501, side = 2, [114] = {49.70, 10.00} },
		{ quest = 13548, side = 2, [120] = {37.10, 49.60} },
		{ quest = 32021, side = 3, [371] = {41.60, 23.10} },
		{ quest = 32023, side = 3, [422] = {55.20, 71.10} },
		{ quest = 32024, side = 3, [422] = {55.90, 32.30} },
		{ quest = 32026, side = 3, [433] = {54.90, 72.30} },
		{ quest = 32027, side = 3, [371] = {45.70, 43.60} },
		{ quest = 32028, side = 2, [371] = {28.00, 47.40} },
		{ quest = 32029, side = 3, [371] = {48.00, 34.60} },
		{ quest = 32031, side = 3, [371] = {55.70, 24.40} },
		{ quest = 32032, side = 3, [371] = {54.60, 63.30} },
		{ quest = 32033, side = 1, [371] = {59.60, 83.20} },
		{ quest = 32037, side = 3, [379] = {57.40, 59.90} },
		{ quest = 32039, side = 3, [379] = {72.70, 92.20} },
		{ quest = 32040, side = 2, [379] = {62.70, 80.50} },
		{ quest = 32041, side = 3, [379] = {64.20, 61.20} },
		{ quest = 32042, side = 1, [379] = {54.10, 82.80} },
		{ quest = 32043, side = 3, [388] = {71.10, 57.80} },
		{ quest = 32044, side = 3, [390] = {35.10, 77.70}, [1530] = {35.10, 75.60} },
		{ quest = 32046, side = 3, [376] = {19.80, 55.70} },
		{ quest = 32048, side = 3, [376] = {83.60, 20.30} },
		{ quest = 32049, side = 1, [371] = {44.80, 84.40} },
		{ quest = 32050, side = 2, [371] = {28.50, 13.30} },
		{ quest = 32051, side = 3, [379] = {62.30, 29.00} },
		{ quest = 39657, side = 1, [582] = {44.00, 52.00} },
		{ quest = 39657, side = 2, [590] = {47.50, 37.80} },
		{ quest = 43055, side = 3, [627] = {48.10, 41.30} },
		{ quest = 43056, side = 1, [627] = {41.80, 64.20} },
		{ quest = 43057, side = 2, [627] = {66.80, 30.00} },
		{ quest = 12409, side = 3, extra = 3, [104] = {61.00, 28.20} },
		{ quest = 12404, side = 3, extra = 3, [111] = {28.10, 49.00} },
		{ quest = 54709, side = 2, [1163] = {50.71, 82.30} },
		{ quest = 54710, side = 1, [1161] = {73.66, 12.59} },
		{ quest = 75684, side = 3, [2023] = {46.22, 40.60} },
		{ quest = 75693, side = 3, [2023] = {66.25, 24.53} },
		{ quest = 75692, side = 3, [2023] = {72.14, 80.39} },
		{ quest = 75685, side = 3, [2023] = {62.94, 40.57} },
		{ quest = 75687, side = 3, [2023] = {57.14, 76.72} },
		{ quest = 75688, side = 3, [2023] = {81.29, 59.20} },
		{ quest = 75689, side = 3, [2023] = {85.84, 35.36} },
		{ quest = 75686, side = 3, [2023] = {28.64, 60.57} },
		{ quest = 75691, side = 3, [2023] = {41.91, 60.43} },
		{ quest = 75690, side = 3, [2023] = {85.04, 26.03} },
		{ quest = 75698, side = 3, [2025] = {50.08, 42.73} },
		{ quest = 75696, side = 3, [2025] = {35.08, 79.21} },
		{ quest = 75697, side = 3, [2025] = {52.40, 69.82} },
		{ quest = 75695, side = 3, [2025] = {59.85, 82.69} },
		{ quest = 75700, side = 3, [2112] = {72.35, 46.66} },
		{ quest = 75699, side = 3, [2112] = {47.13, 45.42} },
		{ quest = 75701, side = 3, [2112] = {22.36, 30.84} },
		{ quest = 75667, side = 3, [2024] = {47.03, 40.26} },
		{ quest = 75668, side = 3, [2024] = {62.78, 57.73} },
		{ quest = 75669, side = 3, [2024] = {12.38, 49.34} },
		{ quest = 75670, side = 3, [2024] = {65.50, 16.25} },
		{ quest = 75671, side = 3, [2024] = {18.81, 24.55} },
		{ quest = 75702, side = 3, [2151] = {33.84, 58.80} },
		{ quest = 75672, side = 3, [2022] = {24.46, 82.09} },
		{ quest = 75673, side = 3, [2022] = {47.67, 83.31} },
		{ quest = 75675, side = 3, [2022] = {65.22, 57.93} },
		{ quest = 77698, side = 3, [2022] = {43.11, 66.66} },
		{ quest = 75676, side = 3, [2022] = {25.76, 55.18} },
		{ quest = 75674, side = 3, [2022] = {58.03, 67.31} },
		{ quest = 75677, side = 3, [2022] = {76.07, 54.75} },
		{ quest = 75678, side = 3, [2022] = {53.91, 39.05} },
		{ quest = 75679, side = 3, [2022] = {46.43, 27.41} },
		{ quest = 75681, side = 1, [2022] = {81.31, 31.96} },
		{ quest = 75682, side = 2, [2022] = {80.42, 27.89} },
		{ quest = 75683, side = 3, [2022] = {76.21, 35.41} },
		{ quest = 75704, side = 3, [2133] = {56.37, 56.36} },
		{ quest = 75703, side = 3, [2133] = {52.11, 26.47} },
		{ quest = 84579, side = 3, [2255] = {58.96, 18.62} },
		{ quest = 84580, side = 3, [2255] = {77.95, 62.78} },
		{ quest = 84582, side = 3, [2255] = {56.86, 38.97} },
		{ quest = 84581, side = 3, [2255] = {44.85, 66.27} },
		{ quest = 84576, side = 3, [2213] = {62.05, 41.37} },
		{ quest = 84578, side = 3, [2213] = {49.73, 22.24} },
		{ quest = 84577, side = 3, [2216] = {57.43, 38.49} },
		{ quest = 84572, side = 3, [2215] = {69.07, 45.71} },
		{ quest = 84574, side = 3, [2215] = {40.58, 68.00} },
		{ quest = 84573, side = 3, [2215] = {49.13, 39.53} },
		{ quest = 84575, side = 3, [2215] = {42.76, 55.71} },
		{ quest = 84564, side = 3, [2339] = {45.01, 47.31} },
		{ quest = 84566, side = 3, [2248] = {41.99, 74.37} },
		{ quest = 84567, side = 3, [2248] = {58.17, 27.12} },
		{ quest = 84568, side = 3, [2214] = {59.46, 64.08} },
		{ quest = 84569, side = 3, [2214] = {47.89, 32.09} },
		{ quest = 84570, side = 3, [2214] = {63.41, 78.98} },
		{ quest = 84571, side = 3, [2214] = {61.87, 46.27} },
	},
	patterns = {
		"^%s*[Cc][Aa][Nn][Dd][Yy]%s+[Bb][Uu][Cc][Kk][Ee][Tt]%s*$",
		"^%s*[Ee][Ii][Mm][Ee][Rr]%s+[Mm][Ii][Tt]%s+[Ss][Üü][ßß][Ii][Gg][Kk][Ee][Ii][Tt][Ee][Nn]%s*$",
		"^%s*[Cc][Uu][Bb][Oo]%s+[Dd][Ee]%s+[Cc][Aa][Rr][Aa][Mm][Ee][Ll][Oo][Ss]%s*$",
		"^%s*[Uu][Nn]%s+[Ss][Ee][Aa][Uu]%s+[Dd][Ee]%s+[Bb][Oo][Nn][Bb][Oo][Nn][Ss]%s*$",
		"^%s*[Ss][Ee][Aa][Uu]%s+[Dd][Ee]%s+[Bb][Oo][Nn][Bb][Oo][Nn][Ss]%s*$",
		"^%s*[Ss][Ee][Cc][Cc][Hh][Ii][Oo]%s+[Dd][Ee][Ll][Ll][Ee]%s+[Cc][Aa][Rr][Aa][Mm][Ee][Ll][Ll][Ee]%s*$",
		"^%s*[Bb][Aa][Ll][Dd][Ee]%s+[Dd][Ee]%s+[Dd][Oo][Cc][Ee][Ss]%s*$",
		"^%s*[Кк][Уу][Лл][Ее][Кк]%s+[Кк][Оо][Нн][Фф][Ее][Тт]%s*$",
		"^%s*사탕%s+바구니%s*$",
		"^%s*糖罐%s*$",
		"^%s*%[%s*[Cc][Aa][Nn][Dd][Yy]%s+[Bb][Uu][Cc][Kk][Ee][Tt]%s*%]%s*$",
	}
}
