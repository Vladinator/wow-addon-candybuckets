if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
	return
end

---@alias CandyBucketsModuleName "hallow"|"lunar"|"midsummer"

---@class CandyBucketsNS : table
---@field public modules table<CandyBucketsModuleName, CandyBucketsModule>
---@field public uimaps table<number, UiMapDetails[]>

---@class CandyBucketsQuest : table
---@field public quest number
---@field public side number `1` = Alliance, `2` = Horde, `3` = Neutral
---@field public extra? number
---@field public module? CandyBucketsModule

---@class CandyBucketsModule
---@field public event CandyBucketsModuleName
---@field public texture string[]
---@field public title string[]
---@field public quests CandyBucketsQuest[]
---@field public patterns string[]
---@field public loaded? boolean

---@class CandyBucketsMapCanvas : Frame
---@field public GetMap fun(): CandyBucketsMapPosition
---@field public GetMapID fun(): number
---@field public RemoveAllPinsByTemplate fun(self: CandyBucketsMapCanvas, template: string)
---@field public AcquirePin fun(self: CandyBucketsMapCanvas, template: string, ...)
---@field public RefreshAllData fun(self: CandyBucketsMapCanvas, fromOnShow?: boolean)
---@field public GetNumActivePinsByTemplate fun(self: CandyBucketsMapCanvas, template: string): number

---@class CandyBucketsMapPosition : CandyBucketsMapCanvas
---@field public name string
---@field public quest? CandyBucketsQuest
---@field public GetPosition fun(): x: number, y: number
---@field public SetPosition fun(self: CandyBucketsMapPosition, x: number, y: number)

---@class CandyBucketsWaypointAddOn
---@field public name string
---@field public standard? boolean
---@field public func fun(self: CandyBucketsWaypointAddOn, poi: CandyBucketsMapPosition, wholeModule?: boolean): boolean
---@field public funcAll fun(self: CandyBucketsWaypointAddOn, module: CandyBucketsModule): boolean

---@class CandyBucketsDataProvider : CandyBucketsMapCanvas

---@class CandyBucketsPin : CandyBucketsMapPosition
---@field public SetScalingLimits fun(self: CandyBucketsPin, scaleFactor: number, startScale: number, endScale: number)
---@field public UseFrameLevelType fun(self: CandyBucketsPin, template: string, level: number)
---@field public HighlightTexture Texture
---@field public Texture Texture
---@field public Border Texture

---@class CandyBucketsStats : CandyBucketsPin
---@field public Text FontString

---@class CandyBucketsEvalPositionQuestInfo
---@field public module? CandyBucketsModule
---@field public quest? CandyBucketsEvalPositionQuestInfo
---@field public side? number `1` = Alliance, `2` = Horde, `3` = Neutral
---@field public missing? boolean
---@field public error? string
---@field public warning? string
---@field public success? string
---@field public name? string
---@field public uiMapID? number
---@field public x? number
---@field public y? number
---@field public distance? number

---@class CandyBucketsEvalPositionRetInfo
---@field public has? boolean
---@field public success? boolean
---@field public data? CandyBucketsEvalPositionQuestInfo

local addonName = ... ---@type string
local ns = select(2, ...) ---@class CandyBucketsNS

--
-- Debug
--

local DEBUG_MODULE = false
local DEBUG_FACTION = false
local DEBUG_LOCATION = false

--
-- Session
--

ns.FACTION = 0 --- `1` = Alliance, `2` = Horde, `3` = Neutral
ns.QUESTS = {} ---@type CandyBucketsQuest[]
ns.PROVIDERS = {} ---@type table<CandyBucketsDataProvider, true?>

---@type table<number, boolean>
ns.COMPLETED_QUESTS = setmetatable({}, {
	__index = function(self, questID)
		local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID)
		if isCompleted then
			rawset(self, questID, isCompleted)
		end
		return isCompleted
	end
})

--
-- Map
--

