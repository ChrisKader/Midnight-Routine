local FONT_HEADERS = MR_FONT_HEADERS
local FONT_ROWS    = MR_FONT_ROWS

local gatheringLocationsFrame
local gatheringMinimized = false

local DEFAULT_W = 350
local DEFAULT_H = 450
local MIN_W = 250
local MAX_W = 700
local MIN_H = 150
local MAX_H = 800
local TITLE_H = 24
local OUTER_PAD = 6

local PROFESSIONS = {
    {
        key        = "tailoring",
        label      = "Tailoring",
        color      = { 1.0, 0.67, 0.87 },
        hex        = "ffaadd",
        skillLine  = 2918,
        items = {
            { zone = 2393, x = 47.8, y = 51.8, name = "Pristine Potion" },
            { zone = 2393, x = 49.1, y = 75.8, name = "Freshly Plucked Peacebloom" },
            { zone = 2437, x = 40.4, y = 51.1, name = "Vial of Zul'Aman Oddities" },
            { zone = 2536, x = 49.1, y = 23.6, name = "Measured Ladle" },
            { zone = 2413, x = 34.8, y = 24.7, name = "Vial of Rootlands Oddities" },
            { zone = 2444, x = 41.9, y = 40.6, name = "Vial of Voidstorm Oddities" },
            { zone = 2405, x = 32.8, y = 43.3, name = "Failed Experiment" },
        },
    },
    {
        key        = "alchemy",
        label      = "Alchemy",
        color      = { 0.2, 0.73, 1.0 },
        hex        = "33bbff",
        skillLine  = 2906,
        items = {
            { zone = 2393, x = 47.8, y = 51.8, name = "Pristine Potion" },
            { zone = 2393, x = 49.1, y = 75.8, name = "Freshly Plucked Peacebloom" },
            { zone = 2437, x = 40.4, y = 51.1, name = "Vial of Zul'Aman Oddities" },
            { zone = 2536, x = 49.1, y = 23.6, name = "Measured Ladle" },
            { zone = 2413, x = 34.8, y = 24.7, name = "Vial of Rootlands Oddities" },
            { zone = 2444, x = 41.9, y = 40.6, name = "Vial of Voidstorm Oddities" },
            { zone = 2405, x = 32.8, y = 43.3, name = "Failed Experiment" },
        },
    },
    {
        key        = "blacksmithing",
        label      = "Blacksmithing",
        color      = { 0.67, 0.67, 0.73 },
        hex        = "aaaaaa",
        skillLine  = 2907,
        items = {
            { zone = 2393, x = 49.2, y = 61.3, name = "Sin'dorei Master's Forgemace" },
            { zone = 2393, x = 48.5, y = 74.7, name = "Silvermoon Blacksmith's Hammer" },
            { zone = 2393, x = 26.9, y = 60.3, name = "Deconstructed Forge Techniques" },
            { zone = 2395, x = 56.8, y = 40.8, name = "Metalworking Cheat Sheet" },
            { zone = 2395, x = 48.3, y = 75.8, name = "Silvermoon Smithing Kit" },
            { zone = 2536, x = 33.2, y = 65.9, name = "Carefully Racked Spear" },
            { zone = 2413, x = 66.3, y = 50.9, name = "Rutaani Floratender's Sword" },
            { zone = 2444, x = 30.6, y = 69.0, name = "Voidstorm Defense Spear" },
        },
    },
    {
        key        = "enchanting",
        label      = "Enchanting",
        color      = { 0.73, 0.47, 1.0 },
        hex        = "bb77ff",
        skillLine  = 2909,
        items = {
            { zone = 2395, x = 63.5, y = 32.6, name = "Sin'dorei Enchanting Rod" },
            { zone = 2395, x = 60.8, y = 53.0, name = "Everblazing Sunmote" },
            { zone = 2437, x = 40.4, y = 51.1, name = "Loa-Blessed Dust" },
            { zone = 2536, x = 48.4, y = 22.9, name = "Enchanted Amani Mask" },
            { zone = 2413, x = 65.8, y = 50.2, name = "Primal Essence Orb" },
            { zone = 2413, x = 37.7, y = 65.3, name = "Entropic Shard" },
            { zone = 2405, x = 35.5, y = 58.8, name = "Pure Void Crystal" },
        },
    },
    {
        key        = "engineering",
        label      = "Engineering",
        color      = { 1.0, 0.8, 0.27 },
        hex        = "ffcc44",
        skillLine  = 2910,
        items = {
            { zone = 2393, x = 51.2, y = 74.6, name = "One Engineer's Junk" },
            { zone = 2393, x = 51.3, y = 57.0, name = "What To Do When Nothing Works" },
            { zone = 2395, x = 39.6, y = 45.8, name = "Manual of Mistakes and Mishaps" },
            { zone = 2536, x = 65.3, y = 35.0, name = "Offline Helper Bot" },
            { zone = 2437, x = 34.2, y = 87.8, name = "Handy Wrench" },
            { zone = 2413, x = 68.0, y = 49.8, name = "Expeditious Pylon" },
            { zone = 2444, x = 54.1, y = 51.1, name = "Ethereal Stormwrench" },
            { zone = 2444, x = 28.9, y = 39.1, name = "Miniaturized Transport Skiff" },
        },
    },
    {
        key        = "inscription",
        label      = "Inscription",
        color      = { 0.27, 0.87, 0.67 },
        hex        = "44ddaa",
        skillLine  = 2913,
        items = {
            { zone = 2393, x = 51.2, y = 74.6, name = "One Engineer's Junk" },
            { zone = 2393, x = 51.3, y = 57.0, name = "What To Do When Nothing Works" },
            { zone = 2395, x = 39.6, y = 45.8, name = "Manual of Mistakes and Mishaps" },
            { zone = 2536, x = 65.3, y = 35.0, name = "Offline Helper Bot" },
            { zone = 2437, x = 34.2, y = 87.8, name = "Handy Wrench" },
            { zone = 2413, x = 68.0, y = 49.8, name = "Expeditious Pylon" },
            { zone = 2444, x = 54.1, y = 51.1, name = "Ethereal Stormwrench" },
            { zone = 2444, x = 28.9, y = 39.1, name = "Miniaturized Transport Skiff" },
        },
    },
    {
        key        = "jewelcrafting",
        label      = "Jewelcrafting",
        color      = { 1.0, 0.47, 0.60 },
        hex        = "ff7799",
        skillLine  = 2914,
        items = {
            { zone = 2393, x = 50.6, y = 56.6, name = "Sin'dorei Masterwork Chisel" },
            { zone = 2393, x = 55.4, y = 48.0, name = "Vintage Soul Gem" },
            { zone = 2395, x = 56.6, y = 40.9, name = "Poorly Rounded Vial" },
            { zone = 2395, x = 39.6, y = 38.9, name = "Sin'dorei Gem Faceters" },
            { zone = 2444, x = 30.5, y = 69.1, name = "Speculative Voidstorm Crystal" },
            { zone = 2444, x = 54.2, y = 51.2, name = "Ethereal Gem Pliers" },
            { zone = 2444, x = 62.7, y = 53.4, name = "Shattered Glass" },
            { zone = 2393, x = 28.6, y = 46.5, name = "Dual-Function Magnifiers" },
        },
    },
    {
        key        = "leatherworking",
        label      = "Leatherworking",
        color      = { 0.8, 0.53, 0.2 },
        hex        = "cc8833",
        skillLine  = 2915,
        items = {
            { zone = 2393, x = 44.8, y = 56.2, name = "Artisan's Considered Order" },
            { zone = 2536, x = 45.4, y = 45.5, name = "Bundle of Tanner's Trinkets" },
            { zone = 2437, x = 33.1, y = 78.9, name = "Amani Leatherworker's Tool" },
            { zone = 2437, x = 30.8, y = 84.0, name = "Prestigiously Racked Hide" },
            { zone = 2405, x = 34.7, y = 57.0, name = "Ethereal Leatherworking Knife" },
            { zone = 2413, x = 51.7, y = 51.3, name = "Haranir Leatherworking Mallet" },
            { zone = 2413, x = 36.1, y = 25.2, name = "Haranir Leatherworking Knife" },
            { zone = 2444, x = 53.7, y = 51.7, name = "Patterns: Beyond the Void" },
        },
    },
    {
        key        = "herbalism",
        label      = "Herbalism",
        color      = { 0.33, 0.8, 0.27 },
        hex        = "55cc44",
        skillLine  = 2912,
        items = {
            { zone = 2393, x = 49.0, y = 75.9, name = "Simple Leaf Pruners" },
            { zone = 2395, x = 64.2, y = 30.5, name = "A Spade" },
            { zone = 2437, x = 41.9, y = 45.9, name = "Harvester's Sickle (ZA)" },
            { zone = 2413, x = 51.1, y = 55.7, name = "Planting Shovel" },
            { zone = 2413, x = 38.3, y = 66.9, name = "Bloomed Bud" },
            { zone = 2413, x = 36.6, y = 25.1, name = "Lightbloom Root" },
            { zone = 2413, x = 76.1, y = 51.1, name = "Harvester's Sickle" },
            { zone = 2405, x = 34.7, y = 57.0, name = "Peculiar Lotus" },
        },
    },
    {
        key        = "mining",
        label      = "Mining",
        color      = { 0.8, 0.8, 0.8 },
        hex        = "cccccc",
        skillLine  = 2916,
        items = {
            { zone = 2395, x = 38.0, y = 45.4, name = "Solid Ore Punchers" },
            { zone = 2536, x = 33.4, y = 65.9, name = "Amani Expert's Chisel" },
            { zone = 2437, x = 42.0, y = 46.5, name = "Spelunker's Lucky Charm" },
            { zone = 2413, x = 38.8, y = 65.9, name = "Spare Expedition Torch" },
            { zone = 2405, x = 41.8, y = 38.3, name = "Star Metal Deposit" },
            { zone = 2444, x = 30.5, y = 69.1, name = "Miner's Guide to Voidstorm" },
            { zone = 2444, x = 28.7, y = 38.5, name = "Glimmering Void Pearl" },
            { zone = 2444, x = 54.2, y = 51.5, name = "Lost Voidstorm Satchel" },
        },
    },
    {
        key        = "skinning",
        label      = "Skinning",
        color      = { 0.78, 0.63, 0.38 },
        hex        = "c8a060",
        skillLine  = 2917,
        items = {
            { zone = 2393, x = 43.2, y = 55.7, name = "Sin'dorei Tanning Oil" },
            { zone = 2395, x = 48.4, y = 76.3, name = "Thalassian Skinning Knife" },
            { zone = 2536, x = 44.9, y = 45.2, name = "Cadre Skinning Knife" },
            { zone = 2437, x = 33.1, y = 79.1, name = "Amani Skinning Knife" },
            { zone = 2437, x = 40.4, y = 36.0, name = "Amani Tanning Oil" },
            { zone = 2413, x = 69.5, y = 49.2, name = "Primal Hide" },
            { zone = 2413, x = 76.0, y = 51.0, name = "Lightbloom Afflicted Hide" },
            { zone = 2444, x = 45.5, y = 42.3, name = "Voidstorm Leather Sample" },
        },
    },
}

