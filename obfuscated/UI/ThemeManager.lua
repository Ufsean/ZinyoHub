-- Theme Manager for Zinyo Hub

local ThemeManager = {}

function ThemeManager:GetDarkTheme()
    return {
        Background = Color3.fromRGB(24, 24, 24),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(120, 40, 200),
        -- Tambahkan properti tema lainnya
    }
end

function ThemeManager:GetLightTheme()
    return {
        Background = Color3.fromRGB(240, 240, 240),
        Text = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(120, 40, 200),
        -- Tambahkan properti tema lainnya
    }
end

return ThemeManager
