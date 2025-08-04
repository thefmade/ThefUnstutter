ThefUnstutterDB = ThefUnstutterDB or {}

local ThefUnstutter_AddonName = "ThefUnstutter"
local ThefUnstutter_AddonNameColored = "|c00DA55BA" .. ThefUnstutter_AddonName .. "|r"

local ThefUnstutterFrame = CreateFrame('Frame')

ThefUnstutterFrame:RegisterEvent("ZONE_CHANGED")
ThefUnstutterFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
ThefUnstutterFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ThefUnstutterFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
ThefUnstutterFrame:RegisterEvent("ADDON_LOADED")

local farclip = {
    ["near"] = "0",
    ["far"] = "1000"
}

--[[
local specificInstances = {
    ["Ragefire Chasm"] = false,
    ["The Deadmines"] = false,
    ["Shadowfang Keep"] = false,
    ["Blackfathom Deeps"] = false,
    ["The Stockade"] = true,
    ["Gnomeregan"] = false,
    ["Razorfen Kraul"] = false,
    ["Razorfen Downs"] = false,
    ["Scarlet Monastery"] = false,
    ["Uldaman"] = false,
    ["Zul'Farrak"] = false,
    ["Maraudon"] = false,
    ["Sunken Temple"] = false,
    ["Blackrock Depths"] = false,
    ["Blackrock Spire"] = false,
    ["Dire Maul"] = false,
    ["Scholomance"] = false,
    ["Stratholme"] = false,
    ["Karazhan"] = false,
    ["Hellfire Ramparts"] = false,
    ["The Blood Furnace"] = false,
    ["The Shattered Halls"] = false,
    ["The Slave Pens"] = false,
    ["The Underbog"] = false,
    ["Mana-Tombs"] = false,
    ["Auchenai Crypts"] = false,
    ["Sethekk Halls"] = false,
    ["Shadow Labyrinth"] = false,
    ["The Steamvault"] = false,
    ["The Mechanar"] = false,
    ["The Botanica"] = false,
    ["The Arcatraz"] = false,
    ["Magisters' Terrace"] = false,
    ["Gruul's Lair"] = true,
    ["Magtheridon's Lair"] = true,
    ["Serpentshrine Cavern"] = true,
    ["The Eye"] = true,
    ["Black Temple"] = true,
    ["Hyjal Summit"] = true,
    ["Sunwell Plateau"] = true,
}
]]

ThefUnstutterFrame:SetScript('OnEvent', function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if not ThefUnstutterDB["zoneName"] then
            ThefUnstutterDB["zoneName"] = GetZoneText()
        end
        if not ThefUnstutterDB["realZoneName"] then
            ThefUnstutterDB["realZoneName"] = GetRealZoneText()
        end
        if not ThefUnstutterDB["subZoneName"] then
            ThefUnstutterDB["subZoneName"] = GetSubZoneText()
        end
    end

    local zoneName = GetZoneText()
    local realZoneName = GetRealZoneText()
    local subZoneName = GetSubZoneText()
    local isInstance, instanceType = IsInInstance()

    -- ThefUnstutter_Log(ThefUnstutterDB["zoneName"] .. " --> " .. zoneName .. " / " .. ThefUnstutterDB["realZoneName"] .. " --> " .. realZoneName .. " / " .. ThefUnstutterDB["subZoneName"] .. " --> " .. subZoneName)

    local inInstance = isInstance ~= nil

    if inInstance then
        SetCVar("farclip", farclip["near"])
        ThefUnstutter_Log('Terrain distance reduced.')
    else
        SetCVar("farclip", farclip["far"])
    end

    --[[
    if inInstance and specificInstances[zoneName] then
        TerrainDistanceDB = zoneName
        ThefUnstutter_Log("Entered specific instance: " .. zoneName .. ". farclip set to: " .. farclip["near"])
    else
        TerrainDistanceDB = "Outside"
        ThefUnstutter_Log("Outside or in non-specific instance. farclip set to: " .. farclip["far"])
    end
    ]]
    
    ThefUnstutter_LogOldZone(zoneName, realZoneName, subZoneName, inInstance)
end)

function ThefUnstutter_LogOldZone (zoneName, realZoneName, subZoneName, inInstance)
    ThefUnstutterDB["zoneName"] = zoneName
    ThefUnstutterDB["realZoneName"] = realZoneName
    ThefUnstutterDB["subZoneName"] = subZoneName
    ThefUnstutterDB["inInstance"] = inInstance
end

function ThefUnstutter_Log(message)
    if message then
        DEFAULT_CHAT_FRAME:AddMessage(ThefUnstutter_AddonNameColored .. ": " .. message)
    end
end