ns.PARENT_MAP = {} ---@type table<number, table<number, boolean>>
do

	---@param uiParentMapID number
	---@param uiChildMapID number
	local function AddParentChildMapIDs(uiParentMapID, uiChildMapID)
		if not ns.PARENT_MAP[uiParentMapID] then
			ns.PARENT_MAP[uiParentMapID] = { [uiParentMapID] = true }
		end
		ns.PARENT_MAP[uiParentMapID][uiChildMapID] = true
	end

	---@param uiMapID number
	---@param getChildren fun(uiMapID: number): UiMapDetails[]?
	---@param depthRemaining number
	---@param uiParentMapIDs? table<number, boolean>
	local function CheckMapRecursively(uiMapID, getChildren, depthRemaining, uiParentMapIDs)
		if not uiMapID or not getChildren then return end
		if not depthRemaining then depthRemaining = 1 end
		if depthRemaining < 1 then return end
		if not uiParentMapIDs then uiParentMapIDs = {} end
		for uiParentMapID, _ in pairs(uiParentMapIDs) do
			AddParentChildMapIDs(uiParentMapID, uiMapID)
		end
		uiParentMapIDs[uiMapID] = true
		local children = getChildren(uiMapID)
		if children and type(children) == "table" then
			for _, uiChildMapID in pairs(children) do
				if type(uiChildMapID) == "table" then
					uiChildMapID = uiChildMapID.mapID ---@diagnostic disable-line: cast-local-type
				end
				if type(uiChildMapID) == "number" then
					AddParentChildMapIDs(uiMapID, uiChildMapID)
					CheckMapRecursively(uiChildMapID, getChildren, depthRemaining - 1, uiParentMapIDs)
				end
			end
		end
	end

	---@return UiMapDetails[]?
	local function GetChildren(uiMapID)
		return C_Map.GetMapChildrenInfo(uiMapID, nil, true) -- Enum.UIMapType.Zone
	end

	---@return UiMapDetails[]?
	local function GetChildrenNS(uiMapID)
		return ns.uimaps and type(ns.uimaps) == "table" and ns.uimaps[uiMapID] ---@diagnostic disable-line: return-type-mismatch
	end

	for _, uiMapID in ipairs({
		12, -- Kalimdor
		13, -- Eastern Kingdoms
		101, -- Outland
		113, -- Northrend
		127, -- Crystalsong Forest
		203, -- Vashj'ir
		224, -- Stranglethorn Vale
		390, -- Vale of Eternal Blossoms
		424, -- Pandaria
		572, -- Draenor
		619, -- Broken Isles
		862, -- Zuldazar
		875, -- Zandalar
		876, -- Kul Tiras
		895, -- Tiragarde Sound
		947, -- Azeroth (CPU hog, but it's not too bad?)
		948, -- The Maelstrom
		1165, -- Dazar'alor
		1550, -- The Shadowlands
	}) do
		CheckMapRecursively(uiMapID, GetChildren, 10)
		CheckMapRecursively(uiMapID, GetChildrenNS, 10)
	end

	AddParentChildMapIDs(108, 111) -- Terokkar Forest -> Shattrath City
	AddParentChildMapIDs(1978, 2151) -- Dragon Isles -> The Forbidden Reach
	AddParentChildMapIDs(947, 2151) -- Azeroth -> The Forbidden Reach

end

---@param uiMapID number
---@param x number
---@param y number
---@return number uiMapID, number x, number y
local function GetLowestLevelMapFromMapID(uiMapID, x, y)
	if not uiMapID or not x or not y then
		return uiMapID, x, y
	end

	local child = C_Map.GetMapInfoAtPosition(uiMapID, x, y)
	if not child or not child.mapID then
		return uiMapID, x, y
	end

	local continentID, worldPos = C_Map.GetWorldPosFromMapPos(uiMapID, { x = x, y = y })
	if not continentID or not worldPos then
		return uiMapID, x, y
	end

	local _, mapPos = C_Map.GetMapPosFromWorldPos(continentID, worldPos, child.mapID)
	if mapPos and mapPos.x and mapPos.y then
		return child.mapID, mapPos.x, mapPos.y
	end

	return uiMapID, x, y
end

---@return number? uiMapID, Vector2DMixin? pos
local function GetPlayerMapAndPosition()
	local unit = "player"

	local uiMapID = C_Map.GetBestMapForUnit(unit)
	if not uiMapID then
		return
	end

	local pos = C_Map.GetPlayerMapPosition(uiMapID, unit)
	if not pos or not pos.x or not pos.y then
		return uiMapID
	end

	return uiMapID, pos
end

--
-- Waypoint
--

-- ns:GetWaypointAddon()
-- ns:AutoWaypoint(poi, wholeModule, silent)
do

	---@type CandyBucketsWaypointAddOn[]
	local waypointAddons = {}

	-- TomTom (v80001-1.0.2)
	table.insert(waypointAddons, {
		name = "TomTom",
		---@param self CandyBucketsWaypointAddOn
		---@param poi CandyBucketsMapPosition
		---@param wholeModule? boolean
		func = function(self, poi, wholeModule)
			if wholeModule then
				self:funcAll(poi.quest.module)
				TomTom:SetClosestWaypoint()
			else
				local uiMapID = poi:GetMap():GetMapID()
				local x, y = poi:GetPosition()
				local childUiMapID, childX, childY = GetLowestLevelMapFromMapID(uiMapID, x, y)
				local mapInfo = C_Map.GetMapInfo(childUiMapID)
				TomTom:AddWaypoint(childUiMapID, childX, childY, {
					title = string.format("%s (%s, %d)", poi.name, mapInfo.name or ("Map " .. childUiMapID), poi.quest.quest),
					minimap = true,
					crazy = true,
				})
			end
			return true
		end,
		---@param self CandyBucketsWaypointAddOn
		---@param module CandyBucketsModule
		funcAll = function(self, module)
			for i = 1, #ns.QUESTS do
				local quest = ns.QUESTS[i]
				if quest.module == module then
					for uiMapID, coords in pairs(quest) do
						if type(uiMapID) == "number" and type(coords) == "table" then
							local name = module.title[quest.extra or 1]
							local mapInfo = C_Map.GetMapInfo(uiMapID)
							TomTom:AddWaypoint(uiMapID, coords[1]/100, coords[2]/100, {
								title = string.format("%s (%s, %d)", name, mapInfo.name or ("Map " .. uiMapID), quest.quest),
								minimap = true,
								crazy = true,
							})
						end
					end
				end
			end
			return true
		end,
	})

	-- C_Map.SetUserWaypoint (9.0.1)
	table.insert(waypointAddons, {
		name = "Waypoint",
		standard = true,
		---@param self CandyBucketsWaypointAddOn
		---@param poi CandyBucketsMapPosition
		---@param wholeModule? boolean
		func = function(self, poi, wholeModule)
			if wholeModule then
				self:funcAll(poi.quest.module)
			else
				local uiMapID = poi:GetMap():GetMapID()
				local x, y = poi:GetPosition()
				local childUiMapID, childX, childY = GetLowestLevelMapFromMapID(uiMapID, x, y)
				local mapInfo = C_Map.GetMapInfo(childUiMapID)
				if not C_Map.CanSetUserWaypointOnMap(childUiMapID) then
					return format("Can't make a waypoint to %s. Enter the continent then try again.", mapInfo.name)
				end
				C_Map.SetUserWaypoint({ uiMapID = childUiMapID, position = { x = childX, y = childY } })
			end
			return true
		end,
		---@param self CandyBucketsWaypointAddOn
		---@param module CandyBucketsModule
		funcAll = function(self, module)
			for i = 1, #ns.QUESTS do
				local quest = ns.QUESTS[i]
				if quest.module == module then
					for uiMapID, coords in pairs(quest) do
						if type(uiMapID) == "number" and type(coords) == "table" then
							if C_Map.CanSetUserWaypointOnMap(uiMapID) then
								C_Map.SetUserWaypoint({ uiMapID = uiMapID, position = { x = coords[1]/100, y = coords[2]/100 } })
								return true
							end
						end
					end
				end
			end
			return "Can't make a waypoint to any destination."
		end,
	})

	local supportedAddons = {} ---@type string[]
	local supportedAddonsWarned = false
	for k, v in ipairs(waypointAddons) do supportedAddons[k] = v.name end
	supportedAddons = table.concat(supportedAddons, " ") ---@diagnostic disable-line: cast-local-type

	---@return CandyBucketsWaypointAddOn? waypoint
	function ns:GetWaypointAddon()
		for i = 1, #waypointAddons do
			local waypoint = waypointAddons[i]
			if waypoint.standard or C_AddOns.IsAddOnLoaded(waypoint.name) then
				return waypoint
			end
		end
	end

	---@param poi CandyBucketsMapPosition
	---@param wholeModule? boolean
	---@param silent? boolean
	---@return boolean success
	function ns:AutoWaypoint(poi, wholeModule, silent)
		local waypoint = ns:GetWaypointAddon()
		if not waypoint then
			if not silent then
				if not supportedAddonsWarned and supportedAddons ~= "" then
					supportedAddonsWarned = true
					DEFAULT_CHAT_FRAME:AddMessage("You need to install one of these supported waypoint addons: " .. supportedAddons, 1, 1, 0)
				end
			end
			return false
		end
		local status, err = pcall(function() return waypoint:func(poi, wholeModule) end)
		if not status or err ~= true then
			if not silent then
				DEFAULT_CHAT_FRAME:AddMessage(format("Unable to set waypoint%s%s", waypoint.standard and "" or format(" using %s", waypoint.name), type(err) == "string" and format(": %s", err) or "."), 1, 1, 0)
			end
			return false
		end
		return true
	end

end

--
-- Mixin
--

---@class CandyBucketsDataProvider
CandyBucketsDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin)