local PROF_KEY_TO_NAME = {
    tailoring = "Tailoring",
    alchemy = "Alchemy",
    blacksmithing = "Blacksmithing",
    enchanting = "Enchanting",
    engineering = "Engineering",
    inscription = "Inscription",
    jewelcrafting = "Jewelcrafting",
    leatherworking = "Leatherworking",
    herbalism = "Herbalism",
    mining = "Mining",
    skinning = "Skinning",
}

local function HasProfessionLearned(skillLine)
    return MR.playerProfessions and MR.playerProfessions[skillLine] or false
end

local gatheringCfgFrame
local PopulateGatheringConfig
local RebuildGatheringLocationsFrame

local function GetProfessionColor(profession)
    local colors = MR.db.profile.gatheringProfColors or {}
    local profColors = colors[profession]
    if profColors then
        return profColors[1], profColors[2], profColors[3]
    end
    for _, prof in ipairs(PROFESSIONS) do
        if prof.key == profession then
            return prof.color[1], prof.color[2], prof.color[3]
        end
    end
    return 1, 1, 1
end

local _zoneNameCache = {}
local function GetGatheringZoneName(mapID)
    if not mapID then return "Unknown" end
    if _zoneNameCache[mapID] then return _zoneNameCache[mapID] end
    local mapInfo = C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(mapID)
    local zoneName = (mapInfo and mapInfo.name) or ("Map " .. tostring(mapID))
    _zoneNameCache[mapID] = zoneName
    return zoneName
