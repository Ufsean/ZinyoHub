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
    -- Auto Fishing yang diperbaiki
    AutoFish = function(state)
        _G.Zinyo_AutoFish = state
        task.spawn(function()
            while _G.Zinyo_AutoFish do
                -- Cari remote event untuk memancing
                local fishingRemote = game:GetService("ReplicatedStorage"):FindFirstChild("FishingRemote")
                
                if fishingRemote then
                    -- Proses memancing: casting dan reeling
                    fishingRemote:FireServer("Cast")  -- Lempar kail
                    task.wait(2)
                    fishingRemote:FireServer("Reel")  -- Tarik kail
                    print("Zinyo Hub: Berhasil memancing!")
                else
                    warn("Zinyo Hub: Tidak menemukan Fishing Remote")
                end
                task.wait(5) -- Cooldown 5 detik
            end
        end)
    end,
    
    -- Sistem teleport ke lokasi populer
    TeleportTo = function(location)
        local locations = {
            ["Danau"] = Vector3.new(100, 50, 200),
            ["Sungai"] = Vector3.new(-120, 30, 300),
            ["Laut Dalam"] = Vector3.new(0, 20, 500),
            ["Pelabuhan"] = Vector3.new(80, 10, -150)
        }
        
        if locations[location] and LocalPlayer.Character then
            LocalPlayer.Character:MoveTo(locations[location])
            print("Zinyo Hub: Teleport ke "..location)
        end
    end,
    
    -- Fitur client-side
    SetSpeed = function(speed)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speed
            print("Zinyo Hub: WalkSpeed diatur menjadi "..speed)
        end
    end,
    
    SetJump = function(power)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = power
            print("Zinyo Hub: JumpPower diatur menjadi "..power)
        end
    end,
    
    -- ESP untuk spot fishing terbaik
    FishingSpotESP = function(state)
        _G.Zinyo_FishingESP = state
        
        if state then
            task.spawn(function()
                -- Warna untuk spot fishing
                local spotColors = {
                    ["Common"] = Color3.new(0, 1, 0),      -- Hijau untuk ikan biasa
                    ["Rare"] = Color3.new(0, 0, 1),        -- Biru untuk ikan langka
                    ["Epic"] = Color3.new(0.5, 0, 0.5),    -- Ungu untuk ikan epik
                    ["Legendary"] = Color3.new(1, 0.5, 0)  -- Oranye untuk ikan legendaris
                }
                
                -- Bersihkan highlight sebelumnya
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:FindFirstChild("ZinyoFishingSpotHighlight") then
                        obj.ZinyoFishingSpotHighlight:Destroy()
                    end
                end
                
                while _G.Zinyo_FishingESP do
                    -- Cari semua spot fishing di workspace
                    for _, spot in pairs(workspace:GetDescendants()) do
                        if spot.Name:match("FishingSpot") or spot.Name:match("FishSpawn") then
                            if not spot:FindFirstChild("ZinyoFishingSpotHighlight") then
                                local highlight = Instance.new("Highlight")
                                highlight.Name = "ZinyoFishingSpotHighlight"
                                highlight.Parent = spot
                                
                                -- Tentukan rarity berdasarkan nama atau properti
                                local rarity = "Common"
                                if spot.Name:match("Rare") then rarity = "Rare"
                                elseif spot.Name:match("Epic") then rarity = "Epic"
                                elseif spot.Name:match("Legendary") then rarity = "Legendary" end
                                
                                highlight.FillColor = spotColors[rarity]
                                highlight.OutlineColor = highlight.FillColor
                            end
                        end
                    end
                    task.wait(5) -- Refresh setiap 5 detik
                end
                
                -- Hapus semua highlight saat ESP dimatikan
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:FindFirstChild("ZinyoFishingSpotHighlight") then
                        obj.ZinyoFishingSpotHighlight:Destroy()
                    end
                end
            end)
        end
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
    end,
    
    -- FITUR BARU
    SetSpeed = function(speed)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speed
            print("Zinyo Hub: WalkSpeed diatur menjadi "..speed)
        end
    end,
    
    SetJump = function(power)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = power
            print("Zinyo Hub: JumpPower diatur menjadi "..power)
        end
    end,
    
    AutoClick = function(state)
        _G.Zinyo_AutoClick = state
        task.spawn(function()
            while _G.Zinyo_AutoClick do
                mouse1click()
                task.wait(0.5)
            end
        end)
    end,
    
    PlantESP = function(state)
        _G.Zinyo_PlantESP = state
        
        if state then
            task.spawn(function()
                -- Warna untuk tanaman berbeda
                local plantColors = {
                    ["Tomato"] = Color3.new(1, 0, 0),
                    ["Carrot"] = Color3.new(1, 0.5, 0),
                    ["Rose"] = Color3.new(1, 0, 1),
                    -- Tambahkan lebih banyak jenis tanaman sesuai kebutuhan
                }
                
                local defaultColor = Color3.new(0, 1, 0) -- Hijau untuk tanaman yang tidak dikenal
                
                -- Bersihkan highlight sebelumnya
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:FindFirstChild("ZinyoPlantHighlight") then
                        obj.ZinyoPlantHighlight:Destroy()
                    end
                end
                
                while _G.Zinyo_PlantESP do
                    -- Cari semua tanaman di workspace
                    for _, plant in pairs(workspace:GetDescendants()) do
                        if plant.Name:match("Plant") or plant.Name:match("Bush") or plant:IsA("Model") then
                            if not plant:FindFirstChild("ZinyoPlantHighlight") then
                                local highlight = Instance.new("Highlight")
                                highlight.Name = "ZinyoPlantHighlight"
                                highlight.Parent = plant
                                
                                -- Tentukan warna berdasarkan jenis tanaman
                                local plantType = plant.Name
                                highlight.FillColor = plantColors[plantType] or defaultColor
                                highlight.OutlineColor = highlight.FillColor
                            end
                        end
                    end
                    task.wait(5) -- Refresh setiap 5 detik
                end
                
                -- Hapus semua highlight saat ESP dimatikan
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:FindFirstChild("ZinyoPlantHighlight") then
                        obj.ZinyoPlantHighlight:Destroy()
                    end
                end
            end)
        end
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
            Name = "Auto Fishing",
            CurrentValue = false,
            Callback = Module.AutoFish
        })
        
        Tab:CreateDropdown({
            Name = "Teleport Lokasi",
            Options = {"Danau", "Sungai", "Laut Dalam", "Pelabuhan"},
            CurrentValue = "Danau",
            Callback = Module.TeleportTo
        })
        
        Tab:CreateSlider({
            Name = "Walk Speed",
            Range = {16, 100},
            Increment = 1,
            CurrentValue = 16,
            Callback = Module.SetSpeed
        })
        
        Tab:CreateSlider({
            Name = "Jump Power",
            Range = {50, 200},
            Increment = 5,
            CurrentValue = 50,
            Callback = Module.SetJump
        })
        
        Tab:CreateToggle({
            Name = "Fishing Spot ESP",
            CurrentValue = false,
            Callback = Module.FishingSpotESP
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
        -- Fitur baru
        Tab:CreateSlider({
            Name = "Walk Speed",
            Range = {16, 100},
            Increment = 1,
            CurrentValue = 16,
            Callback = Module.SetSpeed
        })
        Tab:CreateSlider({
            Name = "Jump Power",
            Range = {50, 200},
            Increment = 5,
            CurrentValue = 50,
            Callback = Module.SetJump
        })
        Tab:CreateToggle({
            Name = "Auto Click",
            CurrentValue = false,
            Callback = Module.AutoClick
        })
        Tab:CreateToggle({
            Name = "Plant ESP (Sorot Tanaman)",
            CurrentValue = false,
            Callback = Module.PlantESP
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
--      CLEANUP HANDLER
-- ========================
local function Cleanup()
    print("Zinyo Hub: Player is leaving. Cleaning up all processes...")
    
    -- Hentikan semua loop dengan mengatur flag menjadi false
    _G.Zinyo_AutoFarm = false
    _G.Zinyo_AutoFish = false
    _G.Zinyo_AutoWater = false
    _G.Zinyo_AutoHarvest = false
    _G.Zinyo_AutoClick = false
    _G.Zinyo_PlantESP = false
    _G.Zinyo_FishingESP = false
    
    -- Rayfield GUI biasanya akan hancur sendiri saat PlayerGui dibersihkan,
    -- jadi fokus utama kita adalah menghentikan loop latar belakang.
end

-- Hubungkan ke event PlayerRemoving untuk memastikan pembersihan saat keluar
Players.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        Cleanup()
    end
end)


-- ========================
--      EKSEKUSI UTAMA
-- ========================
pcall(InitializeGUI)
print("Zinyo Hub berhasil dimuat!")
