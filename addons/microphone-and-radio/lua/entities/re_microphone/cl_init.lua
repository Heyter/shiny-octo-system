--#NoSimplerr#

include("shared.lua")

local matLight = Material("sprites/light_ignorez")

function ENT:Initialize()
    self.PixVis = util.GetPixelVisibleHandle()
end

function ENT:Draw()
    local lightPos = self:LocalToWorld(Vector(0, 0, 48.5))
    render.SetMaterial(matLight)
    local visible = util.PixelVisible(lightPos, 1, self.PixVis)
    render.DrawSprite(lightPos, 5, 5, self.dt.On and Color(255, 0, 0, visible * 255) or Color(0, 255, 0, visible * 255))

    local tr = LocalPlayer():GetEyeTrace()

    if tr.Entity == self then
        if self.dt.On then
            AddWorldTip(self:EntIndex(), "Radio Microphone\nON AIR", 0.5, self:LocalToWorld(Vector(0, 0, 50)), self)
        else
            AddWorldTip(self:EntIndex(), "Radio Microphone\nOff Air", 0.5, self:LocalToWorld(Vector(0, 0, 50)), self)
        end
    end

    self:DrawModel()

    if self:IsInRange() then
        local pos = self:LocalToWorld(Vector(0, 0, 50))
        surface.SetFont("Default")
        local w, h = surface.GetTextSize("In Range")
        cam.Start3D2D(pos, Angle(0, -90 + (pos - LocalPlayer():GetShootPos()):Angle().y, 90), 0.05)
        draw.WordBox(2, -w / 2, -h, "In Range", "Default", Color(100, 100, 100, 100), Color(255, 255, 255, 255))
        cam.End3D2D()
    end
end

local data = {}
function ENT:IsInRange()
    if not self.dt.On then return false end

    local micPos = self:LocalToWorld(Vector(0, 0, 64))

    if LocalPlayer():GetShootPos():Distance(micPos) >= 200 then return end

    data.start = micPos
    data.endpos = LocalPlayer():GetShootPos()
    data.filter = player.GetAll()
    table.insert(data.filter, self.Entity)
    local tr = util.TraceLine(data)
    return not tr.Hit
end
