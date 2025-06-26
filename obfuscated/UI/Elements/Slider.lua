-- Slider Element for Zinyo Hub

local Slider = {}

function Slider:Create(tab, options)
    return tab:CreateSlider({
        Name = options.Name,
        Min = options.Min or 0,
        Max = options.Max or 100,
        Default = options.Default or 50,
        Callback = options.Callback
    })
end

return Slider
