--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
end

function ENT:onHover()
	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 22500 then return end
		draw.SimpleTextOutlined("Нажмите \'Е\' чтобы подобрать","DermaDefault",ScrW()/2,ScrH()/2+20,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))

end