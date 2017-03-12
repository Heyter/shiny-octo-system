-- L3M0N Designed
--#NoSimplerr#
local credits="L3M0N" -- DO NOT CHANGE THIS AT ALL


if CLIENT then
  local enabled=false
  local speed = 5
  local lrp_right = 40
  local lrp_forward = 100

local cr = {
	["CHudCrosshair"]=false,
}
hook.Add("HUDShouldDraw", "RemoveCrosshair_", function(name)
	if name=="CHudCrosshair" then return not enabled end
end)

local myscrw, myscrh = 1768,992
function sw(width) local screenwidth = myscrw return width*ScrW()/screenwidth end
function sh(height) local screenheight = myscrh return height*ScrH()/screenheight end
local blur = Material("pp/blurscreen")
local function b(x, y, w, h)
	local X, Y = 0,0
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)
	for i = 1, 5 do
		blur:SetFloat("$blur", (i / 3) * (5))
		blur:Recompute()
render.UpdateScreenEffectTexture()
		render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
   draw.RoundedBox(0,x,y,w,h,Color(0,0,0,205))
   surface.SetDrawColor(0,0,0)
   surface.DrawOutlinedRect(x,y,w,h)

end

function CreateThirdPersonAdjuster()
tpa = vgui.Create("DFrame")
tpa:SetTitle("")
tpa:SetSize(sw(350),sh(30))
tpa:SetPos(ScrW()/2-sw(175),sh(5))
tpa.Paint = function(self) b(0,0,self:GetWide(),self:GetTall()) end
tpa:SetDraggable(false)
tpa:ShowCloseButton(false)
local b = vgui.Create("DButton",tpa)
b:SetSize(tpa:GetWide()/2,sh(20))
b:SetPos( (tpa:GetWide()/2)-((tpa:GetWide()/2)/2),sh(5) )
b:SetText("Переключить вид")
b.DoClick = function() enabled=!enabled  end
end
hook.Add("ShowSpare2","tpaopen", CreateThirdPersonAdjuster)
hook.Add("TCB_F4Menu_Close","tpaclose",function() if tpa then tpa:Remove() end end)


hook.Add("HUDPaint", "hzn_Crosshair", function()
  -- Credit For Crosshair: termy58 (I COULDNT FUCKING FIGURE IT OUT - l3m0n)
    if not enabled or not LocalPlayer():Alive()  then return end
    local player = LocalPlayer()
    local t = {}
    t.start = player:GetShootPos()
    t.endpos = t.start + player:GetAimVector() * 9000
    t.filter = player
    local tr = util.TraceLine(t)
    local pos = tr.HitPos:ToScreen()
    
        surface.DrawCircle(pos.x,pos.y,2, 255, 255,255, 10)
end)


function CalcView(ply, pos, angles, fov)
  if !enabled or ply:InVehicle() then return end
    local view = {}
    lrp_forward = Lerp(speed*FrameTime(),lrp_forward,100)
    local _p = LocalPlayer()
    local epos = _p:EyePos()
    local aimv = _p:GetAimVector()
    local aimrotated = _p:GetAimVector()
    aimrotated:Rotate(Angle(0,-90,0))
    local TraceData = { }
    TraceData.start = epos
    TraceData.endpos = epos - aimv*80 + aimrotated*20
    TraceData.filter = _p
    TraceData.mask = MASK_SOLID_BRUSHONLY

    local Trace = util.TraceLine( TraceData )

    local v = { }
    v.origin = Trace.HitPos
    v.angles = angles
    v.fov = fov

    return v
end

hook.Add("CalcView", "hzn_CalcView", CalcView)

hook.Add("ShouldDrawLocalPlayer", "hzn_ShouldDrawLocalPlayer", function(ply)
        if ply:Alive() and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() == "selfportrait_camera" then
        return true end
        return enabled
end)
local CrosshairS = 5


end
