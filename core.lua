local DEBUG = false

local _G = _G
local pairs = pairs
local type = type
local CalendarGetDate = CalendarGetDate
local CalendarGetMonth = CalendarGetMonth
local CalendarGetNumDayEvents = CalendarGetNumDayEvents
local CalendarSetAbsMonth = CalendarSetAbsMonth
local GetGameTime = GetGameTime

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
	addon:RegisterEvent("CALENDAR_UPDATE_EVENT")
	addon:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	addon:RegisterEvent("GUILD_ROSTER_UPDATE")
	addon:RegisterEvent("PLAYER_GUILD_UPDATE")

	if type(CalendarFrame) ~= "table" or not CalendarFrame:IsShown() then
		local _, month, _, year = CalendarGetDate()
		CalendarSetAbsMonth(month, year)
	end

	if check then
		addon:CheckCalendar()
	end
end

function addon:CheckCalendar()
	local curHour, curMinute = GetGameTime()
	local _, month, day, year = CalendarGetDate()
	local curMonth, curYear = CalendarGetMonth()
	local monthOffset = -12 * (curYear - year) + month - curMonth
	local numEvents = CalendarGetNumDayEvents(monthOffset, day)
	local loadedEvents = {}

	if monthOffset ~= 0 then
		return -- we only care about the current events, so we need the view to be on the current month (otherwise we unload the ongoing events if we change the month manually...)
	end

	for i = 1, numEvents do
		local event = C_Calendar.GetDayEvent(monthOffset, day, i)

		if event and event.calendarType == "HOLIDAY" then
			local ongoing = sequenceType == "ONGOING" or sequenceType == "INFO" -- TODO: INFO? DEPRECATED?
			local texture = ns:GetNormalizedHolidayTexture(event.iconTexture)

			if event.sequenceType == "START" then
				ongoing = curHour >= event.startTime.hour and (curHour > event.startTime.hour or curMinute >= event.startTime.minute)
			elseif event.sequenceType == "END" then
				ongoing = curHour <= event.endTime.hour and (curHour < event.endTime.hour or curMinute <= event.endTime.minute)
			end

			if ongoing and ns:CanLoadEvent(texture) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF" .. addonName .. "|r has loaded the module for |cffFFFFFF" .. event.title .. "|r!", 1, 1, 0)
				ns:LoadEvent(texture)
			elseif not ongoing and ns:CanUnloadEvent(texture) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF" .. addonName .. "|r has unloaded the module for |cffFFFFFF" .. event.title .. "|r because the event has ended.", 1, 1, 0)
				ns:UnloadEvent(texture)
			end

			if ongoing then
				loadedEvents[texture] = 1
			end
		end
	end

	if DEBUG then
		for texture, module in pairs(ns.modules) do
			if ns:CanLoadEvent(texture) then
				ns:LoadEvent(texture)
			end
			loadedEvents[texture] = 1
		end
	end

	for texture, module in pairs(ns.modules) do
		if module.loaded and not loadedEvents[texture] then
			DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF" .. addonName .. "|r couldn't find |cffFFFFFF" .. texture .. "|r in the calendar so we consider the event expired.", 1, 1, 0)
			ns:UnloadEvent(texture)
		end
	end

	local numLoaded = 0

	for _, module in pairs(ns.modules) do
		if module.loaded then
			numLoaded = numLoaded + 1
		end
	end

	if numLoaded > 0 then
		addon:RegisterEvent("WORLD_MAP_UPDATE")
		addon:RegisterEvent("QUEST_TURNED_IN")
	else
		addon:UnregisterEvent("WORLD_MAP_UPDATE")
		addon:UnregisterEvent("QUEST_TURNED_IN")
	end
end

function addon:CALENDAR_UPDATE_EVENT()
	addon:CheckCalendar()
end

function addon:CALENDAR_UPDATE_EVENT_LIST()
	addon:CheckCalendar()
end

function addon:GUILD_ROSTER_UPDATE()
	addon:CheckCalendar()
end

function addon:PLAYER_GUILD_UPDATE()
	addon:CheckCalendar()
end

function addon:QUEST_TURNED_IN(event, questID)
	ns:QuestCompleted(questID)
end

function addon:WORLD_MAP_UPDATE()
	ns:UpdateNodes()
end