function CandyBucketsDataProviderMixin:OnShow()
end

function CandyBucketsDataProviderMixin:OnHide()
end

---@param event WowEvent
---@param ... any
function CandyBucketsDataProviderMixin:OnEvent(event, ...)
	-- self:RefreshAllData()
end

function CandyBucketsDataProviderMixin:RemoveAllData()
	local map = self:GetMap()
	map:RemoveAllPinsByTemplate("CandyBucketsPinTemplate")
	map:RemoveAllPinsByTemplate("CandyBucketsStatsTemplate")
end

---@param fromOnShow boolean?
function CandyBucketsDataProviderMixin:RefreshAllData(fromOnShow)
	self:RemoveAllData()

	local map = self:GetMap()
	local uiMapID = map:GetMapID()
	local childUiMapIDs = ns.PARENT_MAP[uiMapID]
	local tempVector = {} ---@type Vector2DMixin
	local questPOIs ---@type table<CandyBucketsQuest, Vector2DMixin>?

	if IsModifierKeyDown() then
		questPOIs = {}
	end

	for i = 1, #ns.QUESTS do
		local quest = ns.QUESTS[i]
		local poi ---@type Vector2DMixin?
		local poi2 ---@type Vector2DMixin?

		if not childUiMapIDs then
			poi = quest[uiMapID] ---@type Vector2DMixin?

		else
			for childUiMapID, _ in pairs(childUiMapIDs) do
				poi = quest[childUiMapID] ---@type Vector2DMixin?

				if poi then
					local translateKey = uiMapID .. "," .. childUiMapID

					if poi[translateKey] ~= nil then
						poi = poi[translateKey]

					else
						tempVector.x, tempVector.y = poi[1]/100, poi[2]/100
						local continentID, worldPos = C_Map.GetWorldPosFromMapPos(childUiMapID, tempVector)
						poi, poi2 = nil, poi

						if continentID and worldPos then
							local _, mapPos = C_Map.GetMapPosFromWorldPos(continentID, worldPos, uiMapID)

							if mapPos then
								poi = mapPos
								poi2[translateKey] = mapPos
							end
						end

						if not poi then
							poi2[translateKey] = false
						end
					end

					break
				end
			end
		end

		if poi then
			map:AcquirePin("CandyBucketsPinTemplate", quest, poi)
			if questPOIs then
				questPOIs[quest] = poi
			end
		end
	end

	if questPOIs and next(questPOIs) then
		map:AcquirePin("CandyBucketsStatsTemplate", questPOIs)
	end
