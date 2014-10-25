local _G = _G
local pairs = pairs
local string_format = string.format
local table_insert = table.insert
local table_wipe = table.wipe
local GetMapNameByID = GetMapNameByID
local WorldMapTooltip = WorldMapTooltip

local _, ns = ...

local texture = "Calendar_LunarFestival"
local iconTitle = "Elder"
local iconTexture = "Interface\\Icons\\INV_Misc_ElvenCoins"
local iconTextureInstance = "Interface\\Icons\\Spell_Shadow_Teleport"
local nodes = {}

local db = {
  ["Deepholm"] = {
    [29735] = {area = 640, level = 0, x = 49.60, y = 54.80},
    [29734] = {area = 640, level = 0, x = 27.60, y = 69.20},
  },
  ["Eastern Kingdoms"] = {
    [8647] = {area = 19, level = 0, x = 54.20, y = 49.40},
    [8652] = {area = 20, level = 0, x = 61.80, y = 54.00},
    [8645] = {area = 21, level = 0, x = 45.00, y = 41.20},
    [8714] = {area = 22, level = 0, x = 69.00, y = 73.40},
    [8722] = {area = 22, level = 0, x = 63.40, y = 36.20},
    [8688] = {area = 23, level = 0, x = 35.40, y = 68.80},
    [8650] = {area = 23, level = 0, x = 75.60, y = 54.40},
    [8727] = {area = 23, level = 0, x = 26.90, y = 10.20, instance = 1, title = iconTitle .. ": Instance"},
    [8643] = {area = 26, level = 0, x = 50.00, y = 48.00},
    [8653] = {area = 27, level = 0, x = 53.80, y = 49.80},
    [8651] = {area = 28, level = 0, x = 21.20, y = 79.00},
    [8683] = {area = 29, level = 0, x = 52.40, y = 24.00},
    [8644] = {area = 29, level = 0, x = 22.00, y = 33.20, instance = 1, title = iconTitle .. ": Instance"},
    [8619] = {area = 29, level = 0, x = 19.40, y = 33.20, instance = 1, title = iconTitle .. ": Instance"},
    [8636] = {area = 29, level = 0, x = 70.00, y = 45.40},
    [8646] = {area = 30, level = 0, x = 34.40, y = 50.40},
    [8649] = {area = 30, level = 0, x = 39.80, y = 63.60},
    [8642] = {area = 35, level = 0, x = 33.20, y = 46.60},
    [8716] = {area = 37, level = 0, x = 71.00, y = 34.20},
    [8713] = {area = 38, level = 0, x = 69.60, y = 53.50, instance = 1, title = iconTitle .. ": Instance"},
    [8675] = {area = 39, level = 0, x = 56.80, y = 47.20},
    [8866] = {area = 341, level = 0, x = 29.40, y = 17.20},
    [8648] = {area = 382, level = 0, x = 66.60, y = 38.00},
    [29738] = {area = 615, level = 0, x = 57.20, y = 86.20},
    [8674] = {area = 673, level = 0, x = 40.00, y = 72.40},
    [29737] = {area = 700, level = 0, x = 50.80, y = 70.40},
    [29736] = {area = 700, level = 0, x = 51.80, y = 33.00},
  },
  ["Kalimdor"] = {
    [8670] = {area = 4, level = 0, x = 53.20, y = 43.60},
    [8673] = {area = 9, level = 0, x = 48.40, y = 53.20},
    [8717] = {area = 11, level = 0, x = 48.60, y = 59.20},
    [8680] = {area = 11, level = 0, x = 68.40, y = 70.00},
    [8715] = {area = 41, level = 0, x = 56.80, y = 53.00},
    [8721] = {area = 42, level = 0, x = 49.40, y = 18.80},
    [8725] = {area = 43, level = 0, x = 35.40, y = 49.00},
    [8724] = {area = 61, level = 0, x = 77.00, y = 75.60},
    [8682] = {area = 61, level = 0, x = 46.40, y = 51.00},
    [8635] = {area = 101, level = 0, x = 30.10, y = 62.50, instance = 1},
    [8685] = {area = 121, level = 0, x = 62.60, y = 31.00},
    [8679] = {area = 121, level = 0, x = 76.60, y = 37.80},
    [8676] = {area = 161, level = 0, x = 34.70, y = 9.90, instance = 1},
    [8684] = {area = 161, level = 0, x = 51.40, y = 28.80},
    [8671] = {area = 161, level = 0, x = 37.20, y = 79.00},
    [8720] = {area = 181, level = 0, x = 64.60, y = 79.20},
    [8723] = {area = 182, level = 0, x = 38.40, y = 52.80},
    [8681] = {area = 201, level = 0, x = 50.40, y = 76.20},
    [8719] = {area = 261, level = 0, x = 53.00, y = 35.40},
    [8654] = {area = 261, level = 0, x = 30.80, y = 13.40},
    [8672] = {area = 281, level = 0, x = 59.80, y = 49.80},
    [8726] = {area = 281, level = 0, x = 53.20, y = 56.60},
    [8677] = {area = 321, level = 1, x = 52.20, y = 59.80},
    [8678] = {area = 362, level = 0, x = 73.00, y = 23.80},
    [8718] = {area = 381, level = 0, x = 39.20, y = 32.00},
    [29740] = {area = 606, level = 0, x = 62.60, y = 22.80},
    [29739] = {area = 606, level = 0, x = 26.60, y = 62.00},
    [8686] = {area = 607, level = 0, x = 41.60, y = 47.40},
    [29742] = {area = 720, level = 0, x = 65.40, y = 18.60},
    [29741] = {area = 720, level = 0, x = 31.60, y = 63.00},
    [8644] = {area = 721, level = 3, x = 61.90, y = 40.50},
  },
  ["Northrend"] = {
    [13012] = {area = 486, level = 0, x = 59.00, y = 65.60},
    [13029] = {area = 486, level = 0, x = 42.80, y = 49.60},
    [13033] = {area = 486, level = 0, x = 57.40, y = 43.60},
    [13021] = {area = 486, level = 0, x = 27.40, y = 26.20, instance = 1},
    [13016] = {area = 486, level = 0, x = 33.80, y = 34.20},
    [13014] = {area = 488, level = 0, x = 29.60, y = 55.80},
    [13022] = {area = 488, level = 0, x = 26.80, y = 47.30, instance = 1},
    [13031] = {area = 488, level = 0, x = 35.00, y = 48.40},
    [13019] = {area = 488, level = 0, x = 48.80, y = 78.00},
    [13030] = {area = 490, level = 0, x = 64.20, y = 47.00},
    [13025] = {area = 490, level = 0, x = 80.40, y = 37.00},
    [13013] = {area = 490, level = 0, x = 60.40, y = 27.60},
    [13017] = {area = 491, level = 0, x = 58.80, y = 49.10, instance = 1},
    [13067] = {area = 491, level = 0, x = 58.20, y = 42.70, instance = 1},
    [13024] = {area = 493, level = 0, x = 63.80, y = 49.00},
    [13018] = {area = 493, level = 0, x = 49.80, y = 63.60},
    [13015] = {area = 495, level = 0, x = 28.80, y = 73.60},
    [13066] = {area = 495, level = 0, x = 37.90, y = 26.60, instance = 1},
    [13028] = {area = 495, level = 0, x = 41.00, y = 84.60},
    [13020] = {area = 495, level = 0, x = 31.20, y = 37.60},
    [13032] = {area = 495, level = 0, x = 64.60, y = 51.20},
    [13065] = {area = 496, level = 0, x = 76.10, y = 20.70, instance = 1},
    [13027] = {area = 496, level = 0, x = 58.80, y = 56.00},
    [13023] = {area = 496, level = 0, x = 28.30, y = 88.70, instance = 1},
    [13026] = {area = 501, level = 0, x = 49.00, y = 14.00},
  },
  ["Dungeon"] = {
    [13021] = {area = 520, level = 1, x = 56.00, y = 64.80},
    [13017] = {area = 523, level = 1, x = 47.80, y = 71.00},
    [13067] = {area = 524, level = 2, x = 56.00, y = 36.60},
    [13066] = {area = 526, level = 1, x = 29.40, y = 61.80},
    [13065] = {area = 530, level = 1, x = 45.80, y = 62.00},
    [13022] = {area = 533, level = 1, x = 22.00, y = 44.00},
    [13023] = {area = 534, level = 1, x = 67.80, y = 78.00},
    [8676] = {area = 686, level = 0, x = 34.40, y = 39.60},
    [8713] = {area = 687, level = 1, x = 62.40, y = 34.40},
    [8619] = {area = 704, level = 1, x = 50.60, y = 63.20},
    [8635] = {area = 750, level = 2, x = 51.50, y = 93.70},
    [8727] = {area = 765, level = 1, x = 79.00, y = 21.80},
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
				if not ns:IsQuestCompleted(quest) then
					table_insert(nodes, {
						quest = quest,
						area = data.area,
						level = data.level,
						x = data.x/100,
						y = data.y/100,
						title = data.title,
						text = data.text,
						instance = data.instance,
					})
				end
			end
		end

		table_wipe(db)
		self.loaded = true
		return true
	end,

	OnShow = function(self)
		if self.node.instance then
			self.icon:SetTexture(iconTextureInstance)
		end
	end,

	OnEnter = function(self)
		WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if self.node.title then
			WorldMapTooltip:SetText(self.node.title)
		else
			if self.node.instance then
				WorldMapTooltip:SetText(iconTitle .. ": Instance")
			else
				WorldMapTooltip:SetText(iconTitle)
			end
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
