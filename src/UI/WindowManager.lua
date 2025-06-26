-- Window Manager for Zinyo Hub

local WindowManager = {}

function WindowManager:CreateWindow(options)
    -- Logika untuk membuat window utama menggunakan Rayfield
    -- Ini akan dipanggil dari MainModule.lua
    print("Window created with title: " .. options.Title)
end

return WindowManager