end

local function SetGatheringWaypoint(item)
    local mapID = item and item.zone
    local x = item and item.x and (item.x / 100)
    local y = item and item.y and (item.y / 100)
    local tomTom = _G and rawget(_G, "TomTom")
    if not mapID or not x or not y then
        return false, "Invalid coordinates"
    end

    if tomTom and tomTom.AddWaypoint then
        local ok = pcall(function()
            tomTom:AddWaypoint(mapID, x, y, {
                title = item.name or "Gathering",
                persistent = false,
                minimap = true,
                world = true,
            })
        end)
        if ok then return true, "TomTom" end
    end

    if UiMapPoint and UiMapPoint.CreateFromCoordinates and C_Map and C_Map.SetUserWaypoint then
        local point = UiMapPoint.CreateFromCoordinates(mapID, x, y)
        if point then
            C_Map.SetUserWaypoint(point)
            if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
                C_SuperTrack.SetSuperTrackedUserWaypoint(true)
            end
            return true, "Blizzard"
        end
    end

    return false, "No waypoint API available"
end

local function BuildGatheringLocationsFrame()
    local db     = MR.db and MR.db.profile or {}
    local hadProfCache = MR.playerProfessions and next(MR.playerProfessions) ~= nil
    if not hadProfCache and MR.RefreshPlayerProfessions then
        MR:RefreshPlayerProfessions()
    end
    local hasProfCache = MR.playerProfessions and next(MR.playerProfessions) ~= nil
    local alpha  = db.gatheringAlpha or 1.0
    local W      = db.gatheringWidth or DEFAULT_W
    local H      = db.gatheringHeight or DEFAULT_H
    local minimized = db.gatheringMinimized or false
    gatheringMinimized = minimized

    local f = MR_StyledFrame(UIParent, "MRGatheringLocationsFrame", "MEDIUM", 10)
    f:SetSize(W, minimized and TITLE_H or H)
    f:SetBackdropColor(0.03, 0.05, 0.08, 0.97 * alpha)
    f:SetBackdropBorderColor(0.22, 0.18, 0.28, alpha)
    MR_RestoreFramePos(f, "gatheringLocPos", 860, 0)

    f.leftAccent = MR_LeftAccent(f, 0.80, 0.53, 0.20)
    f.topAccent  = MR_TopAccent(f,  0.80, 0.53, 0.20)
    if f.leftAccent then f.leftAccent:SetAlpha(alpha) end
    if f.topAccent  then f.topAccent:SetAlpha(alpha)  end

    local titleBar = MR_TitleBar(f, TITLE_H)
    f.titleBar = titleBar
    titleBar:SetBackdropColor(0, 0, 0, 0)
    titleBar:SetScript("OnDragStart", function() if not db.gatheringLocked then f:StartMoving() end end)
    titleBar:SetScript("OnDragStop", function()
        f:StopMovingOrSizing()
        local pt, _, rp, x, y = f:GetPoint()
        if MR.db then MR.db.profile.gatheringLocPos = { point = pt, relPoint = rp, x = x, y = y } end
    end)

    local titleIcon = titleBar:CreateTexture(nil, "ARTWORK")
    titleIcon:SetSize(14, 14)
    titleIcon:SetPoint("LEFT", titleBar, "LEFT", 8, 0)
    titleIcon:SetTexture("Interface\\AddOns\\MidnightRoutine\\Media\\Icon")
    titleIcon:SetVertexColor(0.80, 0.53, 0.20, 1)

    local closeBtn = MR_CloseButton(titleBar, function()
        f:Hide()
        if MR.db then MR.db.profile.gatheringLocOpen = false end
    end)

    local gearBtn = CreateFrame("Button", nil, titleBar)
    gearBtn:SetSize(14, 14)
    gearBtn:SetPoint("RIGHT", closeBtn, "LEFT", -4, 0)
    local gearTex = gearBtn:CreateTexture(nil, "ARTWORK")
    gearTex:SetAllPoints()
    gearTex:SetTexture("Interface\\Buttons\\UI-OptionsButton")
    gearTex:SetVertexColor(0.80, 0.53, 0.20, 1)
    gearBtn:SetNormalTexture(gearTex)
    local gearHL = gearBtn:CreateTexture(nil, "HIGHLIGHT")
    gearHL:SetAllPoints()
    gearHL:SetTexture("Interface\\Buttons\\UI-OptionsButton")
    gearHL:SetVertexColor(1, 1, 1, 1)
    gearBtn:SetHighlightTexture(gearHL)
    gearBtn:SetScript("OnEnter",  function()
        gearTex:SetVertexColor(1, 0.82, 0.40, 1)
        GameTooltip:SetOwner(gearBtn, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Gathering Options", 1, 1, 1)
        GameTooltip:Show()
    end)
    gearBtn:SetScript("OnLeave",  function()
        gearTex:SetVertexColor(0.80, 0.53, 0.20, 1)
        GameTooltip:Hide()
    end)
    gearBtn:SetScript("OnClick", function()
        MR:ToggleGatheringLocationsConfig()
    end)

    local titleTxt = titleBar:CreateFontString(nil, "OVERLAY")
    titleTxt:SetFont(FONT_HEADERS, 10, "OUTLINE")
    titleTxt:SetPoint("LEFT",  titleIcon, "RIGHT", 5, 0)
    titleTxt:SetPoint("RIGHT", gearBtn, "LEFT", -48, 0)
    titleTxt:SetJustifyH("LEFT")
    titleTxt:SetText("|cffc9853fGathering Locations|r")

    local scroll = CreateFrame("ScrollFrame", nil, f)
    scroll:SetPoint("TOPLEFT",     titleBar, "BOTTOMLEFT",  0, -1)
    scroll:SetPoint("BOTTOMRIGHT", f,        "BOTTOMRIGHT", -8, 4)
    scroll:EnableMouseWheel(true)
    f._scroll = scroll

    local content = CreateFrame("Frame", nil, scroll)
    content:SetWidth(W - 8)
    content:SetHeight(1)
    scroll:SetScrollChild(content)
    f._content = content

    local track = CreateFrame("Frame", nil, f)
    track:SetPoint("TOPLEFT",    scroll, "TOPRIGHT",    1, 0)
    track:SetPoint("BOTTOMLEFT", scroll, "BOTTOMRIGHT", 1, 0)
    track:SetWidth(5)
    local trackBg = track:CreateTexture(nil, "BACKGROUND")
    trackBg:SetAllPoints()
    trackBg:SetColorTexture(0, 0, 0, 0.3)
    local thumb = track:CreateTexture(nil, "OVERLAY")
    thumb:SetWidth(5)
    thumb:SetColorTexture(0.80, 0.53, 0.20, 0.6)
    f._track = track
    f._thumb = thumb

    local function UpdateScrollBar()
        local viewH    = scroll:GetHeight()
        local contentH = content:GetHeight()
        if contentH <= viewH or viewH <= 0 then thumb:Hide(); return end
        thumb:Show()
        local trackH = math.max(track:GetHeight(), 1)
        local thumbH = math.max(trackH * (viewH / contentH), 14)
        local pct    = scroll:GetVerticalScroll() / math.max(contentH - viewH, 1)
        thumb:SetHeight(thumbH)
        thumb:ClearAllPoints()
        thumb:SetPoint("TOPLEFT", track, "TOPLEFT", 0, -((trackH - thumbH) * pct))
    end
    scroll:SetScript("OnMouseWheel",        function(_, d) scroll:SetVerticalScroll(math.max(0, math.min(scroll:GetVerticalScroll() - d * 30, math.max(content:GetHeight() - scroll:GetHeight(), 0)))); UpdateScrollBar() end)
    scroll:SetScript("OnScrollRangeChanged", function() UpdateScrollBar() end)
    scroll:SetScript("OnVerticalScroll",     function() UpdateScrollBar() end)
    f.UpdateScrollBar = UpdateScrollBar

    local minBtn = CreateFrame("Button", nil, titleBar, "BackdropTemplate")
    minBtn:SetSize(16, 16)
    minBtn:SetPoint("RIGHT", gearBtn, "LEFT", -4, 0)
    minBtn:SetBackdrop(MR_MakeBackdrop())
    minBtn:SetBackdropColor(0.06, 0.12, 0.22, 0.85)
    minBtn:SetBackdropBorderColor(0.15, 0.35, 0.40, 0.9)
    local minLbl = minBtn:CreateFontString(nil, "OVERLAY")
    minLbl:SetFont(FONT_HEADERS, 12, "OUTLINE")
    minLbl:SetPoint("CENTER", minBtn, "CENTER", 0, 1)
    minLbl:SetTextColor(0.25, 0.80, 0.68)
    
    local function UpdateMinBtn()
        minLbl:SetText(gatheringMinimized and "+" or "-")
    end
    UpdateMinBtn()
    
    minBtn:SetScript("OnEnter", function()
        minBtn:SetBackdropColor(0.06, 0.22, 0.28, 1)
        minBtn:SetBackdropBorderColor(0.20, 0.80, 0.65, 1)
        minLbl:SetTextColor(1, 1, 1)
        GameTooltip:SetOwner(minBtn, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Collapse", 1, 1, 1)
        GameTooltip:Show()
    end)
    minBtn:SetScript("OnLeave", function()
        minBtn:SetBackdropColor(0.06, 0.12, 0.22, 0.85)
        minBtn:SetBackdropBorderColor(0.15, 0.35, 0.40, 0.9)
        minLbl:SetTextColor(0.25, 0.80, 0.68)
        GameTooltip:Hide()
    end)

    local dragger
    minBtn:SetScript("OnClick", function()
        gatheringMinimized = not gatheringMinimized
        minimized = gatheringMinimized
        if MR.db then MR.db.profile.gatheringMinimized = gatheringMinimized end
        UpdateMinBtn()
        if gatheringMinimized then
            scroll:Hide()
            if dragger then dragger:Hide() end
            f:SetHeight(TITLE_H)
        else
            scroll:Show()
            if dragger then dragger:Show() end
            f:SetHeight(MR.db and MR.db.profile.gatheringHeight or DEFAULT_H)
            f.UpdateScrollBar()
        end
    end)

    local yOff = 0
    local fontName = FONT_ROWS
    local fontSize = db.gatheringFontSize or 9

    for _, prof in ipairs(PROFESSIONS) do
        if HasProfessionLearned(prof.skillLine) then
            local cr, cg, cb = GetProfessionColor(prof.key)
            local header = content:CreateFontString(nil, "OVERLAY")
            header:SetFont(fontName, fontSize + 2, "OUTLINE")
            header:SetPoint("TOPLEFT", content, "TOPLEFT", 8, -yOff)
            header:SetTextColor(cr, cg, cb, 1.0)
            header:SetText(prof.label .. " (" .. #prof.items .. ")")
            yOff = yOff + 20

            local rowHeight = math.max(fontSize + 6, 14)
            for _, item in ipairs(prof.items) do
                local row = CreateFrame("Button", nil, content)
                row:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOff)
                row:SetSize(W - 24, rowHeight)
                row:RegisterForClicks("LeftButtonUp")

                local hover = row:CreateTexture(nil, "BACKGROUND")
                hover:SetAllPoints()
                hover:SetColorTexture(cr, cg, cb, 0)

                local nameText = row:CreateFontString(nil, "OVERLAY")
                nameText:SetFont(fontName, fontSize - 1, nil)
                nameText:SetPoint("LEFT", row, "LEFT", 2, 0)
                nameText:SetPoint("RIGHT", row, "RIGHT", -126, 0)
                nameText:SetJustifyH("LEFT")
                nameText:SetText(item.name)
                nameText:SetTextColor(0.90, 0.90, 0.90)

                local coordText = row:CreateFontString(nil, "OVERLAY")
                coordText:SetFont(fontName, fontSize - 1, "OUTLINE")
                coordText:SetPoint("RIGHT", row, "RIGHT", -2, 0)
                coordText:SetWidth(122)
                coordText:SetJustifyH("RIGHT")
                coordText:SetText(string.format("%.1f, %.1f", item.x, item.y))
                coordText:SetTextColor(cr, cg, cb, 0.95)

                row:SetScript("OnEnter", function()
                    hover:SetColorTexture(cr, cg, cb, 0.10)
                    GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
                    GameTooltip:SetText(item.name, 1, 1, 1)
                    GameTooltip:AddLine(GetGatheringZoneName(item.zone), 0.8, 0.8, 0.8)
                    GameTooltip:AddLine(string.format("Coordinates: %.1f, %.1f", item.x, item.y), 0.7, 1, 0.9)
                    GameTooltip:AddLine("Left-click: set waypoint", 0.45, 0.85, 1)
                    GameTooltip:Show()
                end)
                row:SetScript("OnLeave", function()
                    hover:SetColorTexture(cr, cg, cb, 0)
                    GameTooltip:Hide()
                end)
                row:SetScript("OnClick", function()
                    local ok, source = SetGatheringWaypoint(item)
                    if ok then
                        print(string.format("|cff2ae7c6MidnightRoutine:|r Waypoint set via %s for %s (%.1f, %.1f)", source, item.name, item.x, item.y))
                    else
                        print("|cff2ae7c6MidnightRoutine:|r Unable to set waypoint. Install TomTom or enable Blizzard waypoints.")
                    end
                end)

                yOff = yOff + rowHeight + 1
            end
            yOff = yOff + 4
        end
    end

    if yOff == 0 then
        local emptyText = content:CreateFontString(nil, "OVERLAY")
        emptyText:SetFont(fontName, fontSize, "OUTLINE")
        emptyText:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -10)
        emptyText:SetPoint("TOPRIGHT", content, "TOPRIGHT", -10, -10)
        emptyText:SetJustifyH("LEFT")
        emptyText:SetTextColor(0.72, 0.72, 0.72, 0.95)
        if not hasProfCache then
            emptyText:SetText("Loading profession data...")
        else
            emptyText:SetText("No learned professions detected.")
        end
        yOff = 32

        if not hasProfCache and C_Timer then
            C_Timer.After(0.75, function()
                if gatheringLocationsFrame and gatheringLocationsFrame:IsShown() then
                    if MR.RefreshPlayerProfessions then MR:RefreshPlayerProfessions() end
                    gatheringLocationsFrame:Hide()
                    gatheringLocationsFrame = BuildGatheringLocationsFrame()
                end
            end)
        end
    end

    content:SetHeight(yOff)
    scroll:SetVerticalScroll(0)
    f.UpdateScrollBar()

    if not minimized then
        local savedH = db.gatheringHeight or DEFAULT_H
        local naturalH = TITLE_H + 1 + yOff + 6
        f:SetHeight(math.min(savedH, naturalH))
    end

    dragger = CreateFrame("Frame", nil, f)
    dragger:SetSize(12, 12)
    dragger:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
    dragger:SetFrameLevel(f:GetFrameLevel() + 10)
    dragger:EnableMouse(true)
    f._dragger = dragger

    local dTex = dragger:CreateTexture(nil, "OVERLAY")
    dTex:SetAllPoints()
    dTex:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    dragger:SetScript("OnEnter", function()
        if not db.gatheringLocked then
            dTex:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
        end
    end)
    dragger:SetScript("OnLeave", function()
        dTex:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    end)

    local dragStartW, dragStartH, dragStartX, dragStartY
    dragger:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" and not db.gatheringLocked then
            dragStartW  = f:GetWidth()
            dragStartH  = f:GetHeight()
            local scale = f:GetEffectiveScale()
            dragStartX, dragStartY = GetCursorPosition()
            dragStartX = dragStartX / scale
            dragStartY = dragStartY / scale
            dragger._dragging = true
        end
    end)
    dragger:SetScript("OnMouseUp", function(_, button)
        if button == "LeftButton" and dragger._dragging then
            dragger._dragging = false
            local newW = math.max(MIN_W, math.min(MAX_W, math.floor(f:GetWidth())))
            local newH = math.max(MIN_H, math.min(MAX_H, math.floor(f:GetHeight())))
            if MR.db then
                MR.db.profile.gatheringWidth  = newW
                MR.db.profile.gatheringHeight = newH
            end
            RebuildGatheringLocationsFrame()
            if gatheringCfgFrame and gatheringCfgFrame:IsShown() then
                PopulateGatheringConfig(gatheringCfgFrame)
            end
        end
    end)
    dragger:SetScript("OnUpdate", function()
        if not dragger._dragging then return end
        local cx, cy = GetCursorPosition()
        local scale  = f:GetEffectiveScale()
        cx = cx / scale;  cy = cy / scale
        f:SetWidth( math.max(MIN_W, math.min(MAX_W, dragStartW + (cx - dragStartX))))
        f:SetHeight(math.max(MIN_H, math.min(MAX_H, dragStartH + (dragStartY - cy))))
    end)

    if minimized then
        scroll:Hide()
        dragger:Hide()
        f:SetHeight(TITLE_H)
    end

    f:SetMovable(not db.gatheringLocked)
    f:SetScale(db.gatheringScale or 1.0)
    f:Show()
    return f
