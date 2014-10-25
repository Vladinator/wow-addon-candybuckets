local _G = _G
local pairs = pairs
local string_format = string.format
local table_insert = table.insert
local table_wipe = table.wipe
local GetMapNameByID = GetMapNameByID
local WorldMapTooltip = WorldMapTooltip

local _, ns = ...

local texture = "Calendar_Midsummer"
local iconTitle = "Bonfire"
local iconTexture = "Interface\\Icons\\Spell_Fire_MasterOfElements"
local iconTextureHonor = "Interface\\Icons\\INV_SummerFest_FireSpirit"
local nodes = {}

local db = {
  ["Deepholm"] = {
    [29036] = {area = 640, side = 3, level = 0, x = 49.40, y = 51.40, honor = 1},
  },
  ["Eastern Kingdoms"] = {
    [11580] = {area = 21, side = 1, level = 0, x = 49.60, y = 38.70},
    [11581] = {area = 39, side = 2, level = 0, x = 45.20, y = 62.30},
    [11583] = {area = 39, side = 1, level = 0, x = 44.60, y = 62.00, honor = 1},
    [11584] = {area = 21, side = 2, level = 0, x = 49.60, y = 38.20, honor = 1},
    [11732] = {area = 16, side = 2, level = 0, x = 44.20, y = 45.80},
    [11737] = {area = 19, side = 2, level = 0, x = 55.20, y = 15.30},
    [11739] = {area = 29, side = 2, level = 0, x = 68.60, y = 59.90},
    [11742] = {area = 27, side = 2, level = 0, x = 53.80, y = 44.70},
    [11743] = {area = 34, side = 2, level = 0, x = 73.20, y = 54.90},
    [11745] = {area = 30, side = 2, level = 0, x = 43.20, y = 63.00},
    [11749] = {area = 35, side = 2, level = 0, x = 32.30, y = 40.40},
    [11751] = {area = 36, side = 2, level = 0, x = 24.70, y = 53.90},
    [11755] = {area = 26, side = 2, level = 0, x = 14.50, y = 50.00},
    [11756] = {area = 22, side = 2, level = 0, x = 43.60, y = 82.50},
    [11757] = {area = 40, side = 2, level = 0, x = 13.30, y = 47.30},
    [11761] = {area = 673, side = 2, level = 0, x = 51.70, y = 67.30},
    [11764] = {area = 16, side = 1, level = 0, x = 69.00, y = 42.80},
    [11766] = {area = 17, side = 1, level = 0, x = 24.20, y = 37.30},
    [11768] = {area = 29, side = 1, level = 0, x = 51.50, y = 29.30},
    [11776] = {area = 24, side = 1, level = 0, x = 54.50, y = 50.00},
    [11781] = {area = 38, side = 1, level = 0, x = 76.70, y = 14.40},
    [11784] = {area = 26, side = 1, level = 0, x = 76.60, y = 74.40},
    [11786] = {area = 20, side = 1, level = 0, x = 56.90, y = 51.80},
    [11801] = {area = 673, side = 1, level = 0, x = 50.60, y = 70.70},
    [11804] = {area = 16, side = 1, level = 0, x = 44.20, y = 45.80, honor = 1},
    [11808] = {area = 19, side = 1, level = 0, x = 55.60, y = 15.00, honor = 1},
    [11810] = {area = 29, side = 1, level = 0, x = 68.20, y = 60.60, honor = 1},
    [11813] = {area = 27, side = 1, level = 0, x = 53.80, y = 45.20, honor = 1},
    [11814] = {area = 34, side = 1, level = 0, x = 73.60, y = 54.60, honor = 1},
    [11816] = {area = 30, side = 1, level = 0, x = 43.40, y = 62.60, honor = 1},
    [11820] = {area = 35, side = 1, level = 0, x = 32.40, y = 41.00, honor = 1},
    [11822] = {area = 36, side = 1, level = 0, x = 25.00, y = 53.40, honor = 1},
    [11826] = {area = 26, side = 1, level = 0, x = 14.40, y = 50.20, honor = 1},
    [11827] = {area = 22, side = 1, level = 0, x = 43.40, y = 82.20, honor = 1},
    [11828] = {area = 40, side = 1, level = 0, x = 13.40, y = 47.00, honor = 1},
    [11832] = {area = 673, side = 1, level = 0, x = 51.80, y = 67.60, honor = 1},
    [11837] = {area = 673, side = 2, level = 0, x = 50.40, y = 70.20, honor = 1},
    [11840] = {area = 16, side = 2, level = 0, x = 69.40, y = 42.60, honor = 1},
    [11842] = {area = 17, side = 2, level = 0, x = 23.00, y = 37.40, honor = 1},
    [11844] = {area = 29, side = 2, level = 0, x = 51.00, y = 29.40, honor = 1},
    [11853] = {area = 24, side = 2, level = 0, x = 54.60, y = 50.20, honor = 1},
    [11857] = {area = 38, side = 2, level = 0, x = 76.40, y = 13.80, honor = 1},
    [11860] = {area = 26, side = 2, level = 0, x = 76.60, y = 75.00, honor = 1},
    [11862] = {area = 20, side = 2, level = 0, x = 57.20, y = 51.80, honor = 1},
    [28910] = {area = 37, side = 2, level = 0, x = 51.60, y = 63.30},
    [28911] = {area = 37, side = 1, level = 0, x = 40.80, y = 51.80},
    [28912] = {area = 17, side = 2, level = 0, x = 18.50, y = 56.10},
    [28916] = {area = 38, side = 2, level = 0, x = 70.10, y = 14.80},
    [28917] = {area = 19, side = 1, level = 0, x = 46.40, y = 14.40},
    [28918] = {area = 22, side = 1, level = 0, x = 29.10, y = 56.40},
    [28922] = {area = 37, side = 1, level = 0, x = 52.00, y = 63.60, honor = 1},
    [28924] = {area = 37, side = 2, level = 0, x = 40.40, y = 50.80, honor = 1},
    [28925] = {area = 17, side = 1, level = 0, x = 19.00, y = 56.00, honor = 1},
    [28929] = {area = 38, side = 1, level = 0, x = 70.20, y = 15.60, honor = 1},
    [28930] = {area = 19, side = 2, level = 0, x = 46.20, y = 13.80, honor = 1},
    [28931] = {area = 22, side = 2, level = 0, x = 29.00, y = 57.40, honor = 1},
    [28943] = {area = 700, side = 2, level = 0, x = 47.00, y = 28.20},
    [28944] = {area = 700, side = 1, level = 0, x = 53.30, y = 46.50},
    [28945] = {area = 700, side = 1, level = 0, x = 47.20, y = 29.00, honor = 1},
    [28946] = {area = 700, side = 2, level = 0, x = 53.00, y = 46.20, honor = 1},
    [29031] = {area = 615, side = 3, level = 0, x = 49.40, y = 42.00, honor = 1},
  },
  ["Kalimdor"] = {
    [11734] = {area = 43, side = 2, level = 0, x = 86.70, y = 41.40},
    [11740] = {area = 42, side = 2, level = 0, x = 49.00, y = 22.50},
    [11741] = {area = 101, side = 2, level = 0, x = 65.80, y = 17.00},
    [11744] = {area = 141, side = 2, level = 0, x = 62.10, y = 40.30},
    [11746] = {area = 121, side = 2, level = 0, x = 46.60, y = 43.80},
    [11753] = {area = 41, side = 2, level = 0, x = 54.70, y = 52.70},
    [11760] = {area = 261, side = 2, level = 0, x = 60.50, y = 33.30},
    [11762] = {area = 161, side = 2, level = 0, x = 52.70, y = 30.00},
    [11763] = {area = 281, side = 2, level = 0, x = 61.30, y = 47.10},
    [11765] = {area = 43, side = 1, level = 0, x = 51.60, y = 66.80},
    [11769] = {area = 101, side = 1, level = 0, x = 26.10, y = 77.40},
    [11770] = {area = 4, side = 1, level = 0, x = 52.00, y = 47.00},
    [11771] = {area = 141, side = 1, level = 0, x = 33.20, y = 30.80},
    [11773] = {area = 121, side = 1, level = 0, x = 72.50, y = 47.60},
    [11777] = {area = 9, side = 1, level = 0, x = 52.00, y = 59.30},
    [11780] = {area = 81, side = 1, level = 0, x = 53.00, y = 62.40},
    [11783] = {area = 11, side = 1, level = 0, x = 49.90, y = 54.30},
    [11800] = {area = 261, side = 1, level = 0, x = 50.80, y = 41.80},
    [11802] = {area = 161, side = 1, level = 0, x = 49.80, y = 28.20},
    [11803] = {area = 281, side = 1, level = 0, x = 58.20, y = 47.30},
    [11805] = {area = 43, side = 1, level = 0, x = 86.80, y = 41.80, honor = 1},
    [11811] = {area = 42, side = 1, level = 0, x = 48.60, y = 22.60, honor = 1},
    [11812] = {area = 101, side = 1, level = 0, x = 66.00, y = 17.20, honor = 1},
    [11815] = {area = 141, side = 1, level = 0, x = 61.80, y = 40.40, honor = 1},
    [11817] = {area = 121, side = 1, level = 0, x = 46.80, y = 43.60, honor = 1},
    [11824] = {area = 41, side = 1, level = 0, x = 54.80, y = 52.60, honor = 1},
    [11831] = {area = 261, side = 1, level = 0, x = 60.20, y = 33.60, honor = 1},
    [11833] = {area = 161, side = 1, level = 0, x = 52.60, y = 30.20, honor = 1},
    [11834] = {area = 281, side = 1, level = 0, x = 61.20, y = 47.20, honor = 1},
    [11836] = {area = 261, side = 2, level = 0, x = 50.80, y = 41.20, honor = 1},
    [11838] = {area = 161, side = 2, level = 0, x = 49.80, y = 27.80, honor = 1},
    [11839] = {area = 281, side = 2, level = 0, x = 58.20, y = 47.40, honor = 1},
    [11841] = {area = 43, side = 2, level = 0, x = 51.20, y = 66.00, honor = 1},
    [11845] = {area = 101, side = 2, level = 0, x = 26.00, y = 76.80, honor = 1},
    [11846] = {area = 4, side = 2, level = 0, x = 52.20, y = 47.20, honor = 1},
    [11847] = {area = 141, side = 2, level = 0, x = 33.40, y = 31.00, honor = 1},
    [11849] = {area = 121, side = 2, level = 0, x = 72.40, y = 47.80, honor = 1},
    [11852] = {area = 9, side = 2, level = 0, x = 51.80, y = 59.20, honor = 1},
    [11856] = {area = 81, side = 2, level = 0, x = 52.80, y = 62.40, honor = 1},
    [11859] = {area = 11, side = 2, level = 0, x = 50.00, y = 54.60, honor = 1},
    [28913] = {area = 607, side = 2, level = 0, x = 48.20, y = 72.40},
    [28914] = {area = 607, side = 1, level = 0, x = 40.70, y = 67.20},
    [28915] = {area = 81, side = 2, level = 0, x = 49.60, y = 51.10},
    [28919] = {area = 181, side = 1, level = 0, x = 60.40, y = 53.50},
    [28920] = {area = 201, side = 1, level = 0, x = 56.30, y = 65.80},
    [28921] = {area = 201, side = 2, level = 0, x = 60.00, y = 62.90},
    [28923] = {area = 181, side = 2, level = 0, x = 60.80, y = 53.40, honor = 1},
    [28926] = {area = 607, side = 1, level = 0, x = 48.20, y = 72.20, honor = 1},
    [28927] = {area = 607, side = 2, level = 0, x = 40.80, y = 67.80, honor = 1},
    [28928] = {area = 81, side = 1, level = 0, x = 49.20, y = 51.40, honor = 1},
    [28932] = {area = 201, side = 1, level = 0, x = 59.80, y = 63.20, honor = 1},
    [28933] = {area = 201, side = 2, level = 0, x = 56.40, y = 66.20, honor = 1},
    [28947] = {area = 720, side = 2, level = 0, x = 53.40, y = 32.00},
    [28948] = {area = 720, side = 1, level = 0, x = 53.00, y = 34.50},
    [28949] = {area = 720, side = 2, level = 0, x = 53.20, y = 34.40, honor = 1},
    [28950] = {area = 720, side = 1, level = 0, x = 53.60, y = 31.80, honor = 1},
    [29030] = {area = 606, side = 3, level = 0, x = 62.90, y = 22.80, honor = 1},
  },
  ["Outland"] = {
    [11735] = {area = 464, side = 2, level = 0, x = 44.70, y = 52.50},
    [11736] = {area = 475, side = 2, level = 0, x = 41.80, y = 65.90},
    [11738] = {area = 476, side = 2, level = 0, x = 56.00, y = 68.50},
    [11747] = {area = 465, side = 2, level = 0, x = 61.90, y = 58.50},
    [11750] = {area = 477, side = 2, level = 0, x = 49.70, y = 69.60},
    [11752] = {area = 473, side = 2, level = 0, x = 39.60, y = 54.30},
    [11754] = {area = 478, side = 2, level = 0, x = 54.20, y = 55.40},
    [11758] = {area = 467, side = 2, level = 0, x = 68.60, y = 52.00},
    [11759] = {area = 479, side = 2, level = 0, x = 31.10, y = 62.70},
    [11767] = {area = 475, side = 1, level = 0, x = 49.90, y = 59.00},
    [11772] = {area = 462, side = 1, level = 0, x = 46.30, y = 50.30},
    [11774] = {area = 463, side = 1, level = 0, x = 47.00, y = 25.90},
    [11775] = {area = 465, side = 1, level = 0, x = 57.30, y = 41.80},
    [11778] = {area = 477, side = 1, level = 0, x = 51.10, y = 34.20},
    [11779] = {area = 473, side = 1, level = 0, x = 33.60, y = 30.30},
    [11782] = {area = 478, side = 1, level = 0, x = 51.90, y = 43.30},
    [11787] = {area = 467, side = 1, level = 0, x = 35.60, y = 51.90},
    [11799] = {area = 479, side = 1, level = 0, x = 32.30, y = 68.40},
    [11806] = {area = 464, side = 1, level = 0, x = 46.40, y = 52.40, honor = 1},
    [11807] = {area = 475, side = 1, level = 0, x = 41.60, y = 65.80, honor = 1},
    [11809] = {area = 476, side = 1, level = 0, x = 55.80, y = 67.80, honor = 1},
    [11818] = {area = 465, side = 1, level = 0, x = 62.20, y = 58.40, honor = 1},
    [11821] = {area = 477, side = 1, level = 0, x = 49.80, y = 69.40, honor = 1},
    [11823] = {area = 473, side = 1, level = 0, x = 39.60, y = 54.60, honor = 1},
    [11825] = {area = 478, side = 1, level = 0, x = 54.00, y = 55.40, honor = 1},
    [11829] = {area = 467, side = 1, level = 0, x = 68.80, y = 51.80, honor = 1},
    [11830] = {area = 479, side = 1, level = 0, x = 31.20, y = 62.60, honor = 1},
    [11835] = {area = 479, side = 2, level = 0, x = 32.00, y = 68.40, honor = 1},
    [11843] = {area = 475, side = 2, level = 0, x = 49.80, y = 58.60, honor = 1},
    [11848] = {area = 462, side = 2, level = 0, x = 46.40, y = 50.60, honor = 1},
    [11850] = {area = 463, side = 2, level = 0, x = 46.80, y = 26.40, honor = 1},
    [11851] = {area = 465, side = 2, level = 0, x = 57.00, y = 42.00, honor = 1},
    [11854] = {area = 477, side = 2, level = 0, x = 50.80, y = 34.20, honor = 1},
    [11855] = {area = 473, side = 2, level = 0, x = 33.40, y = 30.60, honor = 1},
    [11858] = {area = 478, side = 2, level = 0, x = 52.00, y = 42.80, honor = 1},
    [11863] = {area = 467, side = 2, level = 0, x = 35.40, y = 51.60, honor = 1},
  },
  ["Northrend"] = {
    [13440] = {area = 486, side = 2, level = 0, x = 55.10, y = 20.20},
    [13441] = {area = 486, side = 1, level = 0, x = 51.10, y = 11.90},
    [13442] = {area = 493, side = 2, level = 0, x = 47.90, y = 66.00},
    [13443] = {area = 488, side = 2, level = 0, x = 75.10, y = 43.70},
    [13444] = {area = 491, side = 2, level = 0, x = 57.70, y = 15.70},
    [13445] = {area = 490, side = 2, level = 0, x = 34.10, y = 60.70},
    [13446] = {area = 495, side = 2, level = 0, x = 41.40, y = 87.00},
    [13447] = {area = 510, side = 2, level = 0, x = 77.70, y = 74.90},
    [13449] = {area = 496, side = 2, level = 0, x = 40.40, y = 61.00},
    [13450] = {area = 493, side = 1, level = 0, x = 47.30, y = 61.70},
    [13451] = {area = 488, side = 1, level = 0, x = 38.50, y = 48.40},
    [13453] = {area = 491, side = 1, level = 0, x = 48.40, y = 13.50},
    [13454] = {area = 490, side = 1, level = 0, x = 19.10, y = 61.30},
    [13455] = {area = 495, side = 1, level = 0, x = 40.30, y = 85.60},
    [13457] = {area = 510, side = 1, level = 0, x = 80.50, y = 53.00},
    [13458] = {area = 496, side = 1, level = 0, x = 43.20, y = 71.40},
    [13485] = {area = 486, side = 1, level = 0, x = 55.00, y = 20.00, honor = 1},
    [13486] = {area = 493, side = 1, level = 0, x = 48.00, y = 66.20, honor = 1},
    [13487] = {area = 488, side = 1, level = 0, x = 75.20, y = 43.60, honor = 1},
    [13488] = {area = 491, side = 1, level = 0, x = 57.80, y = 16.20, honor = 1},
    [13489] = {area = 490, side = 1, level = 0, x = 33.80, y = 60.40, honor = 1},
    [13490] = {area = 495, side = 1, level = 0, x = 41.40, y = 86.60, honor = 1},
    [13491] = {area = 510, side = 1, level = 0, x = 78.20, y = 74.80, honor = 1},
    [13492] = {area = 496, side = 1, level = 0, x = 40.20, y = 61.20, honor = 1},
    [13493] = {area = 486, side = 2, level = 0, x = 51.20, y = 11.60, honor = 1},
    [13494] = {area = 493, side = 2, level = 0, x = 47.00, y = 61.60, honor = 1},
    [13495] = {area = 488, side = 2, level = 0, x = 38.20, y = 48.40, honor = 1},
    [13496] = {area = 491, side = 2, level = 0, x = 48.60, y = 13.20, honor = 1},
    [13497] = {area = 490, side = 2, level = 0, x = 19.20, y = 61.00, honor = 1},
    [13498] = {area = 495, side = 2, level = 0, x = 40.20, y = 85.20, honor = 1},
    [13499] = {area = 510, side = 2, level = 0, x = 80.00, y = 53.20, honor = 1},
    [13500] = {area = 496, side = 2, level = 0, x = 43.20, y = 71.60, honor = 1},
  },
  ["Pandaria"] = {
    [32496] = {area = 811, side = 1, level = 0, x = 77.75, y = 33.60},
    [32497] = {area = 858, side = 3, level = 0, x = 56.10, y = 69.50, honor = 1},
    [32498] = {area = 806, side = 3, level = 0, x = 47.20, y = 47.20, honor = 1},
    [32499] = {area = 857, side = 3, level = 0, x = 74.00, y = 9.49, honor = 1},
    [32500] = {area = 809, side = 3, level = 0, x = 71.10, y = 90.90, honor = 1},
    [32501] = {area = 810, side = 3, level = 0, x = 71.50, y = 56.30, honor = 1},
    [32502] = {area = 807, side = 3, level = 0, x = 51.80, y = 51.40, honor = 1},
    [32503] = {area = 811, side = 2, level = 0, x = 79.90, y = 37.30},
    [32509] = {area = 811, side = 2, level = 0, x = 77.75, y = 33.90, honor = 1},
    [32510] = {area = 811, side = 1, level = 0, x = 79.65, y = 37.25, honor = 1},
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
				if (data.side == 3 or data.side == faction) and not ns:IsQuestCompleted(quest) then
					table_insert(nodes, {
						quest = quest,
						area = data.area,
						level = data.level,
						x = data.x/100,
						y = data.y/100,
						title = data.title,
						text = data.text,
						honor = data.honor,
					})
				end
			end
		end

		table_wipe(db)
		self.loaded = true
		return true
	end,

	OnShow = function(self)
		if self.node.honor then
			self.icon:SetTexture(iconTextureHonor)
		end
	end,

	OnEnter = function(self)
		WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if self.node.title then
			WorldMapTooltip:SetText(self.node.title)
		else
			WorldMapTooltip:SetText(iconTitle .. ": " .. (self.node.honor and "Honor" or "Desecrate"))
		end
		WorldMapTooltip:AddLine(GetMapNameByID(self.node.area), 1, .82, 0, false)
		if self.node.text then
			WorldMapTooltip:AddLine(self.node.text, 1, 1, 1, true)
		end
		WorldMapTooltip:AddLine(string_format("%.1f, %.1f", self.node.x * 100, self.node.y * 100), 1, 1, 1, false)
		WorldMapTooltip:AddLine(string_format("Quest %d", self.node.quest), .8, .8, .8, false)
		if ns.WaypointAddons:GetAddon() then
			WorldMapTooltip:AddLine("<Click for waypoint.>", .8, .8, .8, false)
		end
		WorldMapTooltip:Show()
	end,

	OnLeave = function(self)
		WorldMapTooltip:Hide()
	end,
}
