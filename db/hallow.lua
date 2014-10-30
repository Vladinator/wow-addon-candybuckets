local _G = _G
local pairs = pairs
local select = select
local string_format = string.format
local table_insert = table.insert
local table_wipe = table.wipe
local GetFactionInfoByID = GetFactionInfoByID
local GetMapNameByID = GetMapNameByID
local WorldMapTooltip = WorldMapTooltip

local _, ns = ...

local texture = "Calendar_HallowsEnd"
local iconTitle = "Candy Bucket"
local iconTexture = "Interface\\Icons\\Achievement_Halloween_Candy_01"
local iconTexturePhase = "Interface\\Icons\\Spell_Shadow_Teleport"
local iconTextureRequires = "Interface\\Icons\\Spell_Shadow_Teleport"
local nodes = {}

local db = {
	["Information"] = {
		{quest = 12349, side = 1, area = 141, level = 0, x = 56.18, y = 50.02, phase = 1}, -- Westfall
		{quest = 12349, side = 1, area = 851, level = 0, x = 56.18, y = 50.02, phase = 1}, -- Westfall
		{quest = 28960, side = 1, area = 19, level = 0, x = 48.16, y = 7.28, phase = 1}, -- Blasted Lands, Nethergarde Keep
		{quest = 28961, side = 1, area = 19, level = 0, x = 48.16, y = 7.28, phase = 1}, -- Blasted Lands, Surwich
		{quest = 28959, side = 2, area = 19, level = 0, x = 48.16, y = 7.28, phase = 1}, -- Blasted Lands, Dreadmaul Hold
		--{quest = 12404, side = 1, area = 481, level = 0, x = 59.8, y = 41.6, requires = {932, 934}}, -- The Aldor (quest 10551)
		--{quest = 12409, side = 1, area = 481, level = 0, x = 59.8, y = 41.6, requires = {932, 934}}, -- The Scryers (quest 10552)
	},
	["Phased"] = {
		[12340] = {side = 1, area = 39, level = 0, x = 56.70, y = 47.22, text = "Phased"},
		[12349] = {side = 1, area = 851, level = 0, x = 66.60, y = 45.30, text = "Phased"},
		[12364] = {side = 2, area = 480, level = 0, x = 38.20, y = 84.40},
		[12369] = {side = 2, area = 480, level = 0, x = 79.60, y = 57.90},
		[12370] = {side = 2, area = 480, level = 0, x = 67.70, y = 73.50},
		[12383] = {side = 2, area = 851, level = 0, x = 36.80, y = 32.50},
		[12398] = {side = 3, area = 851, level = 0, x = 41.90, y = 74.10},
		[12404] = {side = 3, area = 481, level = 0, x = 56.20, y = 81.80, faction = 934, text = "The Scryers"},
		[12409] = {side = 3, area = 473, level = 0, x = 61.00, y = 28.20, faction = 932, text = "The Aldor"},
		[13463] = {side = 3, area = 924, level = 1, x = 48.30, y = 40.80},
		[13472] = {side = 3, area = 924, level = 2, x = 37.60, y = 59.80},
		[28973] = {side = 2, area = 770, level = 0, x = 53.50, y = 42.90},
		[28974] = {side = 2, area = 770, level = 0, x = 45.10, y = 76.70},
		[28975] = {side = 2, area = 770, level = 0, x = 75.30, y = 54.80},
		[28976] = {side = 2, area = 770, level = 0, x = 75.40, y = 16.50},
		[28977] = {side = 1, area = 770, level = 0, x = 60.40, y = 58.20},
		[28978] = {side = 1, area = 770, level = 0, x = 49.60, y = 30.50},
		[28979] = {side = 1, area = 770, level = 0, x = 43.60, y = 57.30},
		[28980] = {side = 1, area = 770, level = 0, x = 79.50, y = 78.50},
		[28999] = {side = 3, area = 683, level = 0, x = 63.00, y = 24.10},
		[29000] = {side = 3, area = 683, level = 0, x = 18.70, y = 37.50},
		[29001] = {side = 3, area = 683, level = 0, x = 42.70, y = 45.60},
		[29016] = {side = 3, area = 748, level = 0, x = 26.60, y = 7.30},
		[29017] = {side = 3, area = 748, level = 0, x = 54.70, y = 33.00},
		[32020] = {side = 2, area = 910, level = 0, x = 28.30, y = 50.70},
		[32022] = {side = 2, area = 811, level = 0, x = 61.98, y = 16.26},
		[32034] = {side = 3, area = 910, level = 0, x = 51.50, y = 77.30},
		[32036] = {side = 3, area = 910, level = 0, x = 75.90, y = 7.00},
		[32047] = {side = 2, area = 910, level = 0, x = 61.00, y = 25.10},
		[32052] = {side = 1, area = 905, level = 3, x = 37.30, y = 67.10},
	},
	["Deepholm"] = {
		[29019] = {side = 2, area = 640, level = 0, x = 51.20, y = 50.00},
		[29020] = {side = 1, area = 640, level = 0, x = 47.50, y = 51.70},
	},
	["Eastern Kingdoms"] = {
		[12286] = {side = 1, area = 30, level = 0, x = 43.70, y = 66.00},
		[12332] = {side = 1, area = 27, level = 0, x = 54.50, y = 50.70},
		[12335] = {side = 1, area = 341, level = 0, x = 18.70, y = 51.50},
		[12336] = {side = 1, area = 301, level = 0, x = 60.50, y = 75.20},
		[12339] = {side = 1, area = 35, level = 0, x = 35.50, y = 48.50},
		[12340] = {side = 1, area = 39, level = 0, x = 52.90, y = 53.60, text = "Phased"},
		[12342] = {side = 1, area = 36, level = 0, x = 27.00, y = 45.00},
		[12343] = {side = 1, area = 40, level = 0, x = 10.80, y = 60.90},
		[12344] = {side = 1, area = 34, level = 0, x = 73.90, y = 44.30},
		[12351] = {side = 1, area = 26, level = 0, x = 14.20, y = 44.70},
		[12363] = {side = 2, area = 20, level = 0, x = 60.90, y = 51.50},
		[12368] = {side = 2, area = 382, level = 0, x = 68.00, y = 37.40},
		[12371] = {side = 2, area = 21, level = 0, x = 46.50, y = 42.80},
		[12376] = {side = 2, area = 24, level = 0, x = 57.90, y = 47.30},
		[12380] = {side = 2, area = 16, level = 0, x = 69.00, y = 33.50},
		[12382] = {side = 2, area = 37, level = 0, x = 37.30, y = 51.70},
		[12384] = {side = 2, area = 38, level = 0, x = 46.90, y = 56.70},
		[12387] = {side = 2, area = 26, level = 0, x = 78.20, y = 81.50},
		[12397] = {side = 3, area = 673, level = 0, x = 40.90, y = 73.80},
		[12402] = {side = 3, area = 23, level = 0, x = 75.60, y = 52.40},
		[28954] = {side = 1, area = 16, level = 0, x = 40.10, y = 49.10},
		[28955] = {side = 3, area = 17, level = 0, x = 65.90, y = 35.80},
		[28956] = {side = 1, area = 17, level = 0, x = 21.00, y = 56.50},
		[28957] = {side = 2, area = 17, level = 0, x = 18.50, y = 42.80},
		[28959] = {side = 2, area = 19, level = 0, x = 40.50, y = 11.50, text = "Phased"},
		[28960] = {side = 1, area = 19, level = 0, x = 60.70, y = 14.20, text = "Phased"},
		[28961] = {side = 1, area = 19, level = 0, x = 44.50, y = 87.70, text = "Phased"},
		[28962] = {side = 2, area = 24, level = 0, x = 60.30, y = 63.80},
		[28963] = {side = 1, area = 35, level = 0, x = 83.10, y = 63.40},
		[28964] = {side = 1, area = 37, level = 0, x = 53.10, y = 66.90},
		[28965] = {side = 3, area = 28, level = 0, x = 39.50, y = 66.10},
		[28966] = {side = 2, area = 21, level = 0, x = 44.40, y = 20.50},
		[28967] = {side = 3, area = 38, level = 0, x = 71.70, y = 14.00},
		[28968] = {side = 1, area = 38, level = 0, x = 29.00, y = 32.60},
		[28969] = {side = 2, area = 673, level = 0, x = 35.10, y = 27.20},
		[28970] = {side = 1, area = 26, level = 0, x = 66.20, y = 44.50},
		[28971] = {side = 2, area = 26, level = 0, x = 31.90, y = 57.90},
		[28972] = {side = 2, area = 20, level = 0, x = 83.00, y = 72.00},
		[28973] = {side = 2, area = 700, level = 0, x = 53.50, y = 42.90},
		[28974] = {side = 2, area = 700, level = 0, x = 45.10, y = 76.70},
		[28975] = {side = 2, area = 700, level = 0, x = 75.30, y = 54.80},
		[28976] = {side = 2, area = 700, level = 0, x = 75.40, y = 16.50},
		[28977] = {side = 1, area = 700, level = 0, x = 60.40, y = 58.20},
		[28978] = {side = 1, area = 700, level = 0, x = 49.60, y = 30.50},
		[28979] = {side = 1, area = 700, level = 0, x = 43.60, y = 57.30},
		[28980] = {side = 1, area = 700, level = 0, x = 79.50, y = 78.50},
		[28981] = {side = 3, area = 610, level = 0, x = 63.50, y = 60.30},
		[28982] = {side = 3, area = 615, level = 0, x = 49.20, y = 41.90},
		[28983] = {side = 1, area = 615, level = 0, x = 49.70, y = 57.40},
		[28984] = {side = 2, area = 615, level = 0, x = 51.50, y = 62.50},
		[28985] = {side = 1, area = 614, level = 0, x = 54.70, y = 72.20},
		[28986] = {side = 2, area = 614, level = 0, x = 51.40, y = 60.40},
		[28987] = {side = 2, area = 22, level = 0, x = 48.20, y = 63.70},
		[28988] = {side = 1, area = 22, level = 0, x = 43.50, y = 84.50},
		[28990] = {side = 1, area = 40, level = 0, x = 26.10, y = 25.90},
		[28991] = {side = 1, area = 40, level = 0, x = 58.10, y = 39.20},
	},
	["Kalimdor"] = {
		[12331] = {side = 1, area = 41, level = 0, x = 55.50, y = 52.30},
		[12334] = {side = 1, area = 381, level = 0, x = 62.50, y = 33.10},
		[12345] = {side = 1, area = 43, level = 0, x = 37.00, y = 49.30},
		[12347] = {side = 1, area = 81, level = 0, x = 40.60, y = 17.70},
		[12348] = {side = 1, area = 101, level = 0, x = 66.30, y = 6.70},
		[12349] = {side = 1, area = 141, level = 0, x = 66.60, y = 45.30, text = "Phased"},
		[12350] = {side = 1, area = 121, level = 0, x = 46.30, y = 45.20},
		[12361] = {side = 2, area = 4, level = 0, x = 51.60, y = 41.70},
		[12362] = {side = 2, area = 9, level = 0, x = 46.80, y = 60.50},
		[12366] = {side = 2, area = 321, level = 1, x = 53.80, y = 78.80},
		[12367] = {side = 2, area = 362, level = 0, x = 45.70, y = 64.50},
		[12374] = {side = 2, area = 11, level = 0, x = 49.50, y = 58.00},
		[12377] = {side = 2, area = 43, level = 0, x = 73.90, y = 60.70},
		[12378] = {side = 2, area = 81, level = 0, x = 50.50, y = 63.80},
		[12381] = {side = 2, area = 101, level = 0, x = 24.10, y = 68.30},
		[12383] = {side = 2, area = 141, level = 0, x = 36.80, y = 32.50},
		[12386] = {side = 2, area = 121, level = 0, x = 74.80, y = 45.10},
		[12396] = {side = 3, area = 11, level = 0, x = 67.30, y = 74.70},
		[12398] = {side = 3, area = 141, level = 0, x = 41.90, y = 74.10},
		[12399] = {side = 3, area = 161, level = 0, x = 52.60, y = 27.10},
		[12400] = {side = 3, area = 281, level = 0, x = 59.80, y = 51.20},
		[12401] = {side = 3, area = 261, level = 0, x = 55.50, y = 36.70},
		[28951] = {side = 1, area = 42, level = 0, x = 50.80, y = 18.80},
		[28952] = {side = 1, area = 121, level = 0, x = 51.10, y = 17.80},
		[28953] = {side = 2, area = 43, level = 0, x = 50.20, y = 67.20},
		[28958] = {side = 2, area = 43, level = 0, x = 38.60, y = 42.50},
		[28989] = {side = 2, area = 43, level = 0, x = 13.00, y = 34.10},
		[28992] = {side = 2, area = 181, level = 0, x = 57.10, y = 50.20},
		[28993] = {side = 3, area = 101, level = 0, x = 56.80, y = 50.00},
		[28994] = {side = 3, area = 182, level = 0, x = 44.60, y = 28.90},
		[28995] = {side = 1, area = 182, level = 0, x = 61.80, y = 26.70},
		[28996] = {side = 2, area = 121, level = 0, x = 41.50, y = 15.60},
		[28998] = {side = 2, area = 121, level = 0, x = 51.90, y = 47.70},
		[28999] = {side = 3, area = 606, level = 0, x = 63.00, y = 24.10},
		[29000] = {side = 3, area = 606, level = 0, x = 18.70, y = 37.50},
		[29001] = {side = 3, area = 606, level = 0, x = 42.70, y = 45.60},
		[29002] = {side = 2, area = 11, level = 0, x = 56.30, y = 40.10},
		[29003] = {side = 2, area = 11, level = 0, x = 62.50, y = 16.60},
		[29004] = {side = 2, area = 607, level = 0, x = 39.30, y = 20.10},
		[29005] = {side = 2, area = 607, level = 0, x = 40.70, y = 69.30},
		[29006] = {side = 1, area = 607, level = 0, x = 39.00, y = 11.00},
		[29007] = {side = 1, area = 607, level = 0, x = 65.60, y = 46.60},
		[29008] = {side = 1, area = 607, level = 0, x = 49.10, y = 68.50},
		[29009] = {side = 2, area = 81, level = 0, x = 66.50, y = 64.20},
		[29010] = {side = 1, area = 81, level = 0, x = 70.90, y = 79.20},
		[29011] = {side = 1, area = 81, level = 0, x = 59.10, y = 56.30},
		[29012] = {side = 1, area = 81, level = 0, x = 39.50, y = 32.80},
		[29013] = {side = 1, area = 81, level = 0, x = 31.50, y = 60.70},
		[29014] = {side = 3, area = 161, level = 0, x = 55.70, y = 60.90},
		[29016] = {side = 3, area = 720, level = 0, x = 26.60, y = 7.30},
		[29017] = {side = 3, area = 720, level = 0, x = 54.70, y = 33.00},
		[29018] = {side = 3, area = 201, level = 0, x = 55.20, y = 62.10},
	},
	["Outland"] = {
		[12333] = {side = 1, area = 464, level = 0, x = 48.50, y = 49.20},
		[12337] = {side = 1, area = 471, level = 0, x = 59.50, y = 19.20},
		[12341] = {side = 1, area = 476, level = 0, x = 55.70, y = 59.90},
		[12352] = {side = 1, area = 465, level = 0, x = 54.30, y = 63.60},
		[12353] = {side = 1, area = 465, level = 0, x = 23.50, y = 36.40},
		[12354] = {side = 1, area = 467, level = 0, x = 67.20, y = 49.00},
		[12355] = {side = 1, area = 467, level = 0, x = 41.90, y = 26.20},
		[12356] = {side = 1, area = 478, level = 0, x = 56.60, y = 53.20},
		[12357] = {side = 1, area = 477, level = 0, x = 54.20, y = 75.80},
		[12358] = {side = 1, area = 475, level = 0, x = 35.80, y = 63.80},
		[12359] = {side = 1, area = 475, level = 0, x = 61.00, y = 68.10},
		[12360] = {side = 1, area = 473, level = 0, x = 37.10, y = 58.20},
		[12364] = {side = 2, area = 462, level = 0, x = 48.20, y = 47.80},
		[12365] = {side = 2, area = 462, level = 0, x = 43.70, y = 71.10},
		[12373] = {side = 2, area = 463, level = 0, x = 48.60, y = 32.00},
		[12388] = {side = 2, area = 465, level = 0, x = 56.80, y = 37.50},
		[12389] = {side = 2, area = 465, level = 0, x = 26.90, y = 59.60},
		[12390] = {side = 2, area = 467, level = 0, x = 30.70, y = 50.90},
		[12391] = {side = 2, area = 478, level = 0, x = 48.80, y = 45.20},
		[12392] = {side = 2, area = 477, level = 0, x = 56.70, y = 34.60},
		[12393] = {side = 2, area = 475, level = 0, x = 53.50, y = 55.50},
		[12394] = {side = 2, area = 475, level = 0, x = 76.20, y = 60.40},
		[12395] = {side = 2, area = 473, level = 0, x = 30.30, y = 27.80},
		[12403] = {side = 3, area = 467, level = 0, x = 78.50, y = 62.90},
		[12404] = {side = 3, area = 481, level = 0, x = 28.10, y = 49.00, faction = 932, text = "The Aldor"},
		[12406] = {side = 3, area = 475, level = 0, x = 62.90, y = 38.30},
		[12407] = {side = 3, area = 479, level = 0, x = 32.10, y = 64.50},
		[12408] = {side = 3, area = 479, level = 0, x = 43.40, y = 36.10},
		[12409] = {side = 3, area = 473, level = 0, x = 56.30, y = 59.80, faction = 934, text = "The Scryers"},
	},
	["Northrend"] = {
		[12940] = {side = 3, area = 496, level = 0, x = 59.30, y = 57.20},
		[12941] = {side = 3, area = 496, level = 0, x = 40.80, y = 66.00},
		[12944] = {side = 1, area = 490, level = 0, x = 32.00, y = 60.20},
		[12945] = {side = 1, area = 490, level = 0, x = 59.60, y = 26.50},
		[12946] = {side = 2, area = 490, level = 0, x = 20.90, y = 64.70},
		[12947] = {side = 2, area = 490, level = 0, x = 65.40, y = 47.00},
		[12950] = {side = 3, area = 493, level = 0, x = 26.70, y = 59.20},
		[13433] = {side = 1, area = 491, level = 0, x = 58.40, y = 62.80},
		[13434] = {side = 1, area = 491, level = 0, x = 30.80, y = 41.50},
		[13435] = {side = 1, area = 491, level = 0, x = 60.50, y = 15.90},
		[13436] = {side = 1, area = 486, level = 0, x = 58.50, y = 67.90},
		[13437] = {side = 1, area = 486, level = 0, x = 57.10, y = 18.80},
		[13438] = {side = 1, area = 488, level = 0, x = 29.00, y = 56.20},
		[13439] = {side = 1, area = 488, level = 0, x = 77.50, y = 51.30},
		[13448] = {side = 1, area = 495, level = 0, x = 28.70, y = 74.30},
		[13452] = {side = 3, area = 491, level = 0, x = 25.50, y = 59.80},
		[13456] = {side = 3, area = 488, level = 0, x = 60.10, y = 53.50},
		[13459] = {side = 3, area = 488, level = 0, x = 48.20, y = 74.70},
		[13460] = {side = 3, area = 486, level = 0, x = 78.50, y = 49.20},
		[13461] = {side = 3, area = 495, level = 0, x = 41.10, y = 85.90},
		[13462] = {side = 3, area = 495, level = 0, x = 30.90, y = 37.20},
		[13463] = {side = 3, area = 504, level = 1, x = 48.50, y = 40.60},
		[13464] = {side = 2, area = 491, level = 0, x = 49.50, y = 10.80},
		[13465] = {side = 2, area = 491, level = 0, x = 52.10, y = 66.20},
		[13466] = {side = 2, area = 491, level = 0, x = 79.20, y = 30.60},
		[13467] = {side = 2, area = 486, level = 0, x = 76.70, y = 37.50},
		[13468] = {side = 2, area = 486, level = 0, x = 41.80, y = 54.50},
		[13469] = {side = 2, area = 488, level = 0, x = 37.90, y = 46.50},
		[13470] = {side = 2, area = 488, level = 0, x = 76.80, y = 63.20},
		[13471] = {side = 2, area = 495, level = 0, x = 67.60, y = 50.60},
		[13472] = {side = 3, area = 504, level = 2, x = 38.10, y = 60.50},
		[13473] = {side = 1, area = 504, level = 1, x = 42.60, y = 63.40},
		[13474] = {side = 2, area = 504, level = 0, x = 49.10, y = 39.70},
		[13501] = {side = 2, area = 486, level = 0, x = 49.70, y = 10.00},
		[13548] = {side = 2, area = 495, level = 0, x = 37.10, y = 49.60},
	},
	["Pandaria"] = {
		[32020] = {side = 2, area = 857, level = 0, x = 28.25, y = 50.73},
		[32021] = {side = 3, area = 806, level = 0, x = 41.70, y = 23.10},
		[32022] = {side = 2, area = 903, level = 2, x = 59.80, y = 75.30},
		[32023] = {side = 3, area = 858, level = 0, x = 55.20, y = 71.20},
		[32024] = {side = 3, area = 858, level = 0, x = 55.90, y = 32.30},
		[32026] = {side = 3, area = 873, level = 0, x = 55.10, y = 72.20},
		[32027] = {side = 3, area = 806, level = 0, x = 45.80, y = 43.60},
		[32028] = {side = 2, area = 806, level = 0, x = 28.00, y = 47.40},
		[32029] = {side = 3, area = 806, level = 0, x = 48.10, y = 34.60},
		[32031] = {side = 3, area = 806, level = 0, x = 55.70, y = 24.40},
		[32032] = {side = 3, area = 806, level = 0, x = 54.60, y = 63.30},
		[32033] = {side = 1, area = 806, level = 0, x = 59.60, y = 83.20},
		[32034] = {side = 3, area = 857, level = 0, x = 51.40, y = 77.30},
		[32036] = {side = 3, area = 857, level = 0, x = 75.90, y = 6.90},
		[32037] = {side = 3, area = 809, level = 0, x = 57.40, y = 59.90},
		[32039] = {side = 3, area = 809, level = 0, x = 72.70, y = 92.30},
		[32040] = {side = 2, area = 809, level = 0, x = 62.70, y = 80.50},
		[32041] = {side = 3, area = 809, level = 0, x = 64.20, y = 61.30},
		[32042] = {side = 1, area = 809, level = 0, x = 54.10, y = 82.80},
		[32043] = {side = 3, area = 810, level = 0, x = 71.10, y = 57.80},
		[32044] = {side = 3, area = 811, level = 0, x = 35.10, y = 77.80},
		[32046] = {side = 3, area = 807, level = 0, x = 19.90, y = 55.80},
		[32047] = {side = 2, area = 857, level = 0, x = 61.03, y = 25.14},
		[32048] = {side = 3, area = 807, level = 0, x = 83.60, y = 20.10},
		[32049] = {side = 1, area = 806, level = 0, x = 44.80, y = 84.40},
		[32050] = {side = 2, area = 806, level = 0, x = 28.45, y = 13.27},
		[32051] = {side = 3, area = 809, level = 0, x = 62.50, y = 28.90},
		[32052] = {side = 1, area = 811, level = 0, x = 87.00, y = 68.90},
	},
}

