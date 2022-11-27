VehiculeCustomizerVitroze = VehiculeCustomizerVitroze or {}
VehiculeCustomizerVitroze.Version = VehiculeCustomizerVitroze.Version or {}

//if !game.SinglePlayer() then error("This script is only for singleplayer!") return end

-- Load Projet Folder
local vehiculecustomizervitroze_folder = "vehicle_customizer/"

if SERVER then
    -- File Client => AddCSLuaFile
    AddCSLuaFile(vehiculecustomizervitroze_folder.."client/cl_vc_function.lua")
    AddCSLuaFile(vehiculecustomizervitroze_folder.."client/cl_vc_toolmenu.lua")
end

if CLIENT then
    -- File Client => include
    include(vehiculecustomizervitroze_folder.."client/cl_vc_function.lua")
    include(vehiculecustomizervitroze_folder.."client/cl_vc_toolmenu.lua")
end

VehiculeCustomizerVitroze.Version = "0.8"
http.Fetch("https://raw.githubusercontent.com/Vitroze/vehiclecustomizer/main/version.txt", function(body, len, headers, code)
    if !string.find(body, VehiculeCustomizerVitroze.Version) then
        local Body = string.Split(body, " ")
        print("VehiculeCustomizerVitroze : New version available ! New version: "..Body[3].." - Old version: "..VehiculeCustomizerVitroze.Version)
        error("VehiculeCustomizerVitroze : New version available ! New version: "..Body[3].." - Old version: "..VehiculeCustomizerVitroze.Version)
    end
end)