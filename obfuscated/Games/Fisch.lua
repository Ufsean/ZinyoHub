-- Fisch Features for Zinyo Hub

local Fisch = {}

function Fisch:Init(tab)
    tab:CreateLabel("Fisch Cheats")

    tab:CreateToggle({
        Name = "Auto Catch Fish",
        Callback = function(Value)
            _G.AutoCatchFish = Value
            -- Tambahkan logika auto catch di sini
        end,
        Enabled = false
    })
end

return Fisch