end

--
-- Pin
--

local PIN_BORDER_COLOR = {
	[0] = "Interface\\Buttons\\GREYSCALERAMP64",
	[1] = "Interface\\Buttons\\BLUEGRAD64",
	[2] = "Interface\\Buttons\\REDGRAD64",
	[3] = "Interface\\Buttons\\YELLOWORANGE64",
}

---@class CandyBucketsPin
---@field public quest? any
---@field public name? string
---@field public description? string

---@class CandyBucketsPin
CandyBucketsPinMixin = CreateFromMixins(MapCanvasPinMixin)

function CandyBucketsPinMixin:OnLoad()
	self:SetScalingLimits(1, 1.0, 1.2)
	self.HighlightTexture:Hide()
	self.hasTooltip = true
	self:EnableMouse(self.hasTooltip)
	self.Texture:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
	self.Texture:ClearAllPoints()
	self.Texture:SetAllPoints()
	self.Border:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
	self.Border:SetTexture(PIN_BORDER_COLOR[0])
end

---@param quest CandyBucketsQuest
---@param poi Vector2DMixin
function CandyBucketsPinMixin:OnAcquired(quest, poi)
	self.quest = quest
	self:UseFrameLevelType("PIN_FRAME_LEVEL_AREA_POI", self:GetMap():GetNumActivePinsByTemplate("CandyBucketsPinTemplate"))
	self:SetSize(12, 12)
	self.Texture:SetTexture(quest.module.texture[quest.extra or 1])
	self.Border:SetTexture(PIN_BORDER_COLOR[quest.side or 0])
	self.name = quest.module.title[quest.extra or 1]
	if poi.GetXY then
		self:SetPosition(poi:GetXY())
	else
		self:SetPosition(poi[1]/100, poi[2]/100)
	end
	local uiMapID = self:GetMap():GetMapID()
	if uiMapID then
		local x, y = self:GetPosition()
		local childUiMapID, childX, childY = GetLowestLevelMapFromMapID(uiMapID, x, y)
		local mapInfo = C_Map.GetMapInfo(childUiMapID)
		if mapInfo and mapInfo.name and childX and childY then
			self.description = string.format("%s (%.2f, %.2f)", mapInfo.name, childX * 100, childY * 100)
		end
	end
end

function CandyBucketsPinMixin:OnReleased()
	self.quest = nil
	self.name = nil
	self.description = nil
end

function CandyBucketsPinMixin:OnMouseEnter()
	if not self.hasTooltip then return end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	self.UpdateTooltip = self.OnMouseEnter
	GameTooltip_SetTitle(GameTooltip, self.name)
	if self.description and self.description ~= "" then
		GameTooltip_AddNormalLine(GameTooltip, self.description, true)
	end
	GameTooltip_AddNormalLine(GameTooltip, "Quest ID: " .. self.quest.quest, false)
	if ns:GetWaypointAddon() then
		GameTooltip_AddNormalLine(GameTooltip, "<Click to show waypoint.>", false)
	end
	GameTooltip:Show()
end

function CandyBucketsPinMixin:OnMouseLeave()
	if not self.hasTooltip then return end
	GameTooltip:Hide()
end

function CandyBucketsPinMixin:OnClick(button)
	if button ~= "LeftButton" then return end
	ns:AutoWaypoint(self, IsModifierKeyDown())
end

--
-- Stats
--

---@class CandyBucketsStats
---@field public hasTooltip boolean
---@field public name? string
---@field public description? string

---@class CandyBucketsStats
CandyBucketsStatsMixin = CreateFromMixins(MapCanvasPinMixin)

function CandyBucketsStatsMixin:OnLoad()
	self:SetScalingLimits(1, 1.0, 1.2)
	self.HighlightTexture:Hide()
	self.hasTooltip = false
	self:EnableMouse(self.hasTooltip)
	self.Texture:Hide()
end