end

RebuildGatheringLocationsFrame = function()
    if gatheringLocationsFrame then gatheringLocationsFrame:Hide() end
    gatheringLocationsFrame = BuildGatheringLocationsFrame()
end

local function SetProfessionColor(profession, r, g, b)
    if not MR.db.profile.gatheringProfColors then
        MR.db.profile.gatheringProfColors = {}
    end
    MR.db.profile.gatheringProfColors[profession] = {r, g, b}
    RebuildGatheringLocationsFrame()
end

local function ResetProfessionColor(profession)
    if MR.db.profile.gatheringProfColors then
        MR.db.profile.gatheringProfColors[profession] = nil
    end
    RebuildGatheringLocationsFrame()
end

local function BuildGatheringConfigFrame()
    local f = CreateFrame("Frame", "MRGatheringConfigFrame", UIParent, "BackdropTemplate")
    f:SetWidth(224)
    f:SetFrameStrata("HIGH")
    f:SetFrameLevel(20)
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:SetBackdrop(MR_MakeBackdrop())
    f:SetBackdropColor(0.03, 0.05, 0.02, 0.98)
    f:SetBackdropBorderColor(0.50, 0.40, 0.16, 1)
    f:Hide()

    MR_TopAccent(f, 0.80, 0.53, 0.20)

    local tbar = MR_TitleBar(f, 22)
    tbar:SetBackdropColor(0.10, 0.08, 0.02, 1)
    tbar:SetScript("OnDragStart", function() f:StartMoving() end)
    tbar:SetScript("OnDragStop",  function() f:StopMovingOrSizing() end)

    local ttitle = tbar:CreateFontString(nil, "OVERLAY")
    ttitle:SetFont(FONT_HEADERS, 10, "OUTLINE")
    ttitle:SetText("|cffc9853fGathering Options|r")
    ttitle:SetPoint("LEFT", tbar, "LEFT", 8, 0)

    MR_CloseButton(tbar, function() f:Hide() end)
    f.body = nil
    return f
