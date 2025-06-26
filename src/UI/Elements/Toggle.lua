-- Toggle Element for Zinyo Hub

local Toggle = {}

function Toggle:Create(tab, options)
    return tab:CreateToggle({
        Name = options.Name,
        Callback = options.Callback,
        Enabled = options.Enabled or false
    })
end

return Toggle
