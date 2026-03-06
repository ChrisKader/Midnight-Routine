local L = LibStub("AceLocale-3.0"):GetLocale("MidnightRoutine")

local DUNGEON_TIERS = {
    { 10, L["Myth"],     "#ff8000" },
    {  7, L["Hero"],     "#0070dd" },
    {  4, L["Champion"], "#f1c232" },
    {  2, L["Veteran"],  "#1eff00" },
    {  0, L["Follower"], "#b7b7b7" },
}

local RAID_DIFF = {
    [14] = { L["Normal"], "#1eff00" },
    [15] = { L["Heroic"], "#0070dd" },
    [16] = { L["Mythic"], "#ff8000" },
    [17] = { L["LFR"],    "#b7b7b7" },
}

local DIFF_RANK = { [17]=1, [14]=2, [15]=3, [16]=4 }

local function GetDungeonTier(level)
    level = level or 0
    for _, t in ipairs(DUNGEON_TIERS) do
        if level >= t[1] then return t[2], t[3] end
    end
    return L["Follower"], "#b7b7b7"
end

local function GetRaidDiffName(diffId)
    local d = RAID_DIFF[diffId]
    return d and d[1] or L["Normal"], d and d[2] or "#1eff00"
end

MR:RegisterModule({
    key         = "great_vault",
    label       = L["GreatVault_Title"],
    labelColor  = "#ff8000",
    resetType   = "weekly",
    defaultOpen = true,

    onScan = function(mod)
        if not C_WeeklyRewards or not C_WeeklyRewards.GetActivities then return end
        local activities = C_WeeklyRewards.GetActivities()
        if not activities then return end
        local db = MR.db.char.progress
        if not db[mod.key] then db[mod.key] = {} end
        local vd = db[mod.key]

        vd["vault_d_progress"]  = 0
        vd["vault_d_max_level"] = 0
        vd["vault_r_progress"]  = 0
        vd["vault_r_diff_id"]   = 14
        vd["vault_w_progress"]  = 0

        for _, act in ipairs(activities) do
            if act.type == 1 then
                vd["vault_d_progress"] = act.progress or 0
                if (act.level or 0) > (vd["vault_d_max_level"] or 0) then
                    vd["vault_d_max_level"] = act.level or 0
                end
            elseif act.type == 3 then
                local prog = act.progress or 0
                if prog > vd["vault_r_progress"] then
                    vd["vault_r_progress"] = prog
                end
                local newRank = DIFF_RANK[act.difficultyId]
                if newRank and newRank > (DIFF_RANK[vd["vault_r_diff_id"]] or 0) then
                    vd["vault_r_diff_id"] = act.difficultyId
                end
            elseif act.type == 4 then
                vd["vault_w_progress"] = act.progress or 0
            end
        end

        local tierLabel, tierColor   = GetDungeonTier(vd["vault_d_max_level"])
        vd["vault_d_tier_label"]     = tierLabel
        vd["vault_d_tier_color"]     = tierColor

        local raidName, raidColor    = GetRaidDiffName(vd["vault_r_diff_id"])
        vd["vault_r_diff_label"]     = raidName
        vd["vault_r_diff_color"]     = raidColor
    end,

    rows = {
        {
            key              = "vault_r2",
            label            = L["Vault_Raid2_Label"],
            max              = 2,
            vaultLabel       = L["Normal"],
            vaultColor       = "#1eff00",
            note             = L["Vault_Raid2_Note"],
            liveKey          = "vault_r_progress",
            liveTierLabelKey = "vault_r_diff_label",
            liveTierColorKey = "vault_r_diff_color",
        },
        {
            key              = "vault_r4",
            label            = L["Vault_Raid4_Label"],
            max              = 4,
            vaultLabel       = L["Heroic"],
            vaultColor       = "#0070dd",
            note             = L["Vault_Raid4_Note"],
            liveKey          = "vault_r_progress",
            liveTierLabelKey = "vault_r_diff_label",
            liveTierColorKey = "vault_r_diff_color",
        },
        {
            key              = "vault_r6",
            label            = L["Vault_Raid6_Label"],
            max              = 6,
            vaultLabel       = L["Mythic"],
            vaultColor       = "#ff8000",
            note             = L["Vault_Raid6_Note"],
            liveKey          = "vault_r_progress",
            liveTierLabelKey = "vault_r_diff_label",
            liveTierColorKey = "vault_r_diff_color",
        },
        {
            key              = "vault_d1",
            label            = L["Vault_Dungeon1_Label"],
            max              = 1,
            vaultLabel       = L["Veteran"],
            vaultColor       = "#1eff00",
            note             = L["Vault_Dungeon1_Note"],
            liveKey          = "vault_d_progress",
            liveTierLabelKey = "vault_d_tier_label",
            liveTierColorKey = "vault_d_tier_color",
        },
        {
            key              = "vault_d4",
            label            = L["Vault_Dungeon4_Label"],
            max              = 4,
            vaultLabel       = L["Champion"],
            vaultColor       = "#f1c232",
            note             = L["Vault_Dungeon4_Note"],
            liveKey          = "vault_d_progress",
            liveTierLabelKey = "vault_d_tier_label",
            liveTierColorKey = "vault_d_tier_color",
        },
        {
            key              = "vault_d8",
            label            = L["Vault_Dungeon8_Label"],
            max              = 8,
            vaultLabel       = L["Hero"],
            vaultColor       = "#0070dd",
            note             = L["Vault_Dungeon8_Note"],
            liveKey          = "vault_d_progress",
            liveTierLabelKey = "vault_d_tier_label",
            liveTierColorKey = "vault_d_tier_color",
        },
        {
            key        = "vault_w2",
            label      = L["Vault_World2_Label"],
            max        = 2,
            vaultLabel = L["Adventurer"],
            vaultColor = "#b7b7b7",
            note       = L["Vault_World2_Note"],
            liveKey    = "vault_w_progress",
        },
        {
            key        = "vault_w4",
            label      = L["Vault_World4_Label"],
            max        = 4,
            vaultLabel = L["Champion"],
            vaultColor = "#f1c232",
            note       = L["Vault_World4_Note"],
            liveKey    = "vault_w_progress",
        },
        {
            key        = "vault_w8",
            label      = L["Vault_World8_Label"],
            max        = 8,
            vaultLabel = L["Hero"],
            vaultColor = "#0070dd",
            note       = L["Vault_World8_Note"],
            liveKey    = "vault_w_progress",
        },
    },
})
