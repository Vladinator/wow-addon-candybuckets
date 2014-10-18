local _, ns = ...
ns.modules = {}
ns.widgets = {}
ns.quests = nil

local Astrolabe = DongleStub("Astrolabe-1.0")
local worldMapFrame = WorldMapButton

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
	if not ns.quests then
		ns.quests = GetQuestsCompleted()
	end
	return ns.quests[questID]
end

function ns:QuestCompleted(questID)
	for _, module in pairs(ns.modules) do
		if module.loaded then
			local node = module.nodes[questID]

			if node then
				ns:RemoveNode(node)

				module.nodes[questID] = nil
			end
		end
	end
end

function ns:UpdateNodes()
	local areaID, isContinent = GetCurrentMapAreaID() -- Astrolabe:GetCurrentPlayerPosition()

	for _, module in pairs(ns.modules) do
		if module.loaded then
			for quest, data in pairs(module.nodes) do
				if not ns:IsQuestCompleted(quest) then
					if isContinent or data.area == areaID then
						ns:CreateOrUpdateWidget(data, module)
					else
						ns:RemoveNode(data)
					end
				else
					ns:QuestCompleted(quest)
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

		widget.node = nil
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

		table.insert(ns.widgets, widget)
	end

	widget.node = node

	if module then
		widget.icon:SetTexture(module.texture)
	end

	widget:SetParent(worldMapFrame)
	Astrolabe:PlaceIconOnWorldMap(worldMapFrame, widget, node.area, node.level, node.x, node.y)

	-- TODO: minimap icons
	-- Astrolabe:PlaceIconOnMinimap(widget, node.area, node.level, node.x, node.y)
end

function ns:CreateWidget()
	local widget = CreateFrame("Frame")
	widget:Hide()
	widget:SetSize(16, 16)

	-- TODO: obscolete?
	widget:SetFrameStrata("FULLSCREEN")
	widget:SetFrameLevel(255)

	widget.icon = widget:CreateTexture(nil, "ARTWORK", 8)
	widget.icon:SetAllPoints()
	widget.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	widget.icon:SetTexCoord(.15, .85, .15, .85)

	widget.border = widget:CreateTexture(nil, "ARTWORK", 2)
	widget.border:SetPoint("TOPLEFT", -1, 1)
	widget.border:SetPoint("BOTTOMRIGHT", 1, -1)
	widget.border:SetTexture(0, 0, 0, 1)

	return widget
end