---@param questPOIs table<CandyBucketsQuest, Vector2DMixin>
function CandyBucketsStatsMixin:OnAcquired(questPOIs)
	local map = self:GetMap()
	self:UseFrameLevelType("PIN_FRAME_LEVEL_AREA_POI", map:GetNumActivePinsByTemplate("CandyBucketsStatsTemplate"))
	self:SetSize(map:GetSize())
	self:SetPosition(.5, .5)
	--self:ClearAllPoints()
	--self:SetPoint("TOPLEFT", map:GetCanvasContainer(), "TOPLEFT", 0, 0)
	self.name = nil
	self.description = nil
	local text
	local i = 0
	local uiMapID = map:GetMapID()
	if uiMapID then
		text = {}
		for quest, poi in pairs(questPOIs) do
			local x, y
			if poi.GetXY then
				x, y = poi:GetXY()
			else
				x, y = poi[1]/100, poi[2]/100
			end
			local childUiMapID, childX, childY = GetLowestLevelMapFromMapID(uiMapID, x, y)
			if childX > 0 and childX < 1 and childY > 0 and childY < 1 then
				local mapInfo = C_Map.GetMapInfo(childUiMapID)
				i = i + 1
				if mapInfo and mapInfo.name then
					text[i] = string.format("%s (%.2f, %.2f)", mapInfo.name, childX * 100, childY * 100)
				else
					text[i] = string.format("#%d", quest.quest)
				end
			end
		end
		table.sort(text)
		text = table.concat(text, "\r\n")
	end
	self.Text:SetText(text)
end

function CandyBucketsStatsMixin:OnReleased()
	self.name = nil
	self.description = nil
end

function CandyBucketsStatsMixin:OnMouseEnter()
	if not self.hasTooltip then return end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	self.UpdateTooltip = self.OnMouseEnter
	GameTooltip_SetTitle(GameTooltip, self.name)
	if self.description and self.description ~= "" then
		GameTooltip_AddNormalLine(GameTooltip, self.description, true)
	end
	GameTooltip:Show()
end

function CandyBucketsStatsMixin:OnMouseLeave()
	if not self.hasTooltip then return end
	GameTooltip:Hide()
end

function CandyBucketsStatsMixin:OnClick(button)
	if button ~= "LeftButton" then return end
	-- TODO: ?
end

--
-- Modules
--

ns.modules = ns.modules or {}

local MODULE_FROM_TEXTURE = {
	[235461] = "hallow",
	[235462] = "hallow",
	[235460] = "hallow",
	[235470] = "lunar",
	[235471] = "lunar",
	[235469] = "lunar",
	[235473] = "midsummer",
	[235474] = "midsummer",
	[235472] = "midsummer",
}

--
-- Addon
--

local addon = CreateFrame("Frame") ---@class CandyBucketsAddOn : Frame
addon:SetScript("OnEvent", function(addon, event, ...) addon[event](addon, event, ...) end)
addon:RegisterEvent("ADDON_LOADED")
addon:RegisterEvent("PLAYER_LOGIN")

local InjectDataProvider do
	local function WorldMapMixin_OnLoad(self)
		local dataProvider = CreateFromMixins(CandyBucketsDataProviderMixin)
		ns.PROVIDERS[dataProvider] = true
		self:AddDataProvider(dataProvider)
	end

	function InjectDataProvider()
		hooksecurefunc(WorldMapMixin, "OnLoad", WorldMapMixin_OnLoad)
		WorldMapMixin_OnLoad(WorldMapFrame)
	end
end

---@param onlyShownMaps boolean
---@param fromOnShow? boolean
function addon:RefreshAllWorldMaps(onlyShownMaps, fromOnShow)
	for dataProvider, _ in pairs(ns.PROVIDERS) do
		if not onlyShownMaps or dataProvider:GetMap():IsShown() then
			dataProvider:RefreshAllData(fromOnShow)
		end
	end
end

---@param questID number
function addon:RemoveQuestPois(questID)
	local removed = 0

	for i = #ns.QUESTS, 1, -1 do
		local quest = ns.QUESTS[i]

		if quest.quest == questID then
			removed = removed + 1
			table.remove(ns.QUESTS, i)
		end
	end

	return removed > 0
end

---@param name CandyBucketsModuleName
function addon:CanLoadModule(name)
	return type(ns.modules[name]) == "table" and ns.modules[name].loaded ~= true
end

---@param name CandyBucketsModuleName
function addon:CanUnloadModule(name)
	return type(ns.modules[name]) == "table" and ns.modules[name].loaded == true
end

---@param name CandyBucketsModuleName
function addon:LoadModule(name)
	local module = ns.modules[name]
	module.loaded = true

	local i = #ns.QUESTS
	for j = 1, #module.quests do
		local quest = module.quests[j]

		if (not quest.side or quest.side == 3 or quest.side == ns.FACTION or DEBUG_FACTION) and not ns.COMPLETED_QUESTS[quest.quest] then
			quest.module = module
			i = i + 1
			ns.QUESTS[i] = quest
		end
	end

	addon:RefreshAllWorldMaps(true)
end

---@param name CandyBucketsModuleName
function addon:UnloadModule(name)
	local module = ns.modules[name]
	module.loaded = false

	for i = #ns.QUESTS, 1, -1 do
		local quest = ns.QUESTS[i]

		if quest.module.event == name then
			table.remove(ns.QUESTS, i)
		end
	end

	addon:RefreshAllWorldMaps(true)
end