end

PopulateGatheringConfig = function(f)
    if f.body then
        f.body:EnableMouse(false)
        f.body:Hide()
        f.body:SetParent(UIParent)
        f.body = nil
    end

    local body = CreateFrame("Frame", nil, f)
    body:SetPoint("TOPLEFT",  f, "TOPLEFT",  0, 0)
    body:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
    f.body = body

    local db   = MR.db.profile
    if not db then db = {} end
    local yOff = -28
    local P    = 8

    local function Gap(h)      yOff = MR_OptionsGap(body, yOff, h) end
    local function Divider()   yOff = MR_OptionsDivider(body, yOff, P) end
    local function SecLabel(t) yOff = MR_OptionsSectionLabel(body, yOff, t, P) end
    local function Check(lbl, get, set, r, g, b)
        yOff = MR_OptionsCheckbox(body, yOff, lbl, get, set,
            r or 0.78, g or 0.78, b or 0.88, P,
            function() PopulateGatheringConfig(f) end)
    end
    local function Slider(lbl, mn, mx, st, get, set, r, g, b)
        yOff = MR_OptionsSlider(body, yOff, lbl, mn, mx, st, get, set, r, g, b, P)
    end
    local function Btn(lbl, fn) yOff = MR_OptionsBtn(body, yOff, lbl, fn, 184, P) end

    SecLabel("DISPLAY")
    Check("Lock Position",
        function() return db.gatheringLocked end,
        function(v)
            db.gatheringLocked = v
            if gatheringLocationsFrame then gatheringLocationsFrame:SetMovable(not v) end
        end)
        Check("Hide When Completed",
            function() return db.gatheringHideCompleted end,
            function(v)
                db.gatheringHideCompleted = v
                RebuildGatheringLocationsFrame()
            end)

    Gap(4); Divider()
    SecLabel("SIZE & OPACITY")
    Slider("WIDTH", MIN_W, MAX_W, 10,
        function() return db.gatheringWidth or DEFAULT_W end,
        function(v)
            db.gatheringWidth = math.floor(v / 10) * 10
            RebuildGatheringLocationsFrame()
        end,
        0.80, 0.53, 0.20)
    Slider("HEIGHT", MIN_H, MAX_H, 10,
        function() return db.gatheringHeight or DEFAULT_H end,
        function(v)
            db.gatheringHeight = math.floor(v / 10) * 10
            if gatheringLocationsFrame and not db.gatheringMinimized then
                gatheringLocationsFrame:SetHeight(db.gatheringHeight)
            end
        end,
        0.60, 0.80, 0.40)
    Slider("FONT SIZE", 7, 16, 1,
        function() return db.gatheringFontSize or 9 end,
        function(v) db.gatheringFontSize = math.floor(v); RebuildGatheringLocationsFrame() end,
        0.78, 0.55, 0.16)

    do
        local presets = { {"S", 8}, {"M", 9}, {"L", 11}, {"XL", 13} }
        local btnW    = 42
        for i, p in ipairs(presets) do
            local isActive = ((db.gatheringFontSize or 9) == p[2])
            local pb = CreateFrame("Button", nil, body, "BackdropTemplate")
            pb:SetSize(btnW - 2, 16)
            pb:SetPoint("TOPLEFT", body, "TOPLEFT", P + (i-1) * btnW, yOff - 2)
            pb:SetBackdrop(MR_MakeBackdrop())
            pb:SetBackdropColor(isActive and 0.12 or 0.05, isActive and 0.35 or 0.10, isActive and 0.32 or 0.18, 1)
            pb:SetBackdropBorderColor(isActive and 0.25 or 0.18, isActive and 0.85 or 0.40, isActive and 0.70 or 0.45, 1)
            local pfs = pb:CreateFontString(nil, "OVERLAY")
            pfs:SetFont(FONT_ROWS, 9, "OUTLINE")
            pfs:SetPoint("CENTER")
            pfs:SetText(p[1])
            pfs:SetTextColor(isActive and 0.2 or 0.6, isActive and 0.95 or 0.75, isActive and 0.75 or 0.65)
            pb:SetScript("OnClick", function()
                db.gatheringFontSize = p[2]
                RebuildGatheringLocationsFrame()
                PopulateGatheringConfig(f)
            end)
            pb:SetScript("OnEnter", function() pb:SetBackdropColor(0.10, 0.28, 0.28, 1); pb:SetBackdropBorderColor(0.25, 0.90, 0.75, 1) end)
            pb:SetScript("OnLeave", function()
                pb:SetBackdropColor(isActive and 0.12 or 0.05, isActive and 0.35 or 0.10, isActive and 0.32 or 0.18, 1)
                pb:SetBackdropBorderColor(isActive and 0.25 or 0.18, isActive and 0.85 or 0.40, isActive and 0.70 or 0.45, 1)
            end)
        end
        yOff = yOff - 22
    end

    Slider("BACKGROUND", 0, 1, 0.05,
        function() return db.gatheringAlpha or 1.0 end,
        function(v)
            db.gatheringAlpha = math.floor(v * 20) / 20
            if gatheringLocationsFrame then
                gatheringLocationsFrame:SetBackdropColor(0.03, 0.05, 0.08, 0.97 * v)
                gatheringLocationsFrame:SetBackdropBorderColor(0.22, 0.18, 0.28, v)
                if gatheringLocationsFrame.leftAccent then gatheringLocationsFrame.leftAccent:SetAlpha(v) end
                if gatheringLocationsFrame.topAccent then gatheringLocationsFrame.topAccent:SetAlpha(v) end
            end
        end,
        0.40, 0.40, 0.40)
    Slider("SCALE", 0.5, 2.0, 0.05,
        function() return db.gatheringScale or 1.0 end,
        function(v)
            db.gatheringScale = v
            if gatheringLocationsFrame then gatheringLocationsFrame:SetScale(v) end
        end,
        0.45, 0.22, 0.82)

    Gap(4); Divider()
    SecLabel("PROFESSION COLORS")

    for _, profession in ipairs(PROFESSIONS) do
        if HasProfessionLearned(profession.skillLine) then
            local cr, cg, cb = GetProfessionColor(profession.key)
            local ROW_H2 = 22
            local rowFr  = CreateFrame("Frame", nil, body)
            rowFr:SetPoint("TOPLEFT",  body, "TOPLEFT",  P,  yOff)
            rowFr:SetPoint("TOPRIGHT", body, "TOPRIGHT", -P, yOff)
            rowFr:SetHeight(ROW_H2)

            local nameLbl
            local swatch = MR_OptionsColorSwatch(rowFr, cr, cg, cb,
                function(r, g, b)
                    SetProfessionColor(profession.key, r, g, b)
                    if nameLbl then nameLbl:SetTextColor(r, g, b) end
                end,
                function()
                    ResetProfessionColor(profession.key)
                    local dr, dg, db2 = profession.color[1], profession.color[2], profession.color[3]
                    if nameLbl then nameLbl:SetTextColor(dr, dg, db2) end
                    return dr, dg, db2
                end,
                profession.label .. " color  -  right-click to reset")
            swatch:SetPoint("RIGHT", rowFr, "RIGHT", 0, 0)

            nameLbl = rowFr:CreateFontString(nil, "OVERLAY")
            nameLbl:SetFont(FONT_ROWS, 10, "OUTLINE")
            nameLbl:SetPoint("LEFT",  rowFr,  "LEFT",  0,  0)
            nameLbl:SetPoint("RIGHT", swatch, "LEFT", -4,  0)
            nameLbl:SetText(profession.label)
            nameLbl:SetTextColor(cr, cg, cb)
            nameLbl:SetJustifyH("LEFT")

            yOff = yOff - (ROW_H2 + 2)
        end
    end

    Gap(4); Divider()
    Btn("Reset All Colors", function()
        MR.db.profile.gatheringProfColors = {}
        RebuildGatheringLocationsFrame()
        PopulateGatheringConfig(f)
    end)

    local totalH = math.abs(yOff) + 10
    f:SetHeight(totalH)
    body:SetHeight(totalH)
