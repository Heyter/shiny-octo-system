include("shared.lua")

function ENT:Draw()
    local tr = LocalPlayer():GetEyeTrace()

    if tr.Entity == self then
        if self.dt.On then
            AddWorldTip(self:EntIndex(), "Radio\nOn", 0.5, self:GetPos(), self)
        else
            AddWorldTip(self:EntIndex(), "Radio\nOff", 0.5, self:GetPos(), self)
        end
    end

    self:DrawModel()
end