function addon:CheckCalendar()
	local curDate = C_DateAndTime.GetCurrentCalendarTime()
	local month, day, year = curDate.month, curDate.monthDay, curDate.year
	local curHour, curMinute = curDate.hour, curDate.minute

	local calDate = C_Calendar.GetMonthInfo()
	local monthOffset = -12 * (curDate.year - calDate.year) + calDate.month - curDate.month -- convert difference between calendar and the realm time

	if monthOffset ~= 0 then
		return -- we only care about the current events, so we need the view to be on the current month (otherwise we unload the ongoing events if we change the month manually...)
	end

	local numEvents = C_Calendar.GetNumDayEvents(monthOffset, day)
	local loadedEvents, numLoaded, numLoadedRightNow = {}, 0, 0

	for i = 1, numEvents do
		local event = C_Calendar.GetDayEvent(monthOffset, day, i)

		if event and event.calendarType == "HOLIDAY" then
			local ongoing = event.sequenceType == "ONGOING" -- or event.sequenceType == "INFO"
			local moduleName = MODULE_FROM_TEXTURE[event.iconTexture]

			if event.sequenceType == "START" then
				ongoing = curHour >= event.startTime.hour and (curHour > event.startTime.hour or curMinute >= event.startTime.minute)
			elseif event.sequenceType == "END" then
				ongoing = curHour <= event.endTime.hour and (curHour < event.endTime.hour or curMinute <= event.endTime.minute)
				-- TODO: linger for 12 hours extra just in case event is active but not in the calendar due to timezone differences
				if not ongoing then
					local paddingHour = max(0, curHour - 12)
					ongoing = paddingHour <= event.endTime.hour and (paddingHour < event.endTime.hour or curMinute <= event.endTime.minute)
				end
			end

			if ongoing and addon:CanLoadModule(moduleName) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF" .. addonName .. "|r has loaded the module for |cffFFFFFF" .. event.title .. "|r!", 1, 1, 0)
				addon:LoadModule(moduleName)
				numLoadedRightNow = numLoadedRightNow + 1
			elseif not ongoing and addon:CanUnloadModule(moduleName) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF" .. addonName .. "|r has unloaded the module for |cffFFFFFF" .. event.title .. "|r because the event has ended.", 1, 1, 0)
				addon:UnloadModule(moduleName)
			end

			if moduleName and ongoing then
				loadedEvents[moduleName] = true
			end
		end
	end

	if DEBUG_MODULE then
		for name, module in pairs(ns.modules) do
			if addon:CanLoadModule(name) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF" .. addonName .. "|r has loaded the module for |cffFFFFFF[DEBUG] " .. name .. "|r!", 1, 1, 0)
				addon:LoadModule(name)
				numLoadedRightNow = numLoadedRightNow + 1
			end
			loadedEvents[name] = true
		end
	end

	for name, module in pairs(ns.modules) do
		if addon:CanUnloadModule(name) and not loadedEvents[name] then
			DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF" .. addonName .. "|r couldn't find |cffFFFFFF" .. name .. "|r in the calendar so we consider the event expired.", 1, 1, 0)
			addon:UnloadModule(name)
		end
	end

	for name, module in pairs(ns.modules) do
		if addon:CanUnloadModule(name) then
			numLoaded = numLoaded + 1
		end
	end

	if numLoaded > 0 then
		addon:RegisterEvent("QUEST_TURNED_IN")
	else
		addon:UnregisterEvent("QUEST_TURNED_IN")
	end

	if numLoadedRightNow > 0 then
		DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF" .. addonName .. "|r has |cffFFFFFF" .. #ns.QUESTS .. "|r locations for you to visit.", 1, 1, 0)
	end
end

---@param check? boolean
function addon:QueryCalendar(check)
	local function DelayedUpdate()
		if type(CalendarFrame) ~= "table" or not CalendarFrame:IsShown() then
			local curDate = C_DateAndTime.GetCurrentCalendarTime()
			C_Calendar.SetAbsMonth(curDate.month, curDate.year)
			C_Calendar.OpenCalendar()
		end
	end

	addon:RegisterEvent("CALENDAR_UPDATE_EVENT")
	addon:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	addon:RegisterEvent("INITIAL_CLUBS_LOADED")
	addon:RegisterEvent("GUILD_ROSTER_UPDATE")
	addon:RegisterEvent("PLAYER_GUILD_UPDATE")
	addon:RegisterEvent("PLAYER_ENTERING_WORLD")

	DelayedUpdate()
	C_Timer.After(10, DelayedUpdate)

	if check then
		addon:CheckCalendar()
	end
end