ns.modules[texture] = {
	loaded = false,
	texture = iconTexture,
	title = iconTitle,
	nodes = nodes,

	load = function(self)
		local faction = ns:GetPlayerFaction()

		if not faction then
			return false
		end

		for _, entries in pairs(db) do
			for quest, data in pairs(entries) do
				quest = data.quest or quest
				if (data.side == 3 or data.side == faction) and not ns:IsQuestCompleted(quest) then
					table_insert(nodes, {
						quest = quest,
						area = data.area,
						level = data.level,
						x = data.x/100,
						y = data.y/100,
						title = data.title,
						text = data.text,
						phase = data.phase,
						requires = data.requires,
						faction = data.faction,
					})
				end
			end
		end

		table_wipe(db)
		self.loaded = true
		return true
	end,

	OnShow = function(self)
		if self.node.phase then
			self.icon:SetTexture(iconTexturePhase)
		elseif self.node.requires then
			self.icon:SetTexture(iconTextureRequires)
		end
		if self.node.faction and select(3, GetFactionInfoByID(self.node.faction)) < 4 then -- hide bucket if it's Aldor/Scryers and you are below neutral
			self:Hide()
		-- elseif self.node.requires and (select(3, GetFactionInfoByID(self.node.requires[1])) > 4 or select(3, GetFactionInfoByID(self.node.requires[2])) > 4) then
		-- 	self:Hide()
		end
	end,

	OnEnter = function(self)
		WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if self.node.title then
			WorldMapTooltip:SetText(self.node.title)
		else
			if self.node.phase then
				WorldMapTooltip:SetText(iconTitle .. ": Phase")
			-- elseif self.node.requires then
			-- 	WorldMapTooltip:SetText(iconTitle .. ": Aldor or Scryers")
			else
				WorldMapTooltip:SetText(iconTitle)
			end
		end
		WorldMapTooltip:AddLine(GetMapNameByID(self.node.area), 1, .82, 0, false)
		if self.node.phase then
			WorldMapTooltip:AddLine("Speak to Zidormi in order to interact\nwith the Candy Buckets in this zone.", 1, 1, 1, false)
		-- elseif self.node.requires then
		-- 	WorldMapTooltip:AddLine("The Aldor and Scryers require you to pick a side\nbefore they allow you to take their candy.\n\nSpeak to |cffFFFF00Haggard War Veteran|r and complete |cffFFFF00A'dal|r,\nthen speak to |cffFFFF00Archmage Khadgar|r and complete |cffFFFF00City of Light|r.\nYou can now decide which side to support.\n", 1, 1, 1, false)
		end
		if self.node.text then
			WorldMapTooltip:AddLine(self.node.text, 1, 1, 1, true)
		end
		WorldMapTooltip:AddLine(string_format("%.1f, %.1f", self.node.x * 100, self.node.y * 100), 1, 1, 1, false)
		if not self.node.phase then -- and not self.node.requires
			WorldMapTooltip:AddLine(string_format("Quest %d", self.node.quest), .8, .8, .8, false)
		end
		if ns.WaypointAddons:GetAddon() then
			WorldMapTooltip:AddLine("<Click for waypoint.>", .8, .8, .8, false)
		end
		WorldMapTooltip:Show()
	end,

	OnLeave = function(self)
		WorldMapTooltip:Hide()
	end,
}
