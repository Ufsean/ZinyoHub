-- Keybind Element for Zinyo Hub

local Keybind = {}

function Keybind:Create(tab, options)
    return tab:CreateKeybind({
        Name = options.Name,
        Default = options.Default or "B",
        Callback = options.Callback
    })
end

return Keybind
