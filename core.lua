local DEBUG = false

local _G = _G
local type = type
local pairs = pairs
local CalendarGetDate = CalendarGetDate
local CalendarGetDayEvent = CalendarGetDayEvent
local CalendarGetNumDayEvents = CalendarGetNumDayEvents
local CalendarSetAbsMonth = CalendarSetAbsMonth

local addonName, ns = ...
local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
addon:RegisterEvent("ADDON_LOADED")
addon:RegisterEvent("PLAYER_LOGIN")

function addon:ADDON_LOADED(event, name)
	if name == addonName then
		addon:UnregisterEvent(event)
		addon:QueryCalendar(true)
	end
end

function addon:PLAYER_LOGIN(event)
	addon:UnregisterEvent(event)
	addon:QueryCalendar(true)
end

function addon:QueryCalendar(check)
	addon:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")

	if type(CalendarFrame) ~= "table" or not CalendarFrame:IsShown() then
		local _, month, _, year = CalendarGetDate()
		CalendarSetAbsMonth(month, year)
	end

	if check then
		addon:CheckCalendar()
	end
end

function addon:CheckCalendar()
	local _, _, day = CalendarGetDate()
	local monthOffset = 0
	local numEvents = CalendarGetNumDayEvents(monthOffset, day)
	local numLoaded = 0

	for i = 1, numEvents, 1 do
		local _, _, _, calendarType, _, _, texture = CalendarGetDayEvent(monthOffset, day, i)

		if calendarType == "HOLIDAY" then
			if ns:CanLoadEvent(texture) then
				ns:LoadEvent(texture)

				numLoaded = numLoaded + 1
			end
		end
	end

	if DEBUG then
		for texture, module in pairs(ns.modules) do
			if ns:CanLoadEvent(texture) then
				ns:LoadEvent(texture)

				numLoaded = numLoaded + 1
			end
		end
	end

	if numLoaded > 0 then
		addon:RegisterEvent("WORLD_MAP_UPDATE")
		addon:RegisterEvent("QUEST_TURNED_IN")
	end
end

function addon:CALENDAR_UPDATE_EVENT_LIST()
	addon:CheckCalendar()
end

function addon:QUEST_TURNED_IN(event, questID)
	ns:QuestCompleted(questID)
end

function addon:WORLD_MAP_UPDATE()
	ns:UpdateNodes()
end
