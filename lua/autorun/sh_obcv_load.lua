Objet_CreatorVehicleVitroze = Objet_CreatorVehicleVitroze or {}
Objet_CreatorVehicleVitroze.Version = Objet_CreatorVehicleVitroze.Version or {}

-- Load Projet Folder
local objetcreatorvehicle_folder = "objet_creatorvehicle/"

-- Load Language
local files_language = file.Find(objetcreatorvehicle_folder.."languages/*.lua", "LUA")
for _, f in pairs(files_language) do
    if SERVER then
        AddCSLuaFile(objetcreatorvehicle_folder.."languages/"..f)
    end

    include(objetcreatorvehicle_folder.."languages/"..f)
end

function Objet_CreatorVehicleVitroze:Lang(id)
    return Objet_CreatorVehicleVitroze.Language[id]
end

if SERVER then
    -- File Client => AddCSLuaFile
    AddCSLuaFile(objetcreatorvehicle_folder.."client/cl_obcv_function.lua")
    AddCSLuaFile(objetcreatorvehicle_folder.."client/cl_obcv_toolmenu.lua")
end

if CLIENT then
    -- File Client => include
    include(objetcreatorvehicle_folder.."client/cl_obcv_function.lua")
    include(objetcreatorvehicle_folder.."client/cl_obcv_toolmenu.lua")
end

Objet_CreatorVehicleVitroze.Version = "0.5"
http.Fetch("https://raw.githubusercontent.com/Vitroze/objet_creatorvehicle/main/version.txt", function(body, len, headers, code)
    if !string.find(body, Objet_CreatorVehicleVitroze.Version) then
        local Body = string.Split(body, " ")
        print("Objet_CreatorVehicleVitroze : New version available ! New version: "..Body[3].." - Old version: "..Objet_CreatorVehicleVitroze.Version)
        error("Objet_CreatorVehicleVitroze : New version available ! New version: "..Body[3].." - Old version: "..Objet_CreatorVehicleVitroze.Version)
    end
end)