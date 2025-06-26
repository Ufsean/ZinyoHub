-- Grow A Garden Features for Zinyo Hub

local GrowAGarden = {}

function GrowAGarden:Init(tab)
    tab:CreateLabel("Grow A Garden Cheats")

    tab:CreateToggle({
        Name = "Auto Water Plants",
        Callback = function(Value)
            _G.AutoWater = Value
            -- Tambahkan logika auto water di sini
        end,
        Enabled = false
    })

    tab:CreateToggle({
        Name = "Auto Harvest",
        Callback = function(Value)
            _G.AutoHarvest = Value
            -- Tambahkan logika auto harvest di sini
        end,
        Enabled = false
    })
end

return GrowAGarden
