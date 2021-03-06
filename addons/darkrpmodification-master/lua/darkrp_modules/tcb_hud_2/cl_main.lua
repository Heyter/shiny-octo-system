/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/
--#NoSimplerr#

surface.CreateFont( "HUDLarge", {
	font = "Trebuchet MS",
	size = 28,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "HUDSemiLarge", {
	font = "Trebuchet MS",
	size = 23,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "HUDMedium", {
	font = "Trebuchet MS",
	size = 19,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "HUDSmall", {
	font = "Trebuchet MS",
	size = 16,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )




/*--  HUD Settings --*/
local 	HUD = {}
local localplayer = LocalPlayer()
-- Edit settings here.
HUD.X = "left" 			-- left / center / right
HUD.Y = "bottom"; 		-- bottom / center / top

HUD.HealthColor = Color(192, 57, 43, 255)
HUD.ArmorColor 	= Color(41, 128, 185, 255)

-- Don't edit anything below this line.
HUD.Width 	= 350
HUD.Height 	= 150

HUD.Border 	= 15

HUD.PosX 	= 0
HUD.PosY	= 0

/*--  Hide Default HUD Elements --*/
local hideHUDElements = {
	["DarkRP_HUD"]				= true,
	["DarkRP_EntityDisplay"] 	= true,
	["DarkRP_ZombieInfo"] 		= true,
	["DarkRP_LocalPlayerHUD"] 	= true,
	["DarkRP_Hungermod"] 		= true,
	["DarkRP_Agenda"] 			= true,
}

/*-- Hide HUD Elements --*/
local function hideElements(name)

	if name == "CHudHealth" or name == "CHudBattery" or name == "CHudSuitPower" then
		return false
	end
	
	if hideHUDElements[name] then
		return false
	end
	
end
hook.Add("HUDShouldDraw", "hideElements", hideElements)

/*-- Process Settings --*/
if HUD.X == "left" then
	HUD.PosX = HUD.Border
elseif HUD.X == "center" then
	HUD.PosX = ScrW() / 2 - HUD.Width / 2
elseif HUD.X == "right" then
	HUD.PosX = ScrW() - HUD.Border
else
	HUD.PosX = HUD.Border
end

if HUD.Y == "bottom" then
	HUD.PosY = ScrH() - HUD.Height - HUD.Border
elseif HUD.Y == "center" then
	HUD.PosY = ScrH() / 2 - HUD.Height / 2
elseif HUD.Y == "top" then
		HUD.PosY = HUD.Border
else
	HUD.PosY = ScrH() - Border
end

/*-- Format Number Function --*/
local function formatNumber(n)
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
	n = tostring(n)
	local sep = sep or ","
	local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
	end
	return n
end

/*-- HUD Elements --*/

HUD.BHeight = HUD.Height / 2 - 15
HUD.BPosY = HUD.PosY + HUD.Height / 2 + HUD.Border

HUD.BHeight1 = HUD.BHeight / 2 - 10
HUD.BPosY1 = HUD.BPosY + 3
HUD.BPosY2 = HUD.BPosY + 27

HUD.BarWidth = HUD.Width - 120

HUD.HHeight = HUD.Height / 2 + 11

local function Base()
	
	-- Background
	draw.RoundedBox(3, HUD.PosX-1, HUD.PosY-1, HUD.Width+2, HUD.Height+2, Color(56,38,22,255))
	draw.RoundedBox(3, HUD.PosX, HUD.PosY, HUD.Width, HUD.Height, Color(56,38,22,255))

	-- Sections
	draw.RoundedBoxEx(3, HUD.PosX, HUD.BPosY, HUD.Width, HUD.BHeight, Color(69,46,27,255), false, false, true, true)
	draw.RoundedBoxEx(3, HUD.PosX + HUD.Width - 50, HUD.PosY, 50, HUD.HHeight, Color(69,46,27,255), false, true, false, false)
	draw.RoundedBoxEx(3, HUD.PosX, HUD.PosY, 75, HUD.HHeight, Color(69,46,27,255), true, false, false, false)
	
	-- Borders
	draw.RoundedBox(0, HUD.PosX, HUD.BPosY-4, HUD.Width, 2, Color(43,29,17,255))
	draw.RoundedBox(0, HUD.PosX, HUD.BPosY-2, HUD.Width, 2, Color(84,57,34,255))

	draw.RoundedBox(0, HUD.PosX+77, HUD.BPosY-45, 220, 2, Color(43,29,17,255))
	draw.RoundedBox(0, HUD.PosX+77, HUD.BPosY-43, 220, 2, Color(84,57,34,255))
	
	draw.RoundedBox(0, HUD.PosX + HUD.Width - 50 - 4, HUD.PosY, 2, HUD.HHeight, Color(43,29,17,255))
	draw.RoundedBox(0, HUD.PosX + HUD.Width - 50 - 2, HUD.PosY, 2, HUD.HHeight, Color(84,57,34,255))
	
	draw.RoundedBox(0, HUD.PosX + 75 + 2, HUD.PosY, 2, HUD.HHeight, Color(43,29,17,255))
	draw.RoundedBox(0, HUD.PosX + 75, HUD.PosY, 2, HUD.HHeight, Color(84,57,34,255))
	
end

local timeSinceLastHUDPaint = 0

local function PlayerModelF()

	PlayerModel = vgui.Create("DModelPanel")
	PlayerModel:SetModel(  LocalPlayer():GetModel() )
	PlayerModel:SetPos(HUD.PosX, HUD.PosY)
	PlayerModel:SetSize(75, 85)
	PlayerModel:SetCamPos(Vector( 16, 0, 65 ))
	PlayerModel:SetLookAt(Vector( 0, 0, 65 ))
	--PlayerModel:SetVisible(false)
	PlayerModel:SetPaintedManually(true)
	timer.Create("ModelUpdater101",1,0,function()
		if LocalPlayer():GetModel() != PlayerModel.Entity:GetModel() then
			PlayerModel:Remove()
			PlayerModel = vgui.Create("DModelPanel")
			function PlayerModel:LayoutEntity( Entity ) return end         
			PlayerModel:SetModel( LocalPlayer():GetModel())
			PlayerModel:SetPos(HUD.PosX, HUD.PosY)
			PlayerModel:SetSize(75, 85)
			PlayerModel:SetCamPos(Vector( 16, 0, 65 ))
			PlayerModel:SetLookAt(Vector( 0, 0, 65 ))
			PlayerModel:SetPaintedManually(true)
 			end
 	end)
end

hook.Add("InitPostEntity", "PlayerModel", PlayerModelF)

local function Health()
	
	-- Values
	local Health = LocalPlayer():Health() or 0
	local FullHealth = LocalPlayer():Health() or 0
	if Health < 0 then Health = 0 elseif Health > 100 then Health = 100 end
	local DrawHealth = math.Min(Health/GAMEMODE.Config.startinghealth, 1)
	
	-- Title
--	draw.DrawText("ЗДОРОВЬЕ", "HUDSmall", HUD.PosX + 6 + 1, HUD.BPosY1 + 6 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
--	draw.DrawText("ЗДОРОВЬЕ", "HUDSmall", HUD.PosX + 6, HUD.BPosY1 + 6, Color(245, 206, 34, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	-- Background Bar
	draw.RoundedBox(4, HUD.PosX + 110, HUD.BPosY1 + 5, HUD.BarWidth, HUD.BHeight1, Color(30,30,30,255))
	
	-- Bar
	if Health != 0 then
		draw.RoundedBox(4, HUD.PosX + 110 + 1, HUD.BPosY1 + 5 + 1, (HUD.BarWidth - 2) * DrawHealth, HUD.BHeight1 - 2, HUD.HealthColor)
	end
	
	draw.DrawText(FullHealth, "HUDMedium", HUD.PosX + 110 + HUD.BarWidth / 2, HUD.BPosY1 + 6 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(FullHealth, "HUDMedium", HUD.PosX + 110 + HUD.BarWidth / 2, HUD.BPosY1 + 6, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
end

local function Armor()
	
	-- Values
	local Armor = LocalPlayer():Armor() or 0
	local FullArmor = LocalPlayer():Armor() or 0
	if Armor < 0 then Armor = 0 elseif Armor > 100 then Armor = 100 end
	
	-- Title
--	draw.DrawText("БРОНЯ", "HUDSmall", HUD.PosX + 15 + 1, HUD.BPosY2 + 6 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
--	draw.DrawText("БРОНЯ", "HUDSmall", HUD.PosX + 15, HUD.BPosY2 + 6, Color(245, 206, 34, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	-- Background Bar
	draw.RoundedBox(4, HUD.PosX + 110, HUD.BPosY2 + 5, HUD.BarWidth, HUD.BHeight1, Color(30,30,30,255))
	
	-- Bar
	if Armor != 0 then
		draw.RoundedBox(4, HUD.PosX + 110 + 1, HUD.BPosY2 + 5 + 1, (HUD.BarWidth - 2) * Armor / 100, HUD.BHeight1 - 2, HUD.ArmorColor)
	end
	
	draw.DrawText(Armor, "HUDMedium", HUD.PosX + 110 + HUD.BarWidth / 2, HUD.BPosY2 + 6 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(Armor, "HUDMedium", HUD.PosX + 110 + HUD.BarWidth / 2, HUD.BPosY2 + 6, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
end

local function PlayerInfo()


	-- Values
	local VAL_Name 		= LocalPlayer():Nick() or ""
	local VAL_Job 		= LocalPlayer():getDarkRPVar("job") or ""
	local VAL_Wallet 	= "$"..formatNumber(LocalPlayer():getDarkRPVar("money") or 0)
	local VAL_Salary 	= "$"..formatNumber(LocalPlayer():getDarkRPVar("salary") or 0)

	-- Name
--	draw.DrawText("ИМЯ: ", "HUDSmall", HUD.PosX + 85 + 1, HUD.PosY + 18 * 0 + 2.5 * 1 + 1, Color(0, 0, 0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
--	draw.DrawText("ИМЯ: ", "HUDSmall", HUD.PosX + 85, HUD.PosY + 18 * 0 + 2.5 * 1, Color(245, 206, 34, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.DrawText(VAL_Name, "HUDSemiLarge", HUD.PosX + 95 + 1, HUD.PosY + 12, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.DrawText(VAL_Name, "HUDSemiLarge", HUD.PosX + 95, HUD.PosY + 12, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	-- Job
--	draw.DrawText("РАБОТА: ", "HUDSmall", HUD.PosX + 85 + 1, HUD.PosY + 18 * 1 + 2.5 * 2 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
--	draw.DrawText("РАБОТА: ", "HUDSmall", HUD.PosX + 85, HUD.PosY + 18 * 1 + 2.5 * 2, Color(245, 206, 34, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.DrawText(VAL_Job, "HUDMedium", HUD.PosX + 95 + 1, HUD.PosY + 57, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.DrawText(VAL_Job, "HUDMedium", HUD.PosX + 95, HUD.PosY + 57,  team.GetColor(LocalPlayer():Team()), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	-- Wallet
--	draw.DrawText("НАЛИЧНЫЕ: ", "HUDSmall", HUD.PosX + 85 + 1, HUD.PosY + 18 * 2 + 2.5 * 3 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
--	draw.DrawText("НАЛИЧНЫЕ: ", "HUDSmall", HUD.PosX + 85, HUD.PosY + 18 * 2 + 2.5 * 3, Color(245, 206, 34, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.DrawText(VAL_Wallet, "HUDSemiLarge", HUD.PosX + 9 + 1, HUD.PosY + 96, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.DrawText(VAL_Wallet, "HUDSemiLarge", HUD.PosX + 9, HUD.PosY + 96, Color(75, 229, 126, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	-- Salary
--	draw.DrawText("ЗАРПЛАТА: ", "HUDSmall", HUD.PosX + 85 + 1, HUD.PosY + 18 * 3 + 2.5 * 4 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
--	draw.DrawText("ЗАРПЛАТА: ", "HUDSmall", HUD.PosX + 85, HUD.PosY + 18 * 3 + 2.5 * 4, Color(245, 206, 34, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.DrawText(VAL_Salary, "HUDMedium", HUD.PosX + 9 + 1, HUD.PosY + 124, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.DrawText(VAL_Salary, "HUDMedium", HUD.PosX + 9, HUD.PosY + 124, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

end

local IconLicense 	= "icon16/page_red.png"
local IconWanted	= "icon16/exclamation.png"
local IconName      = "icon16/user.png"
local IconJob       = "icon16/lightbulb.png"
local IconCash      = "icon16/money_dollar.png"
local IconSallary   = "icon16/money_add.png"

local function PlayerIcons()

	if LocalPlayer():getDarkRPVar("HasGunlicense") then
		surface.SetDrawColor(255,255,255,255)
	else
		surface.SetDrawColor(25,25,25,255)
	end
	surface.SetMaterial(Material(IconLicense))
	surface.DrawTexturedRect( HUD.PosX + HUD.Width - 50 + 15, HUD.PosY + 20, 20, 20)
	
	if LocalPlayer():getDarkRPVar("wanted") then
		surface.SetDrawColor(255,255,255,255)
	else
		surface.SetDrawColor(25,25,25,255)
	end
	surface.SetMaterial(Material(IconWanted))
	surface.DrawTexturedRect( HUD.PosX + HUD.Width - 50 + 15, HUD.PosY + 50, 20, 20)

	--surface.SetDrawColor(255,255,255,255)
	--surface.SetMaterial(Material(IconCash))
	--surface.DrawTexturedRect( HUD.PosX - 310 + HUD.Width - 50 + 15, HUD.PosY + 97, 18, 18)

	--surface.SetDrawColor(255,255,255,255)
	--surface.SetMaterial(Material(IconSallary))
	--surface.DrawTexturedRect( HUD.PosX - 310 + HUD.Width - 50 + 15, HUD.PosY + 124, 18, 18)
end

/*-- Default HUD Elements --*/

local function Agenda()
	local agenda = LocalPlayer():getAgendaTable()
	if not agenda then return end

	draw.RoundedBox(3, 10, 10, 403, 90, Color(36, 36, 36, 255 ))
	draw.RoundedBox(3, 12, 12, 400, 87, Color(84, 57, 34, 255))
	draw.RoundedBox(3, 12, 12, 400, 20, Color(43, 29, 17, 255))

	draw.DrawNonParsedText(agenda.Title, "HUDSmall", 30, 12, Color(245, 206, 34, 255 ), 0)

	local text = LocalPlayer():getDarkRPVar("agenda") or ""

	text = text:gsub("//", "\n"):gsub("\\n", "\n")
	text = DarkRP.textWrap(text, "HUDSmall", 375)
	draw.DrawNonParsedText(text, "HUDSmall", 20, 15, Color(255, 255, 255, 255), 0)
end

local VoiceChatTexture = surface.GetTextureID("voice/icntlk_pl")
local function DrawVoiceChat()
	if LocalPlayer().DRPIsTalking then
		local chbxX, chboxY = chat.GetChatBoxPos()

		local Rotating = math.sin(CurTime()*3)
		local backwards = 0
		if Rotating < 0 then
			Rotating = 1-(1+Rotating)
			backwards = 180
		end
		surface.SetTexture(VoiceChatTexture)
		surface.SetDrawColor(Color(140,0,0,180))
		surface.DrawTexturedRectRotated(ScrW() - 100, chboxY, Rotating*96, 96, backwards)
	end
end

CreateConVar("DarkRP_LockDown", 0, {FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE})
local function LockDown()
	local chbxX, chboxY = chat.GetChatBoxPos()
	if util.tobool(GetConVarNumber("DarkRP_LockDown")) then
		local cin = (math.sin(CurTime()) + 1) / 2
		local chatBoxSize = math.floor(ScrH() / 4)
		draw.DrawNonParsedText(DarkRP.getPhrase("lockdown_started"), "ScoreboardSubtitle", chbxX, chboxY + chatBoxSize, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_LEFT)
	end
end

if HUD.Y != "top" then
	ArrestedY = HUD.PosY - 23
	ArrestedX = HUD.PosX + HUD.Width / 2
else
	ArrestedY = ScrH() - ScrH()/12
	ArrestedX = ScrW()/2
end

local Arrested = function() end

usermessage.Hook("GotArrested", function(msg)
	local StartArrested = CurTime()
	local ArrestedUntil = msg:ReadFloat()

	Arrested = function()
		if CurTime() - StartArrested <= ArrestedUntil and LocalPlayer():getDarkRPVar("Arrested") then
		draw.DrawNonParsedText(DarkRP.getPhrase("youre_arrested", math.ceil(ArrestedUntil - (CurTime() - StartArrested))), "DarkRPHUD1", ArrestedX, ArrestedY, Color(255, 255, 255, 255), 1)
		elseif not LocalPlayer():getDarkRPVar("Arrested") then
			Arrested = function() end
		end
	end
end)

local AdminTell = function() end

usermessage.Hook("AdminTell", function(msg)
	timer.Destroy("DarkRP_AdminTell")
	local Message = msg:ReadString()

	AdminTell = function()
		draw.RoundedBox(4, 10, 10, ScrW() - 20, 100, Color(0, 0, 0, 200))
		draw.DrawNonParsedText(DarkRP.getPhrase("listen_up"), "GModToolName", ScrW() / 2 + 10, 10, Color(255, 255, 255, 255), 1)
		draw.DrawNonParsedText(Message, "ChatFont", ScrW() / 2 + 10, 80, Color(200, 30, 30, 255), 1)
	end

	timer.Create("DarkRP_AdminTell", 10, 1, function()
		AdminTell = function() end
	end)
end)

local function DrawPlayerInfo(ply)
	local pos = ply:EyePos()

	pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
	pos = pos:ToScreen()
	pos.y = pos.y - 50 -- Move the text up a few pixels to compensate for the height of the text

	-- Background
	draw.RoundedBox(4, pos.x - 101, pos.y-1, 200+2, 65+2, Color(43,29,17,150))
	draw.RoundedBox(4, pos.x - 100, pos.y, 200, 65, Color(56,38,22,150))
	
	draw.RoundedBoxEx(4, pos.x - 100, pos.y, 200, 80 / 3, Color(71, 49, 29,150), true, true, false, false)
	
	draw.RoundedBox(0, pos.x - 100, pos.y + 80/3+2, 200, 2, Color(43,29,17,150))
	draw.RoundedBox(0, pos.x - 100, pos.y + 80/3+0, 200, 2, Color(71, 49, 29,150))
	
	-- Info
	
	draw.DrawText(ply:Nick(), "TCB_F4Menu_Medium", pos.x + 1, pos.y + 5 + 1, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(ply:Nick(), "TCB_F4Menu_Medium", pos.x, pos.y + 5, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	draw.DrawText(DarkRP.getPhrase("health", ply:Health()), "TCB_F4Menu_Small", pos.x, pos.y + 31, Color(192, 57, 43, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	local teamname = team.GetName(ply:Team())
	draw.DrawText("Работа: "..ply:getDarkRPVar("job") or teamname, "TCB_F4Menu_Small", pos.x, pos.y + 46, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	if ply:getDarkRPVar("HasGunlicense") then
		surface.SetMaterial(Material(IconLicense))
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(pos.x - 93, pos.y + 32, 16, 16)
	else
		surface.SetMaterial(Material(IconLicense))
		surface.SetDrawColor(25,25,25,255)
		surface.DrawTexturedRect(pos.x - 93, pos.y + 30, 16, 16)
	end

end

local function DrawWantedInfo(ply)
	if not ply:Alive() then return end

	local pos = ply:EyePos()

	pos.z = pos.z + 10
	pos = pos:ToScreen()
	pos.y = pos.y - 50
	
	local wantedText = "РАЗЫСКИВАЕТСЯ" --DarkRP.getPhrase("wanted", tostring(ply:getDarkRPVar("wantedReason")))
	
	draw.RoundedBox(4, pos.x - 85, pos.y - 40 - 5, 170+2, 30+2, Color(43,29,17,255))
	draw.RoundedBox(4, pos.x - 84, pos.y - 39 - 5, 170, 30, Color(56,38,22,255))
	
	draw.DrawText(wantedText, "TCB_F4Menu_Medium", pos.x + 1, pos.y - 39, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(wantedText, "TCB_F4Menu_Medium", pos.x, pos.y - 40, Color(255, 0, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function DrawEntityDisplay()
	local shootPos = LocalPlayer():GetShootPos()
	local aimVec = LocalPlayer():GetAimVector()

	for k, ply in pairs(players or player.GetAll()) do
		if not ply:Alive() or ply == LocalPlayer() then continue end
		local hisPos = ply:GetShootPos()
		if ply:getDarkRPVar("wanted") and hisPos:DistToSqr(shootPos) < 160000 then DrawWantedInfo(ply) end

		if GAMEMODE.Config.globalshow then
			DrawPlayerInfo(ply)
		-- Draw when you're (almost) looking at him
		elseif not GAMEMODE.Config.globalshow and hisPos:DistToSqr(shootPos) < 160000 then
			local pos = hisPos - shootPos
			local unitPos = pos:GetNormalized()
			if unitPos:Dot(aimVec) > 0.95 then
				local trace = util.QuickTrace(shootPos, pos, LocalPlayer())
				if trace.Hit and trace.Entity ~= ply then return end
				DrawPlayerInfo(ply)
			end
		end
	end

	local tr = LocalPlayer():GetEyeTrace()

	if IsValid(tr.Entity) and tr.Entity:isKeysOwnable() and tr.Entity:GetPos():Distance(LocalPlayer():GetPos()) < 200 then
		tr.Entity:drawOwnableInfo()
	end
end

function GAMEMODE:DrawDeathNotice(x, y)
	if not GAMEMODE.Config.showdeaths then return end
	self.BaseClass:DrawDeathNotice(x, y)
end

local function DisplayNotify(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("buttons/lightswitch2.wav")

	-- Log to client console
	print(txt)
end
usermessage.Hook("_Notify", DisplayNotify)

function DisableDrawInfo()
	return false
end
hook.Add("HUDDrawTargetID", "DisableDrawInfo", DisableDrawInfo)

hook.Add("HUDDrawDoorData","Disabledoordraw",function( )
	return true
end)


/*-- Draw HUD Elements --*/
local function DrawTCB()
	
	-- Custom
	Base()
	Health()
	Armor()
	PlayerInfo()
	PlayerIcons()
	
	-- Default
	Agenda()
	DrawVoiceChat()
	LockDown()
	
	Arrested()
	AdminTell()
	--
	DrawEntityDisplay()
	PlayerModel:PaintManual()


	
	
end
hook.Add("HUDPaint", "DrawTCB", DrawTCB)

maxDist = 400
function DrawDoorHUD()
    local shouldDraw = hook.Call("HUDShouldDraw", GAMEMODE, "ElegantHUD_Door_Titles")
    if shouldDraw == false then return end
 
    if !LocalPlayer() then return end
    local inSphere = ents.FindInSphere(LocalPlayer():GetPos(),maxDist)
 
    surface.SetTextColor(255, 255, 255, 255)
 
    for k,v in pairs(inSphere) do
           
        if IsValid(v) and v:isKeysOwnable() and !v:IsVehicle() then
               
            local dist = LocalPlayer():GetPos():Distance(v:GetPos())
           
           
            local s = LocalPlayer():LocalToWorld(LocalPlayer():OBBCenter())
            local e = v:LocalToWorld(v:OBBCenter()) 

            s.z = e.z
   
            local trace = {}
            trace.start = s
            trace.endpos = e
            local t = {}
            for i,ent in pairs(inSphere) do
                if ent != LocalPlayer() && ent != v then
                    table.insert(t,ent)
                end
            end
            trace.filter = t
            trace = util.TraceLine(trace)
           
            --                      This bit is for making sure you don't see the name of it on the side of it
            if trace.Entity == v && e:Distance(trace.HitPos) < 10 then
               
                local pos = trace.HitPos+trace.HitNormal+Vector(0,0,10)
                local ang = trace.HitNormal:Angle()
                local alpha = math.max(0,(maxDist-dist)/maxDist*255)
               
               
                cam.Start3D2D(pos, ang + Angle(0, 90, 90), .03)
                    /*
                    local unownable     = v:GetNWBool("Unownable")
                    local title         = v:getKeysTitle()
                    local property      = v:GetNWBool("Property")
                    local buyable       = !v:GetNWBool("Bought")
                   
                    if (title == "" or !title) then title = "Elegant Doors" end --Set default door title
                   
                    if unownable && !property then --If its unownable.
                        draw.DrawText("Unownable", "elegantPlyDoors", 0, 0, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    elseif !unownable && property then --If its ownable.
                        draw.DrawText("For Sale", "elegantPlyDoors", 0, 0, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                    */
                    local blocked = v:getKeysNonOwnable()
                    local superadmin = LocalPlayer():IsSuperAdmin()
                    local doorTeams = v:getKeysDoorTeams()
                    local doorGroup = v:getKeysDoorGroup()
                    local playerOwned = v:isKeysOwned() or table.GetFirstValue(v:getKeysCoOwners() or {}) ~= nil
                    local owned = playerOwned or doorGroup or doorTeams
 
                    local doorInfo = {}
 
                    local title = v:getKeysTitle()
                    if title then table.insert(doorInfo, title) end
 
                    if owned then
                        table.insert(doorInfo, "Owned By\n")
                    end
 
                    if playerOwned then
                        if v:isKeysOwned() then table.insert(doorInfo, v:getDoorOwner():Nick()) end
                        for k,v in pairs(v:getKeysCoOwners() or {}) do
                            local ent = Player(k)
                            if not IsValid(ent) or not ent:IsPlayer() then continue end
                            table.insert(doorInfo, ent:Nick())
                        end
 
                        local allowedCoOwn = v:getKeysAllowedToOwn()
                        if allowedCoOwn and not fn.Null(allowedCoOwn) then
                            table.insert(doorInfo, DarkRP.getPhrase("keys_other_allowed"))
 
                            for k,v in pairs(allowedCoOwn) do
                                local ent = Player(k)
                                if not IsValid(ent) or not ent:IsPlayer() then continue end
                                table.insert(doorInfo, ent:Nick())
                            end
                        end
                    elseif doorGroup then
                        table.insert(doorInfo, doorGroup)
                    elseif doorTeams then
                        for k, v in pairs(doorTeams) do
                            if not v or not RPExtraTeams[k] then continue end
 
                            table.insert(doorInfo, RPExtraTeams[k].name)
                        end
                    elseif blocked and superadmin then
                        table.insert(doorInfo, DarkRP.getPhrase("keys_allow_ownership"))
                    elseif not blocked then
                        table.insert(doorInfo, "Unowned\nPress F2 to buy")
                        /*if superadmin then
                            table.insert(doorInfo, DarkRP.getPhrase("keys_disallow_ownership"))
                        end*/
                    end
                    //draw.DrawText(, "elegantPlyDoors", 0, -100, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
 
                    draw.DrawText(table.concat(doorInfo, "\n"), "elegantPlyDoors", 0+1, -100+1, Color(0, 0, 0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.DrawText(table.concat(doorInfo, "\n"), "elegantPlyDoors", 0, -100, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                   
                cam.End3D2D()
            end
           
        end
           
    end
   
end

--hook.Add("PostDrawOpaqueRenderables","doorHUDStuff",DrawDoorHUD)
