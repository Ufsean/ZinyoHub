-- Button Element for Zinyo Hub

local Button = {}

function Button:Create(tab, options)
    return tab:CreateButton({
        Name = options.Name,
        Callback = options.Callback
    })
end

return Button
