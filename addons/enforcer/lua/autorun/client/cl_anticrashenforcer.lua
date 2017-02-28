print("client enforcer loaded mawahhahaha")

concommand.Add("Enforcer_menu",function()

	 net.Start("Enforcer_Open_Menu")
	 net.SendToServer()
	 
end)

net.Receive("Enforcer_Open_Menu",function()

	local PropLogs = net.ReadTable()
	local DeathLogs = net.ReadTable()
	local DamageLogs = net.ReadTable()
	local LogsEnabled = 1
	
	
	if !PropLogs then return end
	if !DeathLogs then return end
	if !DamageLogs then return end
	
	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( ScrW()/2 , ScrH()/2)
	Frame:SetPos( ScrW()/2- Frame:GetWide()/2, ScrH()/2 - Frame:GetTall()/2)	
	Frame:SetTitle( "Enforcer" )
	Frame:SetSkin("nominge_skin")
	Frame:SetVisible( true )
	Frame:SetDraggable( true )
	Frame:MakePopup()
	
    local FrameSheet = vgui.Create( "DPropertySheet", Frame )
    FrameSheet:SetPos( 5, 28 )
    FrameSheet:SetSize( Frame:GetWide() - 10, Frame:GetTall() - 33 )	
	
	
    local ScanPanel = vgui.Create( "DPanel", FrameSheet )
    ScanPanel:SetPos( 5, 28 )
    ScanPanel:SetSize( FrameSheet:GetWide() - 10, FrameSheet:GetTall() - 32 )	
	
    local PropSpawnList = vgui.Create("DListView", ScanPanel)
        PropSpawnList:Clear()
        PropSpawnList:SetPos( 0, 0 )
        PropSpawnList:SetSize(ScanPanel:GetWide()- 6, ScanPanel:GetTall() - 5)
        PropSpawnList:SetMultiSelect(false)
        PropSpawnList:AddColumn("Prop Spawned")
		for k,v in pairs(PropLogs) do
				PropSpawnList:AddLine(v)
        end	
		
    local DeathPanel = vgui.Create( "DPanel", FrameSheet )
    DeathPanel:SetPos( 5, 28 )
    DeathPanel:SetSize( FrameSheet:GetWide() - 10, FrameSheet:GetTall() - 32 )	
	
    local DeathList = vgui.Create("DListView", DeathPanel)
        DeathList:Clear()
        DeathList:SetPos( 0, 0 )
        DeathList:SetSize(DeathPanel:GetWide(), DeathPanel:GetTall())
        DeathList:SetMultiSelect(false)
        DeathList:AddColumn("Death")
		for k,v in pairs(DeathLogs) do
				DeathList:AddLine(v)
        end	

    local DamagePanel = vgui.Create( "DPanel", FrameSheet )
    DamagePanel:SetPos( 5, 28 )
    DamagePanel:SetSize( FrameSheet:GetWide() - 10, FrameSheet:GetTall() - 32 )	
	
    local DamageList = vgui.Create("DListView", DamagePanel)
        DamageList:Clear()
        DamageList:SetPos( 0, 0 )
        DamageList:SetSize(DamagePanel:GetWide(), DamagePanel:GetTall())
        DamageList:SetMultiSelect(false)
        DamageList:AddColumn("Damage Log")
		for k,v in pairs(DamageLogs) do
				DamageList:AddLine(v)
        end	

    local AdminPanel = vgui.Create( "DPanel", FrameSheet )
    AdminPanel:SetPos( 5, 28 )
    AdminPanel:SetSize( FrameSheet:GetWide() - 10, FrameSheet:GetTall() - 32 )	
	
    local PlayerList = vgui.Create("DListView", AdminPanel)
        PlayerList:Clear()
        PlayerList:SetPos( 0, 0 )
        PlayerList:SetSize(AdminPanel:GetWide(), AdminPanel:GetTall() - 50)
        PlayerList:SetMultiSelect(false)
        PlayerList:AddColumn("Select A Player")
		for k,v in pairs(player.GetAll()) do
				PlayerList:AddLine(v:Nick())
        end		

	local RProps = vgui.Create( "DButton", AdminPanel )
	RProps:SetSize( AdminPanel:GetWide() - 10, 20 )
	RProps:SetPos( 5, AdminPanel:GetTall() - 50 )
	RProps:SetText( "Remove This Players Props" )
	RProps.DoClick = function( RProps )
		
	end
	RProps.DoClick = function()
        if(PlayerList:GetSelectedLine()) then
            if(PlayerList:GetLine(PlayerList:GetSelectedLine()):GetValue(1) and PlayerList:GetLine(PlayerList:GetSelectedLine()):GetValue(2)) then
				LocalPlayer():ConCommand("say !rprops "..PlayerList:GetLine(PlayerList:GetSelectedLine()):GetValue(1))
                
            end
        end
    end	
	

	local FProps = vgui.Create( "DButton", AdminPanel )
	FProps:SetSize( AdminPanel:GetWide() / 2 - 10, 20 )
	FProps:SetPos( 5, AdminPanel:GetTall() - 25 )
	FProps:SetText( "Freeze All Props" )
	FProps.DoClick = function( FProps )
		LocalPlayer():ConCommand("say","!lag")
	end	
	
	

	local FPProps = vgui.Create( "DButton", AdminPanel )
	FPProps:SetSize( AdminPanel:GetWide() / 2 - 10, 20 )
	FPProps:SetPos( AdminPanel:GetWide() - FProps:GetWide() - 5, AdminPanel:GetTall() - 25 )
	FPProps:SetText( "Freeze This Players Props" )
	FPProps.DoClick = function( FPProps )
	if(PlayerList:GetSelectedLine()) then
				if(PlayerList:GetLine(PlayerList:GetSelectedLine()):GetValue(1) and PlayerList:GetLine(PlayerList:GetSelectedLine()):GetValue(2)) then
					LocalPlayer():ConCommand("say !fprops "..PlayerList:GetLine(PlayerList:GetSelectedLine()):GetValue(1))
					
				end
			end
	end		
	
	if LogsEnabled == 1 then
    FrameSheet:AddSheet( "Prop Spawning Logs", ScanPanel, "icon16/application_view_list.png", false, false, "View Prop Logs" )		
    FrameSheet:AddSheet( "Death Logs", DeathPanel, "icon16/flag_blue.png", false, false, "View Death Logs" )			
    FrameSheet:AddSheet( "Damage Logs", DamagePanel, "icon16/bullet_red.png", false, false, "View Damage Logs" )
	end
    FrameSheet:AddSheet( "Server Control", AdminPanel, "icon16/shield.png", false, false, "Manage Your Server" )			
	

end)

