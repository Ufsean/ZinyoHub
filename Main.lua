--[[
    Zinyo Hub - Universal Roblox Script Hub
    Dibuat dengan struktur single-file untuk kompatibilitas executor.
]]

-- ========================
--      INISIALISASI LIBRARY
-- ========================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ========================
--      KONFIGURASI GAME
-- ========================
local GameConfig = {
    [2753915549] = "BloxFruit",
    [16732694052] = "Fisch",
    [126884695634066] = "GrowAGarden"
}

-- ========================
--      MODUL FITUR GAME
-- ========================
local GameFeatures = {}

--- Fitur untuk Blox Fruit ---
GameFeatures.BloxFruit = {
    AutoFarm = function(state)
        _G.Zinyo_AutoFarm = state
        task.spawn(function()
            while _G.Zinyo_AutoFarm do
                print("Zinyo Hub: Auto Farming in Blox Fruit...")
                -- Logika auto farm ditambahkan di sini
                task.wait(2)
            end
        end)
    end,
    ToggleGodMode = function(state)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, not state)
            print("Zinyo Hub: God Mode set to " .. tostring(state))
        end
    end
}

--- Fitur untuk Fisch ---
GameFeatures.Fisch = {
    AutoFish = function(state)
        _G.Zinyo_AutoFish = state
        task.spawn(function()
            while _G.Zinyo_AutoFish do
                print("Zinyo Hub: Auto Fishing in Fisch...")
                -- Logika auto fish ditambahkan di sini
                task.wait(2)
            end
        end)
    end
}

--- Fitur untuk Grow A Garden ---
GameFeatures.GrowAGarden = {
    AutoWater = function(state)
        _G.Zinyo_AutoWater = state
        task.spawn(function()
            while _G.Zinyo_AutoWater do
                print("Zinyo Hub: Auto Watering in Grow A Garden...")
                -- Logika auto water ditambahkan di sini
                task.wait(2)
            end
        end)
    end,
    AutoHarvest = function(state)
        _G.Zinyo_AutoHarvest = state
        task.spawn(function()
            while _G.Zinyo_AutoHarvest do
                -- PENTING: Ganti "HarvestAllPlants" dengan nama remote event yang benar dari Remote Spy.
                local harvestRemote = game:GetService("ReplicatedStorage"):FindFirstChild("HarvestAllPlants") 
                
                if harvestRemote then
                    -- PENTING: Anda mungkin perlu mengirim argumen, contoh: harvestRemote:FireServer("All")
                    harvestRemote:FireServer() 
                    print("Zinyo Hub: Mencoba memanen semua tanaman...")
                else
                    warn("Zinyo Hub: Tidak dapat menemukan Remote Event untuk panen. Periksa namanya.")
                end
                task.wait(5) -- Tunggu 5 detik sebelum mencoba lagi
            end
        end)
    end
}


-- ========================
--      PENGATURAN GUI
-- ========================
local function InitializeGUI()
    local Window = Rayfield:CreateWindow({
        Name = "Zinyo Hub",
        LoadingTitle = "Zinyo Hub",
        LoadingSubtitle = "by Zinyo",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "ZinyoHub",
            FileName = "ZinyoHubConfig"
        },
        Discord = {Enabled = false},
        KeySystem = false,
    })

    local currentGame = GameConfig[game.PlaceId]

    if not currentGame then
        local FallbackTab = Window:CreateTab("Info", 4483362458)
        FallbackTab:CreateLabel("Game ini tidak didukung oleh Zinyo Hub.")
        return
    end

    -- Membuat tab berdasarkan game yang sedang dimainkan
    if currentGame == "BloxFruit" then
        local Tab = Window:CreateTab("Blox Fruit", 4483362458)
        local Module = GameFeatures.BloxFruit
        
        Tab:CreateToggle({
            Name = "Auto Farm",
            CurrentValue = false,
            Callback = Module.AutoFarm
        })
        Tab:CreateToggle({
            Name = "God Mode",
            CurrentValue = false,
            Callback = Module.ToggleGodMode
        })

    elseif currentGame == "Fisch" then
        local Tab = Window:CreateTab("Fisch", 4483362458)
        local Module = GameFeatures.Fisch

        Tab:CreateToggle({
            Name = "Auto Fish",
            CurrentValue = false,
            Callback = Module.AutoFish
        })

    elseif currentGame == "GrowAGarden" then
        local Tab = Window:CreateTab("Grow A Garden", 4483362458)
        local Module = GameFeatures.GrowAGarden

        Tab:CreateToggle({
            Name = "Auto Water Plants",
            CurrentValue = false,
            Callback = Module.AutoWater
        })
        Tab:CreateToggle({
            Name = "Auto Harvest",
            CurrentValue = false,
            Callback = Module.AutoHarvest
        })
    end

    -- Tab Pengaturan Universal
    local SettingsTab = Window:CreateTab("Settings", 4483362458)
    SettingsTab:CreateLabel("Pengaturan Zinyo Hub")
    SettingsTab:CreateDropdown({
        Name = "Pilih Tema",
        Options = {"Default", "Dark", "Light", "Modern"},
        CurrentValue = "Default",
        Callback = function(Theme)
            Rayfield:LoadTheme(Theme)
        end,
    })
end

-- ========================
--      EKSEKUSI UTAMA
-- ========================
pcall(InitializeGUI)
print("Zinyo Hub berhasil dimuat!")
