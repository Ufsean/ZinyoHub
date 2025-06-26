-- Zinyo Hub Loader
-- Version: 1.0.0

local GITHUB_RAW_URL = "https://raw.githubusercontent.com/ZinyoDev/ZinyoHub/main/"
local VERSION_URL = GITHUB_RAW_URL .. "version.json"
local MAIN_MODULE_URL = GITHUB_RAW_URL .. "src/MainModule.lua"

local function GetLatestVersion()
    local success, response = pcall(game.HttpGet, game, VERSION_URL)
    if success and response then
        local versionData = game:GetService("HttpService"):JSONDecode(response)
        return versionData.latest
    end
    return nil
end

local function LoadMainModule()
    local success, mainModuleScript = pcall(game.HttpGet, game, MAIN_MODULE_URL)
    if success and mainModuleScript then
        local mainModule, err = loadstring(mainModuleScript)
        if mainModule then
            return mainModule()
        else
            warn("Failed to load Zinyo Hub Main Module:", err)
        end
    else
        warn("Failed to download Zinyo Hub Main Module.")
    end
    return nil
end

-- Cek versi sebelum memuat
local latestVersion = GetLatestVersion()
if latestVersion and latestVersion > "1.0.0" then
    warn("Zinyo Hub: A new version is available! Reloading...")
    local success, reloaderScript = pcall(game.HttpGet, game, GITHUB_RAW_URL .. "obfuscated/Loader.lua")
    if success and reloaderScript then
        loadstring(reloaderScript)()
    else
        warn("Failed to load the new version. Please re-run the script.")
    end
else
    -- Muat modul utama jika versi sudah terbaru atau gagal cek versi
    local ZinyoHub = LoadMainModule()
    if ZinyoHub then
        ZinyoHub:Load()
    end
end
