local PREY_COLOR = "|cffcc2244"

local function BuildPreyNormalQuestIds()
    local ids = {}
    for qid = 91095, 91124 do
        ids[#ids + 1] = qid
    end
    return ids
end

local function BuildPreyHardQuestIds()
    local ids = {}
    for qid = 91210, 91242, 2 do
        ids[#ids + 1] = qid
    end
    for qid = 91243, 91255 do
        ids[#ids + 1] = qid
    end
    return ids
end

local function BuildPreyNightmareQuestIds()
    local ids = {}
    for qid = 91211, 91241, 2 do
        ids[#ids + 1] = qid
    end
    for qid = 91256, 91269 do
        ids[#ids + 1] = qid
    end
    return ids
end

MR:RegisterModule({
    key         = "prey",
    label       = "Prey System",
    labelColor  = "#cc2244",
    resetType   = "weekly",
    defaultOpen = true,
    rows = {
        {
            key      = "prey_normal_hunts",
            label    = PREY_COLOR .. "Normal Hunts:|r",
            max      = 4,
            note     = "Normal-difficulty prey hunts completed this week (max 4)",
            questIds = BuildPreyNormalQuestIds(),
        },
        {
            key      = "prey_hard_hunts",
            label    = PREY_COLOR .. "Hard Hunts:|r",
            max      = 4,
            note     = "Hard-difficulty prey hunts completed this week (max 4)",
            questIds = BuildPreyHardQuestIds(),
        },
        {
            key      = "prey_nightmare_hunts",
            label    = PREY_COLOR .. "Nightmare Hunts:|r",
            max      = 4,
            note     = "Nightmare-difficulty prey hunts completed this week (max 4)",
            questIds = BuildPreyNightmareQuestIds(),
        },
        {
            key        = "prey_remnants",
            label      = PREY_COLOR .. "Remnants of Anguish:|r",
            currencyId = 3392,
            max        = 99999,
            noMax      = true,
            note       = "Current Remnants of Anguish",
        },
    },
})