---@param questID number
---@return boolean? success, CandyBucketsEvalPositionQuestInfo? info, number? poiCount
function addon:IsDeliveryLocationExpected(questID)
	local questCollection = {} ---@type CandyBucketsEvalPositionQuestInfo[]
	local questName ---@type string?

	for i = 1, #ns.QUESTS do
		local quest = ns.QUESTS[i]
		if quest.quest == questID then
			table.insert(questCollection, quest)
		end
	end

	if not questCollection[1] then
		questName = C_QuestLog.GetTitleForQuestID(questID)

		if questName then
			local missingFromModule ---@type CandyBucketsModule?

			for _, module in pairs(ns.modules) do
				if module.loaded == true then
					for _, pattern in pairs(module.patterns) do
						if questName:match(pattern) then
							missingFromModule = module
							break
						end
					end
					if missingFromModule then
						break
					end
				end
			end

			if missingFromModule then
				table.insert(questCollection, { missing = true, module = missingFromModule, quest = questID, side = 3 })
			end
		end
	end

	if not questCollection[1] then
		return nil, DEBUG_LOCATION and { error = "Quest not part of any module.", name = questName } or nil, nil
	end

	local uiMapID, pos = GetPlayerMapAndPosition()
	if not uiMapID then
		return nil, DEBUG_LOCATION and { error = "Player has no uiMapID." } or nil, nil
	elseif not pos then
		return nil, DEBUG_LOCATION and { error = "Player is on map " .. uiMapID .. " but not coordinates." } or nil, nil
	end

	if questCollection[1].missing then
		for i = 1, #questCollection do
			questCollection[i][uiMapID] = { pos.x * 100, pos.y * 100 }
		end
	end

	local returnCount = 0
	local returns = {} ---@type CandyBucketsEvalPositionRetInfo[]

	for i = 1, #questCollection do
		local quest = questCollection[i]
		local qpos = quest[uiMapID] ---@type CandyBucketsMapPosition

		local ret = {} ---@type CandyBucketsEvalPositionRetInfo
		returnCount = returnCount + 1
		returns[returnCount] = ret

		repeat
			if type(qpos) == "table" then
				local distance = quest.missing and 1 or 0

				if not quest.missing then
					local dx = qpos[1]/100 - pos.x
					local dy = qpos[2]/100 - pos.y

					local dd = dx*dx + dy*dy
					if dd < 0 then
						ret.has, ret.success, ret.data = true, nil, DEBUG_LOCATION and { error = "Distance calculated is negative. Can't sqrt negative numbers." } or nil
						break
					end

					distance = sqrt(dd)
				end

				local mapWidth, mapHeight = C_Map.GetMapWorldSize(uiMapID)
				local mapSize = min(mapWidth, mapHeight)
				local mapScale = mapSize > 0 and 100/mapSize or 0
				local warnDistanceForMap = mapScale > 0 and mapScale or 0.05 -- we convert the actual map size into the same scale as we use for the distance - fallback to 0.05 if we're missing data

				if distance > warnDistanceForMap then
					ret.has, ret.success, ret.data = true, false, { quest = quest, uiMapID = uiMapID, x = pos.x, y = pos.y, distance = distance }
				elseif DEBUG_LOCATION then
					ret.has, ret.success, ret.data = true, true, { success = "Player turned in quest at an acceptable distance.", quest = quest, uiMapID = uiMapID, x = pos.x, y = pos.y, distance = distance }
				else
					ret.has, ret.success = true, true
				end

			elseif not quest.missing then
				ret.has, ret.success, ret.data = true, false, { quest = quest, uiMapID = uiMapID, x = pos.x, y = pos.y, distance = 1 }
			end
		until true
	end

	for i = 1, returnCount do
		local ret = returns[i]
		if ret.has and ret.success then
			return ret.success, ret.data, returnCount
		end
	end

	for i = 1, returnCount do
		local ret = returns[i]
		if ret.has then
			return ret.success, ret.data, returnCount
		end
	end

	return true, DEBUG_LOCATION and { warning = "Player is not on appropriate map for this quest and can't calculate distance." } or nil, returnCount
end

function addon:CanUseAddonLinks()
	local _, _, _, build = GetBuildInfo()
	return build >= 100100
end

---@param entry string
function addon:CreateAddonCopyLink(entry)
	return format("|cFFFF5555|Haddon:%s:%s|h[Click here to copy this message]|h|r", addonName, entry)
end

