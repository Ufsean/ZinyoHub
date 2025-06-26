-- Zinyo Hub Main Module
-- Version: 1.0.0

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Sirius-v3/rayfield-v3/main/source.lua'))()

local ZinyoHub = {
    Version = "1.0.0",
    Games = {},
    UI = {}
}

-- Muat modul-modul lain
ZinyoHub.UI.ThemeManager = require(script.Parent.UI.ThemeManager)
ZinyoHub.UI.WindowManager = require(script.Parent.UI.WindowManager)
ZinyoHub.Games.BloxFruits = require(script.Parent.Games.BloxFruits)
ZinyoHub.Games.Fisch = require(script.Parent.Games.Fisch)
ZinyoHub.Games.GrowAGarden = require(script.Parent.Games.GrowAGarden)

function ZinyoHub:Load()
    local Window = Rayfield:CreateWindow({
        Name = "Zinyo Hub",
        LoadingTitle = "Zinyo Hub Loading...",
        LoadingSubtitle = "by Zinyo",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "ZinyoHub", 
            FileName = "ZinyoHubConfig"
        },
        Discord = {
            Enabled = false,
            Invite = "",
            RememberJoins = true
        },
        KeySystem = false,
        KeySettings = {
            Title = "Zinyo Hub",
            Subtitle = "Key System",
            Note = "Join the discord for the key!",
            FileName = "ZinyoKey",
            SaveKey = true,
            Key = ""
        }
    })

    -- Tab untuk Blox Fruits
    local BloxFruitsTab = Window:CreateTab("Blox Fruits", "https://www.roblox.com/asset/?id=2753915549") 
    if game.PlaceId == 2753915549 then
        ZinyoHub.Games.BloxFruits:Init(BloxFruitsTab)
    end

    -- Tab untuk Fisch
    local FischTab = Window:CreateTab("Fisch", "https://www.roblox.com/asset/?id=16732694052")
    if game.PlaceId == 16732694052 then
        ZinyoHub.Games.Fisch:Init(FischTab)
    end

    -- Tab untuk Grow A Garden
    local GardenTab = Window:CreateTab("Grow A Garden", "https://www.roblox.com/asset/?id=126884695634066")
    if game.PlaceId == 126884695634066 then
        ZinyoHub.Games.GrowAGarden:Init(GardenTab)
    end

    -- Tab untuk pengaturan
    local SettingsTab = Window:CreateTab("Settings", "rbxassetid://4483345998")
    SettingsTab:CreateLabel("Pengaturan akan ada di sini!")

end

return ZinyoHub
