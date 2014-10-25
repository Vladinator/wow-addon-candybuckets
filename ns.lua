local _G = _G
local ipairs = ipairs
local pairs = pairs
local string_format = string.format
local table_insert = table.insert
local table_remove = table.remove
local time = time
local type = type
local CreateFrame = CreateFrame
local GetCurrentMapAreaID = GetCurrentMapAreaID
local GetCurrentMapContinent = GetCurrentMapContinent
local GetMapNameByID = GetMapNameByID
local GetQuestsCompleted = GetQuestsCompleted
local IsAddOnLoaded = IsAddOnLoaded
local IsModifierKeyDown = IsModifierKeyDown
local UnitFactionGroup = UnitFactionGroup

local _, ns = ...
ns.modules = {}
ns.widgets = {}
ns.quests = {}

function ns.quests:CacheQuests(force)
	if force or not self.updated or time() - self.updated >= 1 then
		self.updated = time()
		GetQuestsCompleted(self)
	end
end

function ns.quests:IsCompleted(questID)
	self:CacheQuests()
	return self[questID]
end

local Astrolabe = DongleStub("Astrolabe-1.0")
local worldMapFrame = WorldMapButton

local IsAcceptedZone
do
	local empty = {}
	local useEmpty = false

	IsAcceptedZone = setmetatable({}, {
		__index = function(self, i)
			if useEmpty then
				self[i] = empty
				return empty
			end
			self[i] = {}
			return self[i]
		end
	})

	local continents = {GetMapContinents()}
	local numContinents = #continents
	local continent = 0
	local zones
	local numZones

	for i = 1, numContinents, 2 do
		continent = continent + 1
		zones = {GetMapZones(continent)}
		numZones = #zones

		for j = 1, numZones, 2 do
			IsAcceptedZone[continent][zones[j]] = false
		end
	end

	IsAcceptedZone[1][13] = true -- Kalimdor
	IsAcceptedZone[2][14] = true -- Eastern Kingdoms
	IsAcceptedZone[3][466] = true -- Outland
	IsAcceptedZone[4][485] = true -- Northrend
	IsAcceptedZone[5][751] = true -- The Maelstrom
	IsAcceptedZone[6][862] = true -- Pandaria
	IsAcceptedZone[7][962] = true -- Draenor

	-- Vashj'ir
	for k, v in ipairs({610, 613, 614, 615}) do
		IsAcceptedZone[2][v] = false
	end

	-- Dalaran
	for k, v in ipairs({485, 504, 510, 924}) do -- Northrend, Dalaran#504, Crystalsong Forest, Dalaran#924
		IsAcceptedZone[4][v] = false
	end

	useEmpty = true
end

local WaypointAddons = {}
do
	-- enable for other parts of the addon to use this interface
	ns.WaypointAddons = WaypointAddons

	-- TomTom (v50400-1.0.0)
	table_insert(WaypointAddons, {
		name = "TomTom",
		func = function(self, widget, everything)
			if everything then
				for _, node in ipairs(widget.module.nodes) do
					TomTom:AddMFWaypoint(node.area, node.level, node.x, node.y, {
						title = string_format("%s (%s, %d)", widget.module.title, GetMapNameByID(node.area), node.quest),
						minimap = true,
						crazy = true,
					})
				end
			end
			TomTom:AddMFWaypoint(widget.node.area, widget.node.level, widget.node.x, widget.node.y, {
				title = string_format("%s (%s, %d)", widget.module.title, GetMapNameByID(widget.node.area), widget.node.quest),
				minimap = true,
				crazy = true,
			})
		end,
	})

	-- TomTomLite (v50100-1.0.0)
	table_insert(WaypointAddons, {
		name = "TomTomLite",
		func = function(self, widget, everything)
			if everything then
				for _, node in ipairs(widget.module.nodes) do
					TomTomLite:AddWaypoint(node.area, node.level, node.x, node.y, {
						title = string_format("%s (%s, %d)", widget.module.title, GetMapNameByID(node.area), node.quest),
					})
				end
			end
			TomTomLite:AddWaypoint(widget.node.area, widget.node.level, widget.node.x, widget.node.y, {
				title = string_format("%s (%s, %d)", widget.module.title, GetMapNameByID(widget.node.area), widget.node.quest),
			})
		end,
	})

	-- prepare some nice looking strings explaning what addons that are implemented
	local numAddons = #WaypointAddons
	local supportedAddons = "... darn! Seems like I forgot to actually add waypoint support"

	if numAddons > 0 then
		supportedAddons = ""
	end

	for index, addon in ipairs(WaypointAddons) do
		supportedAddons = supportedAddons .. addon.name

		if index < numAddons then
			if index == numAddons - 1 then
				supportedAddons = supportedAddons .. " or "
			else
				supportedAddons = supportedAddons .. ", "
			end
		end
	end

 	supportedAddons = supportedAddons .. "."

	-- get first loaded addon
	function WaypointAddons:GetAddon()
		for _, addon in ipairs(WaypointAddons) do
			if IsAddOnLoaded(addon.name) then
				return addon
			end
		end
	end

	-- apply a waypoint or all the waypoints on the first active addon
	local informed

	function WaypointAddons:Set(widget, everything)
		local addon = WaypointAddons:GetAddon()

		if addon then
			addon:func(widget, everything)
		elseif not informed then
			DEFAULT_CHAT_FRAME:AddMessage("These waypoint addons are supported: " .. supportedAddons, 1, 1, 0)
			informed = 1
		end
	end