---@param text string
function addon:ShowCopyDialog(text)
	local key = format("%s Copy Dialog", addonName)

	if not StaticPopupDialogs[key] then
		StaticPopupDialogs[key] = {
			text = "",
			button1 = "",
			-- button2 = "",
			hasEditBox = 1,
			OnShow = function(self, data)
				if data.text_arg1 ~= nil then
					self.text:SetFormattedText(data.text, data.text_arg1, data.text_arg2)
				else
					self.text:SetText(data.text)
				end
				if data.acceptText ~= false then
					self.button1:SetText(data.acceptText or DONE)
				else
					self.button1:Hide()
				end
				if data.cancelText ~= false then
					self.button2:SetText(data.cancelText or CANCEL)
				else
					self.button2:Hide()
				end
				self.editBox:SetMaxLetters(data.maxLetters or 255)
				self.editBox:SetCountInvisibleLetters(not not data.countInvisibleLetters)
				if data.editBox then
					self.editBox:SetText(data.editBox)
					self.editBox:HighlightText()
				end
			end,
			OnAccept = function(self, data)
				if data.callback then
					data.callback(self.editBox:GetText())
				end
			end,
			OnCancel = function(self, data)
				if data.cancelCallback then
					data.cancelCallback()
				end
			end,
			EditBoxOnEnterPressed = function(self, data)
				local parent = self:GetParent();
				if parent.button1:IsEnabled() then
					if data.callback then
						data.callback(parent.editBox:GetText())
					end
					parent:Hide()
				end
			end,
			EditBoxOnTextChanged = function(self)
				-- local parent = self:GetParent()
				-- parent.button1:SetEnabled(parent.editBox:GetText():trim() ~= "")
			end,
			EditBoxOnEscapePressed = function(self)
				self:GetParent():Hide()
			end,
			hideOnEscape = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
	end

	return StaticPopup_Show(key, nil, nil, {
		text = "The contents below contain the required information to update the quest with a more accurate location.",
		editBox = text,
		acceptText = CLOSE,
	})
end

-- hook `SetItemRef` if addon links are supported (and call `ShowCopyDialog` when the links are clicked)
if addon:CanUseAddonLinks() then
	local function HandleAddonLinkClick(link)
		local linkType, prefix, param1 = strsplit(":", link, 3)
		if linkType ~= "addon" or prefix ~= addonName then
			return
		end
		addon:ShowCopyDialog(param1)
	end

	hooksecurefunc("SetItemRef", HandleAddonLinkClick)
end

--
-- Events
--

function addon:ADDON_LOADED(event, name)
	if name == addonName then
		addon:UnregisterEvent(event)
		InjectDataProvider()
	end
end

function addon:PLAYER_LOGIN(event)
	addon:UnregisterEvent(event)

	local faction = UnitFactionGroup("player")
	if faction == "Alliance" then
		ns.FACTION = 1
	elseif faction == "Horde" then
		ns.FACTION = 2
	else
		ns.FACTION = 3
	end

	for _, id in ipairs(C_QuestLog.GetAllCompletedQuestIDs()) do
		ns.COMPLETED_QUESTS[id] = true
	end

	addon:QueryCalendar(true)
end

function addon:CALENDAR_UPDATE_EVENT()
	addon:CheckCalendar()
end

function addon:CALENDAR_UPDATE_EVENT_LIST()
	addon:CheckCalendar()
end

function addon:INITIAL_CLUBS_LOADED()
	addon:CheckCalendar()
end

function addon:GUILD_ROSTER_UPDATE()
	addon:CheckCalendar()
end

function addon:PLAYER_GUILD_UPDATE()
	addon:CheckCalendar()
end

function addon:PLAYER_ENTERING_WORLD()
	addon:CheckCalendar()
end

function addon:QUEST_TURNED_IN(event, questID)
	ns.COMPLETED_QUESTS[questID] = true

	local success, info, checkedNumQuestPOIs = addon:IsDeliveryLocationExpected(questID)
	if DEBUG_LOCATION then
		DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF" .. addonName .. "|r quest |cffFFFFFF" .. questID .. "|r turned in" .. (info and ":" or "."), 1, 1, 0)
		if info then
			if info.error then
				DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000Error!|r |cffFFFFFF" .. tostring(info.error) .. "|r", 1, 1, 0)
			end
			if info.warning then
				DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Warning!|r |cffFFFFFF" .. tostring(info.warning) .. "|r", 1, 1, 0)
			end
			if info.success then
				DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Success!|r |cffFFFFFF" .. tostring(info.success) .. "|r", 1, 1, 0)
			end
			if info.name then
				DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Quest|r: |cffFFFFFF" .. tostring(info.name) .. "|r", 1, 1, 0)
			end
			if info.distance then
				DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Distance|r: |cffFFFFFF" .. tostring(info.distance) .. "|r", 1, 1, 0)
			end
			if info.x and info.y then
				DEFAULT_CHAT_FRAME:AddMessage(format("|cffFFFFFFmxy|r = |cffFFFFFF%s|r @ |cffFFFFFF%.2f|r, |cffFFFFFF%.2f|r", info.uiMapID and tostring(info.uiMapID) or "?", info.x * 100, info.y * 100), 1, 1, 0)
			end
		end
	elseif success == false and info then
		local suffix = "Please screenshot this message and report it to the author."
		if addon:CanUseAddonLinks() then
			local entry = format("{ quest = %d, side = %d, [%d] = {%.2f, %.2f} }, -- %.2f, %s", questID, ns.FACTION, info.uiMapID, info.x * 100, info.y * 100, info.distance * 100, GetMinimapZoneText() or "N/A")
			local link = addon:CreateAddonCopyLink(entry)
			suffix = format("%s, then report it to the author.", link)
		end
		DEFAULT_CHAT_FRAME:AddMessage(format("|cffFFFFFF%s|r quest |cffFFFFFF%s#%d|r turned in at the wrong location. You were at |cffFFFFFF%d/%d/%.2f/%.2f|r roughly |cffFFFFFF%.2f|r units away from the expected %s. %s Thanks!", addonName, info.quest.module.event, questID, ns.FACTION, info.uiMapID, info.x * 100, info.y * 100, info.distance * 100, checkedNumQuestPOIs and checkedNumQuestPOIs > 1 and checkedNumQuestPOIs .. " locations" or "location", suffix), 1, 1, 0)
	end

	if addon:RemoveQuestPois(questID) then
		addon:RefreshAllWorldMaps(true)
	end
end