end

function MR:ToggleGatheringLocationsConfig()
    if not gatheringCfgFrame then
        gatheringCfgFrame = BuildGatheringConfigFrame()
        PopulateGatheringConfig(gatheringCfgFrame)
    end

    if gatheringCfgFrame:IsShown() then
        gatheringCfgFrame:Hide()
    else
        gatheringCfgFrame:Show()
        if gatheringLocationsFrame then
            local x, y = gatheringLocationsFrame:GetCenter()
            if x and y then
                gatheringCfgFrame:SetPoint("LEFT", gatheringLocationsFrame, "RIGHT", 10, 0)
            end
        end
    end
end

local function ToggleGatheringLocations()
    if not gatheringLocationsFrame then
        gatheringLocationsFrame = BuildGatheringLocationsFrame()
        if MR.db then MR.db.profile.gatheringLocOpen = true end
    elseif gatheringLocationsFrame:IsShown() then
        gatheringLocationsFrame:Hide()
        if MR.db then MR.db.profile.gatheringLocOpen = false end
    else
        gatheringLocationsFrame:Show()
        if MR.db then MR.db.profile.gatheringLocOpen = true end
    end
end

MR.ToggleGatheringLocations = ToggleGatheringLocations

function MR:ShowGatheringLocations()
    if not gatheringLocationsFrame then
        gatheringLocationsFrame = BuildGatheringLocationsFrame()
    else
        gatheringLocationsFrame:Show()
    end
    if self.db then self.db.profile.gatheringLocOpen = true end
end

function MR:EnsureGatheringLocationsShown()
    if not gatheringLocationsFrame then
        gatheringLocationsFrame = BuildGatheringLocationsFrame()
    else
        gatheringLocationsFrame:Show()
    end
end

function MR:RefreshGatheringLocationsFrame()
    if gatheringLocationsFrame and gatheringLocationsFrame:IsShown() then
        RebuildGatheringLocationsFrame()
    end
end

function MR:HideGatheringLocations()
    if gatheringLocationsFrame then gatheringLocationsFrame:Hide() end
    if self.db then self.db.profile.gatheringLocOpen = false end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(_, event, addonName)
    if event == "ADDON_LOADED" and addonName == "MidnightRoutine" then
        if MR.db then
            gatheringMinimized = MR.db.profile.gatheringMinimized or false
            if MR.db.profile.gatheringLocOpen then
                MR:ShowGatheringLocations()
            end
        end
        eventFrame:UnregisterEvent("ADDON_LOADED")
    end
end)
