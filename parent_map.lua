local _, ns = ...

local GetMapChildrenInfo = C_Map.GetMapChildrenInfo
local next = next

function MakeParentMap()
	local PARENT_MAP = {}
	local queue = {
		[12] = true, -- Kalimdor
		[13] = true, -- Eastern Kingdoms
		[101] = true, -- Outland
		[113] = true, -- Northrend
		[127] = true, -- Crystalsong Forest
		[203] = true, -- Vashj'ir
		[224] = true, -- Stranglethorn Vale
		[390] = true, -- Vale of Eternal Blossoms
		[424] = true, -- Pandaria
		[572] = true, -- Draenor
		[619] = true, -- Broken Isles
		[862] = true, -- Zuldazar
		[875] = true, -- Zandalar
		[876] = true, -- Kul Tiras
		[895] = true, -- Tiragarde Sound
		[947] = true, -- Azeroth
		[948] = true, -- The Maelstrom
		[1165] = true, -- Dazar'alor
		[1550] = true, -- The Shadowlands
		[1978] = true, -- Dragon Isles
		[2274] = true, -- Khaz Algar
	}
	local seen = {}

	local currentParent = next(queue)
	local noFilter = nil
	local recursive = true
	while currentParent do
		if not PARENT_MAP[currentParent] then PARENT_MAP[currentParent] = { [currentParent] = true } end
		local children = GetMapChildrenInfo(currentParent, noFilter, recursive)
		for idx = 1, #children do
			local child = children[idx]
			local mapID = child.mapID
			local parentMapID = child.parentMapID

			if not seen[mapID] then queue[mapID] = true seen[mapID] = true end
			if (parentMapID and parentMapID ~= 0) and not seen[parentMapID] then queue[parentMapID] = true seen[parentMapID] = true end

			PARENT_MAP[currentParent][mapID] = true
		end

		queue[currentParent] = nil
		currentParent = next(queue)
	end

	PARENT_MAP[108][111] = true -- Terokkar Forest -> Shattrath City
	PARENT_MAP[539][582] = true -- Shadowmoon Valley -> Lunarfall
	PARENT_MAP[525][590] = true -- Frostfire Ridge -> Frostwall
	PARENT_MAP[1978][2151] = true -- Dragon Isles -> The Forbidden Reach
	PARENT_MAP[947][2151] = true -- Azeroth -> The Forbidden Reach

	ns.PARENT_MAP = PARENT_MAP
end

MakeParentMap()