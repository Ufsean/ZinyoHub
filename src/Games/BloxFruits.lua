-- Blox Fruits Features for Zinyo Hub

local BloxFruits = {}

function BloxFruits:Init(tab)
    tab:CreateLabel("Blox Fruits Cheats")

    tab:CreateToggle({
        Name = "Auto Farm Level",
        Callback = function(Value)
            _G.AutoFarmLevel = Value
            -- Tambahkan logika auto farm di sini
        end,
        Enabled = false
    })

    tab:CreateToggle({
        Name = "ESP Players",
        Callback = function(Value)
            _G.ESPPlayers = Value
            -- Tambahkan logika ESP di sini
        end,
        Enabled = false
    })
end

return BloxFruits
