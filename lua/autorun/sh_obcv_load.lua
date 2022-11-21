Object_CreatorVehicleVitroze = Object_CreatorVehicleVitroze or {}
Object_CreatorVehicleVitroze.Version = Object_CreatorVehicleVitroze.Version or {}

// if !game.SinglePlayer() then error("This script is only for singleplayer!") return end

-- Load Projet Folder
local objectcreatorvehicle_folder = "object_creatorvehicle/"

if SERVER then
    -- File Client => AddCSLuaFile
    AddCSLuaFile(objectcreatorvehicle_folder.."client/cl_obcv_function.lua")
    AddCSLuaFile(objectcreatorvehicle_folder.."client/cl_obcv_toolmenu.lua")
end

if CLIENT then
    -- File Client => include
    include(objectcreatorvehicle_folder.."client/cl_obcv_function.lua")
    include(objectcreatorvehicle_folder.."client/cl_obcv_toolmenu.lua")
end

Object_CreatorVehicleVitroze.Version = "0.5"
http.Fetch("https://raw.githubusercontent.com/Vitroze/object_creatorvehicle/main/version.txt", function(body, len, headers, code)
    if !string.find(body, Object_CreatorVehicleVitroze.Version) then
        local Body = string.Split(body, " ")
        print("Object_CreatorVehicleVitroze : New version available ! New version: "..Body[3].." - Old version: "..Object_CreatorVehicleVitroze.Version)
        error("Object_CreatorVehicleVitroze : New version available ! New version: "..Body[3].." - Old version: "..Object_CreatorVehicleVitroze.Version)
    end
end)