end

function ns:CanLoadEvent(texture)
	return type(ns.modules[texture]) == "table" and not ns.modules[texture].loaded
end

function ns:LoadEvent(texture)
	local loaded = ns.modules[texture]:load()

	if loaded then
		ns:UpdateNodes()
	end

	return loaded
end

function ns:GetPlayerFaction()
	local faction = UnitFactionGroup("player")

	local factionId
	if faction == "Alliance" then
		factionId = 1
	elseif faction == "Horde" then
		factionId = 2
	end

	return factionId
end

function ns:IsQuestCompleted(questID)
	return ns.quests:IsCompleted(questID)
end

function ns:QuestCompleted(questID)
	ns.quests:CacheQuests(1)

	for _, module in pairs(ns.modules) do
		if module.loaded then
			local remove = {}

			for _, node in pairs(module.nodes) do
				if node.quest == questID then
					ns:RemoveNode(node)
					table_insert(remove, node)
				end
			end

			while #remove > 0 do
				local removeNode = table_remove(remove, 1)

				for index, node in pairs(module.nodes) do
					if node == removeNode then
						table_remove(module.nodes, index)
						break
					end
				end
			end
		end
	end
end

function ns:UpdateNodes()
	if not worldMapFrame:IsVisible() then
		return
	end

	local continent = IsAcceptedZone[GetCurrentMapContinent()]
	local zone = continent[GetCurrentMapAreaID()]

	for _, module in pairs(ns.modules) do
		if module.loaded then
			for _, node in pairs(module.nodes) do
				if not ns:IsQuestCompleted(node.quest) then
					if zone == false or (zone == true and continent[node.area] == false) then
						ns:CreateOrUpdateWidget(node, module)
					else
						ns:RemoveNode(node)
					end
				else
					ns:QuestCompleted(node.quest)
				end
			end
		end
	end
end

function ns:RemoveNode(node)
	local widget = ns:GetWidget(node)

	if widget then
		widget:Hide()

		-- TODO: minimap icons
		-- Astrolabe:RemoveIconFromMinimap(widget)

		widget.node, widget.module = nil
	end
end

function ns:GetWidget(node)
	for i = 1, #ns.widgets do
		local widget = ns.widgets[i]

		if widget:IsShown() then
			if widget.node == node then
				return widget
			end
		end
	end
end

function ns:CreateOrUpdateWidget(node, module)
	local widget = ns:GetWidget(node)

	if widget then
		widget:Hide()

		widget.node, widget.module = nil
	end

	widget = nil
	for i = 1, #ns.widgets do
		local w = ns.widgets[i]

		if not w:IsShown() then
			widget = w
			break
		end
	end

	if not widget then
		widget = ns:CreateWidget()

		table_insert(ns.widgets, widget)
	end

	widget.node, widget.module = node, module

	if module then
		widget.icon:SetTexture(module.texture)
		widget:SetScript("OnShow", module.OnShow)
		widget:SetScript("OnEnter", module.OnEnter)
		widget:SetScript("OnLeave", module.OnLeave)
		widget:SetScript("OnClick", ns.WidgetOnClick)
	else
		widget.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		widget:SetScript("OnShow", nil)
		widget:SetScript("OnEnter", nil)
		widget:SetScript("OnLeave", nil)
		widget:SetScript("OnClick", nil)
	end

	Astrolabe:PlaceIconOnWorldMap(worldMapFrame, widget, node.area, node.level, node.x, node.y)
	widget:SetParent(worldMapFrame)
	widget:SetFrameStrata("HIGH")
	widget:SetFrameLevel(255)

	-- TODO: minimap icons
	-- Astrolabe:PlaceIconOnMinimap(widget, node.area, node.level, node.x, node.y)
end

function ns:CreateWidget()
	local widget = CreateFrame("Button")
	widget:Hide()
	widget:SetSize(16, 16)
	widget:RegisterForClicks("AnyUp")

	widget.icon = widget:CreateTexture(nil, "ARTWORK", 2)
	widget.icon:SetAllPoints()
	widget.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	widget.icon:SetTexCoord(.15, .85, .15, .85)

	widget.border = widget:CreateTexture(nil, "ARTWORK", 1)
	widget.border:SetPoint("TOPLEFT", -1, 1)
	widget.border:SetPoint("BOTTOMRIGHT", 1, -1)
	widget.border:SetTexture(0, 0, 0, 1)

	return widget
end

function ns.WidgetOnClick(self, button)
	if button == "LeftButton" then
		WaypointAddons:Set(self, IsModifierKeyDown())
	end
end
