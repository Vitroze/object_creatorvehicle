
local Template_Code = [[
hook.Add("PlayerSpawnedVehicle", "OBCV_%vehName", function(ply, vehicle)
    if vehicle:GetVehicleClass() == "%vehID" then

        local prop = ents.Create("prop_physics")
        if !IsValid(prop) then return end
        prop:SetModel("%propModel")
        prop:SetPos(vehicle:LocalToWorld(Vector(%propVector)))
        prop:SetAngles(vehicle:LocalToWorldAngles(Angle(%propAngle)))
        prop:Spawn()
        prop:Activate()
        prop:SetParent(vehicle)
        prop:SetSolid(SOLID_NONE)
        prop:SetMoveType(MOVETYPE_NONE)

    end
end)

local V = {
    Name = "%vehName",
    Model = "%vehModel",
    Class = "%vehClass",
    Category = "%catName",
    Author = "%authName",
    Information = "%information",
    KeyValues = { vehiclescript = "%KeyValues" },
}

list.Set( "Vehicles", "%vehID", V )
]]

// Create a code automatically to put an object on the vehicle in Lua
function CompileCode(vehName, catName, information, propModel, propVectorX, propVectorY, propVectorZ, propAngleYaw, propAnglePitch, propAngleRoll)
    local lp           = LocalPlayer()
    if !IsValid(lp) then return end 
    local car          = lp:GetVehicle()
    if !IsValid(car) then notification.AddLegacy("You are not in a vehicle", NOTIFY_ERROR, 2) return end
    if vehName == "" then notification.AddLegacy("You must enter a name for your vehicle", NOTIFY_ERROR, 2) return end
    if catName == "" then notification.AddLegacy("You must enter a category for your vehicle", NOTIFY_ERROR, 2) return end
    if propModel == "" then notification.AddLegacy("You must enter a model for your prop", NOTIFY_ERROR, 2) return end


    local className    = car:GetVehicleClass()
    local vehData      = list.Get("Vehicles")[className]
    local vehClass     = vehData.Class
    local vehModel     = vehData.Model
    local vehAuthor    = lp:Nick()
    local vehKeyValues = vehData.KeyValues

    local vehID        = string.lower(vehAuthor.." "..vehName)

    // Detecting special characters in string lua
    local tbl = {"!", " ", "_", '"', "#", "$", '%', "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", ":", ";", "<", "=", ">", "?", "@", "[", "\\", "]", "^", "`", "{", "|", "}", "~"}
    for _, v in pairs(tbl) do 
        if v == "%" or v == "(" or v == ")" or v == "[" or v == "]" then vehID = vehID:Replace(v, "_") continue
        elseif string.find(vehID, v) then 
            vehID = vehID:Replace(v, "_")
            continue
        end
    end

    local propVector   = Vector(propVectorX, propVectorY, propVectorZ)
    propVector         = string.Replace(tostring(propVector), " ", ", ")
    local propAngle    = Angle(propAngleYaw, propAnglePitch, propAngleRoll)
    propAngle          = string.Replace(tostring(propAngle), " ", ", ")

    Template_Code = string.Replace(Template_Code, "%vehName", vehName)
    Template_Code = string.Replace(Template_Code, "%className", className)
    Template_Code = string.Replace(Template_Code, "%propModel", propModel)
    Template_Code = string.Replace(Template_Code, "%propVector", propVector)
    Template_Code = string.Replace(Template_Code, "%propAngle", propAngle)
    Template_Code = string.Replace(Template_Code, "%vehModel", vehModel)
    Template_Code = string.Replace(Template_Code, "%vehClass", vehClass)
    Template_Code = string.Replace(Template_Code, "%catName", catName)
    Template_Code = string.Replace(Template_Code, "%authName", vehAuthor)
    Template_Code = string.Replace(Template_Code, "%information", information)
    Template_Code = string.Replace(Template_Code, "%vehID", vehID)
    Template_Code = string.Replace(Template_Code, "%KeyValues", vehKeyValues.vehiclescript)
    
    notification.AddLegacy("Code generated, check your clipboard text.", NOTIFY_GENERIC, 5)
    return SetClipboardText(Template_Code)
end
concommand.Add("object_creator_vehicle_generate_code", function()
    CompileCode(GetConVar("obcv_name"):GetString(), GetConVar("obcv_category"):GetString(), GetConVar("obcv_information"):GetString(), GetConVar("obcv_props"):GetString(), GetConVar("obcv_x"):GetFloat(), GetConVar("obcv_y"):GetFloat(), GetConVar("obcv_z"):GetFloat(), GetConVar("obcv_pitch"):GetFloat(), GetConVar("obcv_yaw"):GetFloat(), GetConVar("obcv_roll"):GetFloat())

end)



function Object_CreatorVehicleVitroze:VisualProps(propModel, propVectorX, propVectorY, propVectorZ, propAngleYaw, propAnglePitch, propAngleRoll)
    local lp = LocalPlayer()
    if !IsValid(lp) then return end
    
    local car = lp:GetVehicle()
    if !IsValid(car) then notification.AddLegacy("You are not in a vehicle", NOTIFY_ERROR, 2) return end
    
    local propVector = Vector(propVectorX, propVectorY, propVectorZ)
    local propAngle = Angle(propAngleYaw, propAnglePitch, propAngleRoll)

    if propModel == "" or propModel == nil then notification.AddLegacy("You did not put a model for the props", NOTIFY_ERROR, 2) return end


    // Check if the props already exist 
    local prop = car:GetChildren()
    if #prop > 0 then
        for k, v in pairs(prop) do
            if v:GetModel() == propModel then
                v:Remove()
            end
        end
    end
    
    local prop = ents.CreateClientProp("prop_physics")  
    prop:SetModel(propModel)
    prop:SetPos(car:LocalToWorld(propVector))
    prop:SetAngles(car:LocalToWorldAngles(propAngle))
    prop:Spawn()
    prop:Activate()
    prop:SetParent(car)
    prop:SetSolid(SOLID_NONE)
    prop:SetMoveType(MOVETYPE_NONE)
    

    car:CallOnRemove("RemoveProp", function(car, prop)
        if IsValid(prop) then
            prop:Remove()
        end
    end)

    prop:CallOnRemove("RemoveParent", function(prop, car)
        if IsValid(car) then
            car:Remove()
        end
    end)
end


concommand.Add("object_creator_vehicle_visual", function() 
    Object_CreatorVehicleVitroze:VisualProps(GetConVar("obcv_props"):GetString(), GetConVar("obcv_x"):GetFloat(), GetConVar("obcv_y"):GetFloat(), GetConVar("obcv_z"):GetFloat(), GetConVar("obcv_pitch"):GetFloat(), GetConVar("obcv_yaw"):GetFloat(), GetConVar("obcv_roll"):GetFloat())
end)