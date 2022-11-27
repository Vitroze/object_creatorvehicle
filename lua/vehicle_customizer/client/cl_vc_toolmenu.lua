hook.Add("AddToolMenuCategories", "AddToolMenuCategories_VehicleCustomizer", function()
    spawnmenu.AddToolCategory("Utilities", "Vehicule Customizer", "Vehicule Customizer")
end)

local function VehicleCustomizer_Panel(CPanel)
    CPanel:ClearControls()
    CPanel:AddControl("Header", { Description = "Vehicule Customizer allows you to generate a code for a vehicle with the props you put. This is used for example to create a flashing light ramp for example"})
    CPanel:AddControl("TextBox", {Label = "Vehicle Name", Command = "vc_name", MaxLength = "50"})
    CPanel:AddControl("TextBox", {Label = "Vehicle Category", Command = "vc_category", MaxLength = "50"})
    CPanel:AddControl("TextBox", {Label = "Vehicle Information", Command = "vc_information", MaxLength = "50"})
    CPanel:AddControl("TextBox", {Label = "Props ID", Command = "vc_props", MaxLength = "200"})

    CPanel:Help("")
    local vector = vgui.Create("DCollapsibleCategory")
    vector:SetLabel("Vector")
    vector:SetSize(100, 100)
    vector:Dock(TOP)

    CPanel:AddItem(vector)

    local CategoryContentVector = vgui.Create("DPanelList")
    CategoryContentVector:SetAutoSize(true)
    CategoryContentVector:SetDrawBackground(false)
    CategoryContentVector:SetSpacing(1)
    CategoryContentVector:SetPadding(2)
    vector:SetContents(CategoryContentVector)

    // Slider
    local SliderX = vgui.Create("DNumSlider", CPanel)
    SliderX:SetText("X")
    SliderX.Label:SetDark(true)
    SliderX:SetMin(-500)
    SliderX:SetMax(500)
    SliderX:SetDecimals(3)
    SliderX:SetConVar("vc_x")
    CategoryContentVector:AddItem(SliderX)

    local SliderY = vgui.Create("DNumSlider", CPanel)
    SliderY:SetText("Y")
    SliderY.Label:SetDark(true)
    SliderY:SetMin(-500)
    SliderY:SetMax(500)
    SliderY:SetDecimals(3)
    SliderY:SetConVar("vc_y")
    CategoryContentVector:AddItem(SliderY)

    local SliderZ = vgui.Create("DNumSlider", CPanel)
    SliderZ:SetText("Z")
    SliderZ.Label:SetDark(true)
    SliderZ:SetMin(-500)
    SliderZ:SetMax(500)
    SliderZ:SetDecimals(3)
    SliderZ:SetConVar("vc_z")
    CategoryContentVector:AddItem(SliderZ)

    CPanel:Help("")
    local angle = vgui.Create("DCollapsibleCategory")
    angle:SetLabel("Angle")
    angle:SetSize(100, 100)
    angle:Dock(TOP)
    
    CPanel:AddItem(angle)

    local CategoryContentAngle = vgui.Create("DPanelList")
    CategoryContentAngle:SetAutoSize(true)
    CategoryContentAngle:SetDrawBackground(false)
    CategoryContentAngle:SetSpacing(1)
    CategoryContentAngle:SetPadding(2)
    angle:SetContents(CategoryContentAngle)

    // Slider
    local SliderPitch = vgui.Create("DNumSlider", CPanel)
    SliderPitch:SetText("Pitch")
    SliderPitch.Label:SetDark(true)
    SliderPitch:SetMin(-360)
    SliderPitch:SetMax(360)
    SliderPitch:SetDecimals(3)
    SliderPitch:SetConVar("vc_pitch")
    CategoryContentAngle:AddItem(SliderPitch)

    local SliderYaw = vgui.Create("DNumSlider", CPanel)
    SliderYaw:SetText("Yaw")
    SliderYaw.Label:SetDark(true)
    SliderYaw:SetMin(-360)
    SliderYaw:SetMax(360)
    SliderYaw:SetDecimals(3)
    SliderYaw:SetConVar("vc_yaw")
    CategoryContentAngle:AddItem(SliderYaw)

    local SliderRoll = vgui.Create("DNumSlider", CPanel)
    SliderRoll:SetText("Roll")
    SliderRoll.Label:SetDark(true)
    SliderRoll:SetMin(-360)
    SliderRoll:SetMax(360)
    SliderRoll:SetDecimals(3)
    SliderRoll:SetConVar("vc_roll")
    CategoryContentAngle:AddItem(SliderRoll)

    // Put multi props in the car

    local multiprops = vgui.Create("DCollapsibleCategory")
    multiprops:SetLabel("Multi Props")
    multiprops:SetSize(100, 100)
    multiprops:Dock(TOP)
    multiprops:SetExpanded(false)
    CPanel:AddItem(multiprops)

    local CategoryContentMultiProps = vgui.Create("DPanelList")
    CategoryContentMultiProps:SetAutoSize(true)
    CategoryContentMultiProps:SetDrawBackground(false)
    CategoryContentMultiProps:SetSpacing(1)
    CategoryContentMultiProps:SetPadding(2)
    multiprops:SetContents(CategoryContentMultiProps)

    local int = 1
    local function AddProp()

        local props = vgui.Create("DCollapsibleCategory", CPanel)
        props:SetLabel("Prop "..int)
        props:SetSize(100, 100)
        props:Dock(TOP)
        props:DockMargin(0, 5, 0, 0)

        CategoryContentMultiProps:AddItem(props)

        local CategoryContentProps = vgui.Create("DPanelList", CPanel)
        CategoryContentProps:SetAutoSize(true)
        CategoryContentProps:SetDrawBackground(false)
        CategoryContentProps:SetSpacing(1)
        CategoryContentProps:SetPadding(2)
        props:SetContents(CategoryContentProps)
        
		local PanelProps = vgui.Create("Panel")
		PanelProps:SetWide(CPanel:GetWide())
		PanelProps:SetTall(75)
		CategoryContentProps:AddItem(PanelProps)

        local PropID_Label = vgui.Create("DLabel", PanelProps)
		PropID_Label:SetText("Prop ID")
		PropID_Label:SizeToContents()
		PropID_Label:SetDark(true)
		PropID_Label:SetPos(0,7)

		local PropID_TextEntry = vgui.Create("DTextEntry", PanelProps)
		PropID_TextEntry:SetWide(PanelProps:GetWide()-95)
		PropID_TextEntry:SetPos(55, 5)
		PropID_TextEntry:SetUpdateOnType(true)
        PropID_TextEntry:SetConVar("vc_prop_all"..int)

        local vector = vgui.Create("DCollapsibleCategory")
        vector:SetLabel("Vector")
        vector:SetSize(100, 100)
        vector:Dock(TOP)
        vector:DockMargin(0, 40, 0, 0)

        CategoryContentProps:AddItem(vector)

        local CategoryContentVector = vgui.Create("DPanelList")
        CategoryContentVector:SetAutoSize(true)
        CategoryContentVector:SetDrawBackground(false)
        CategoryContentVector:SetSpacing(1)
        CategoryContentVector:SetPadding(2)
        vector:SetContents(CategoryContentVector)

        // Slider
        local SliderX_Props = vgui.Create("DNumSlider", CategoryContentProps)
        SliderX_Props:SetText("X")
        SliderX_Props.Label:SetDark(true)
        SliderX_Props:SetMin(-500)
        SliderX_Props:SetMax(500)
        SliderX_Props:SetDecimals(3)
        SliderX_Props:SetConVar("vc_x"..int)
        CategoryContentVector:AddItem(SliderX_Props)

        local SliderY_Props = vgui.Create("DNumSlider", CategoryContentProps)
        SliderY_Props:SetText("Y")
        SliderY_Props.Label:SetDark(true)
        SliderY_Props:SetMin(-500)
        SliderY_Props:SetMax(500)
        SliderY_Props:SetDecimals(3)
        SliderY_Props:SetConVar("vc_y"..int)
        CategoryContentVector:AddItem(SliderY_Props)

        local SliderZ = vgui.Create("DNumSlider", CategoryContentProps)
        SliderZ:SetText("Z")
        SliderZ.Label:SetDark(true)
        SliderZ:SetMin(-500)
        SliderZ:SetMax(500)
        SliderZ:SetDecimals(3)
        SliderZ:SetConVar("vc_z")
        CategoryContentVector:AddItem(SliderZ)

        local angle = vgui.Create("DCollapsibleCategory")
        angle:SetLabel("Angle")
        angle:SetSize(100, 100)
        angle:Dock(TOP)
        angle:DockMargin(0, 10, 0, 0)

        
        CategoryContentProps:AddItem(angle)

        local CategoryContentAngle = vgui.Create("DPanelList")
        CategoryContentAngle:SetAutoSize(true)
        CategoryContentAngle:SetDrawBackground(false)
        CategoryContentAngle:SetSpacing(1)
        CategoryContentAngle:SetPadding(2)
        angle:SetContents(CategoryContentAngle)

        // Slider
        local SliderPitch = vgui.Create("DNumSlider", CategoryContentProps)
        SliderPitch:SetText("Pitch")
        SliderPitch.Label:SetDark(true)
        SliderPitch:SetMin(-360)
        SliderPitch:SetMax(360)
        SliderPitch:SetDecimals(3)
        SliderPitch:SetConVar("vc_pitch")
        CategoryContentAngle:AddItem(SliderPitch)

        local SliderYaw = vgui.Create("DNumSlider", CategoryContentProps)
        SliderYaw:SetText("Yaw")
        SliderYaw.Label:SetDark(true)
        SliderYaw:SetMin(-360)
        SliderYaw:SetMax(360)
        SliderYaw:SetDecimals(3)
        SliderYaw:SetConVar("vc_yaw")
        CategoryContentAngle:AddItem(SliderYaw)

        local SliderRoll = vgui.Create("DNumSlider", CategoryContentProps)
        SliderRoll:SetText("Roll")
        SliderRoll.Label:SetDark(true)
        SliderRoll:SetMin(-360)
        SliderRoll:SetMax(360)
        SliderRoll:SetDecimals(3)
        SliderRoll:SetConVar("vc_roll")
        CategoryContentAngle:AddItem(SliderRoll)


        print(SliderX_Props:GetValue())
        // Setup table 
        local propall = {
            {
                PropID = PropID_TextEntry:GetValue(),
                Vector = Vector(SliderX_Props:GetValue(), SliderY_Props:GetValue(), SliderZ:GetValue()),
                Angle = Angle(SliderPitch:GetValue(), SliderYaw:GetValue(), SliderRoll:GetValue())
            }
        }

        PrintTable(propall)

        concommand.Add("dev", function(ply, cmd, args)
            print(SliderX_Props:GetValue(), SliderY_Props:GetValue(), SliderZ:GetValue())
        end)
        int = int + 1
    end

    local AddPropButton = vgui.Create("DButton", CPanel)
    AddPropButton:SetText("Add Prop")
    AddPropButton:Dock(TOP)
    AddPropButton.DoClick = function()
        AddProp()
    end
    CategoryContentMultiProps:AddItem(AddPropButton)

    CPanel:AddControl("Button", { Text = "Visual", Command = "object_creator_vehicle_visual"})
    CPanel:AddControl("Button", { Text = "Generate code", Command = "object_creator_vehicle_generate_code" })

end

hook.Add("PopulateToolMenu", "PopulateToolMenu_VehicleCustomizer", function()
    spawnmenu.AddToolMenuOption("Utilities", "Vehicule Customizer", "Vehicule Customizer", "Vehicule Customizer", "", "", VehicleCustomizer_Panel)
end)

CreateClientConVar("vc_name", "", false, false)
CreateClientConVar("vc_category", "", false, false)
CreateClientConVar("vc_information", "", false, false)
CreateClientConVar("vc_props", "", false, false)

CreateClientConVar("vc_x", 0, false, false)
CreateClientConVar("vc_y", 0, false, false)
CreateClientConVar("vc_z", 0, false, false)

CreateClientConVar("vc_pitch", 0, false, false)
CreateClientConVar("vc_yaw", 0, false, false)
CreateClientConVar("vc_roll", 0, false, false)

