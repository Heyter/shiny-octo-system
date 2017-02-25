--#noSimplerr#



hook.Call("RebuildInventory",nil,LocalPlayer())
PANEL = {}

function PANEL:Init()

	self:SetSize(560,414)
	self:Center()
	self:SetTitle('Инвентарь')
	self:SetSizable(false)
	self.Paint = function(w,h)
		draw.RoundedBox(1,0,0,560,414,Color(70,45,23,255))
	end
	self.Scroll = vgui.Create( "DScrollPanel", self )
	self.Scroll:SetSize(540,372)
	self.Scroll:SetPos(10,40)

	self.DLayout = vgui.Create("DIconLayout",self.Scroll)
	self.DLayout:SetSize(540,372)
	self.DLayout:SetPos(0,0)
	self.DLayout:SetSpaceX(5)
	self.DLayout:SetSpaceY(5)
	self.DLayout.numberOfItems = 0
	self.DLayout.OnModified = function()
			ListItem = self.DLayout:Add( "DPanel" )
			ListItem:SetSize( 100,120 ) 
			ListItem.Paint = function(hui,w,h)

				draw.RoundedBox( 0, 0, 0, w, h, Color(227, 210, 161, 255) )
			end

		
	end



	self:MakePopup()
	self:MakeList()
end

function PANEL:MakeList()
	for i,k in pairs(cl_inv) do 
		self.DLayout.numberOfItems = self.DLayout.numberOfItems + 1
		ListItem = self.DLayout:Add( "DPanel" ) 
		self:ProcessPanel(ListItem,i,"item")
		
	end
	for c = self.DLayout.numberOfItems,29 do
		ListItem = self.DLayout:Add( "DPanel" )
		ListItem:SetSize( 100,120 )
		ListItem.Paint = function(hui,w,h)

				draw.RoundedBox( 0, 0, 0, w, h, Color(227, 210, 161, 255) )
			end 

	end

end


function PANEL:ProcessPanel(panel, itemk, type)
	panel.jaba = false
	local w = 100
	local h = 120
	panel.Paint = function(hui,w,h)

		draw.RoundedBox( 0, 0, 0, w, h, Color(227, 210, 161, 255) )

		if panel.jaba == false then
			draw.RoundedBox( 0, 0, 0, w, h, Color(227, 210, 161, 255) )
		else
			draw.RoundedBox( 0, 0, 0, w, h, Color(186, 175, 140, 255) )
		end
	end




	--Здесь может быть self.Paint для перекрашивания и десигна итемов инвентаря

	local model = ""
	local namestr = ""
	if type == "item" then
		local item = cl_inv[itemk]
		model = item.model
		namestr = item.name

		dropf = function()
			net.Start( "dropitem" )
				net.WriteBool(false)
				net.WriteInt(itemk,32)
			net.SendToServer()
			self.DLayout.numberOfItems = self.DLayout.numberOfItems - 1
			panel:Remove()
			self.DLayout:OnModified()
		end

		usef = function()
			net.Start( "dropitem" )
				net.WriteBool(true)
				net.WriteInt(itemk,32)
			net.SendToServer()
			self.DLayout.numberOfItems = self.DLayout.numberOfItems - 1
			panel:Remove()
			self.DLayout:OnModified()
		end
	end

	panel:SetSize( w,h ) 
	local icon = vgui.Create("SpawnIcon", panel)
		icon:SetModel(model)
		icon:SetPos(5,5)
		icon:SetSize(w-10,w-30)
		icon:SetMouseInputEnabled(false)

	local name = vgui.Create("DLabel", panel)
		name:SetTextColor(Color(0,0,0))
		name:SetText(namestr)
		name:SizeToContents()
		name:SetPos((w/2)-name:GetWide()/2, h-20)

	local drop = vgui.Create("DButton", panel)
		drop:SetSize(((w/2)-10), 25)
		drop:SetPos(5, h-30)
		drop:SetText("Drop")
		drop.DoClick =  dropf
		drop:SetVisible(false)

	local use = vgui.Create("DButton", panel)
		use:SetSize(((w/2)-10), 25)
		use:SetPos((w/2)+5, h-30)
		use:SetText("Use")
		use.DoClick = usef
		use:SetVisible(false)

	panel.OnCursorEntered = function()
		panel.jaba = true
		name:SetVisible(false)
		drop:SetVisible(true)
		use:SetVisible(true)
	end

	panel.OnCursorExited = function()
		if not panel:IsChildHovered( true ) then 
			panel.jaba = false
			name:SetVisible(true)
			drop:SetVisible(false)
			use:SetVisible(false)
		end

	end

end

function PANEL:Close()
	self:SetVisible(false)
	self:Remove()
end

vgui.Register( "InvMenu", PANEL, "DFrame" )



local function Show()
	InvMenu = vgui.Create("InvMenu")
	InvMenu:SetVisible(true)

end

concommand.Add("drp_showinv", Show)

