--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
weedspawners = 0
function ENT:Initialize()
	self.number = weedspawners
	weedspawners = weedspawners + 1
	self:SetModel("models/props_junk/cardboard_box004a.mdl")
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self.weedsSpawned = 0
	self:SpawnWeeds()
end

function ENT:Think()

end

function ENT:SpawnWeeds()

	if self.weedsSpawned < 3 then
		local w = self.weedsSpawned
		for i=w,2 do
			self.weedsSpawned = self.weedsSpawned + 1
			local weedn = 1
			while weedn < 7 and math.random(0,100) > 60 do
				weedn = weedn + 1
			end
			local class = "seaweed"..tostring(weedn)

			local start = self:GetPos()
			start.z = start.z + 500
			start.x = start.x + math.random(-300,300)
			start.y = start.y + math.random(-300,300)
			local endpos = Vector(start.x,start.y,start.z)
			endpos.z = endpos.z - 1000
			local trace = {}
			trace.start = start
			trace.endpos = endpos
			trace.mask = MASK_NPCWORLDSTATIC
			local tr = util.TraceLine(trace)
			local pos = tr.HitPos
			local weed = ents.Create(class)
			weed:SetPos(pos)
			weed.parent = self
			weed:Spawn()

		end

	end

end
function ENT:OnWeedRemoved()
	if self.weedsSpawned > 0 then 
		self.weedsSpawned = self.weedsSpawned - 1 
	end


end