concommand.Add("Enforcer_clear",function()
	EnforcerNotifications = {}
end)

EnforcerNotifications = {}

function EnforcerAddMessage( str )

	local NewNotification = {}
	NewNotification.text 	= str .. "\n\n"
	NewNotification.x		= 50
	NewNotification.y		= - 20

    timer.Create( "TimeRemove", 2, 3, function()
    table.remove( EnforcerNotifications, 1 )
    end, self)
	
	table.insert( EnforcerNotifications, NewNotification )
	
    
end


local function DrawEnforcerNotify( self, k, v, i )

	local x = v.x
	local y = v.y
	
	if ( !v.w ) then
		surface.SetFont( "TargetID" )
		v.w, v.h = surface.GetTextSize( v.text )
	end
	
	local w = v.w
	local h = v.h
	
	w = w + 16
	h = h+((i-1)*v.h)/2
	y=y+h
	
	draw.RoundedBox( 2, x-20, y, w+10, 15, Color( 0, 0, 0, 225 ) )

	surface.SetDrawColor( 255, 255, 255, 255)	
	
    surface.SetMaterial(Material("icon16/exclamation.png"))
    surface.DrawTexturedRect(x-30,y-2,18,18)

	draw.SimpleText( v.text, "TargetID", x - 5, y - 1, Color(255,255,255), TEXT_ALIGN_LEFT )

end

function EnforcerPaintNotify()

	if ( !EnforcerNotifications ) then return end
	
	while #EnforcerNotifications>10 do
		table.remove(EnforcerNotifications, 1)
	end
	local i = 0
	for k, v in pairs( EnforcerNotifications ) do
	
		if ( k != 0 ) then
		
			i = i + 1
			DrawEnforcerNotify( self, k, v, i)	         
		
		end
		
	end
end

function ManageEnforcerMessages()

	local Text = net.ReadString()
	EnforcerAddMessage(Text)
	chat.AddText(Color(255,0,0),"[Enforcer]",Color(255,255,255)," " .. Text)
	
end
net.Receive("EnforcerNotify", ManageEnforcerMessages )

hook.Add("HUDPaint","DrawEnforcerNotify",function()

	EnforcerPaintNotify()

end)