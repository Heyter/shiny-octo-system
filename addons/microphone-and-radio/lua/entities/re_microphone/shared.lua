ENT.Type            = "anim"
ENT.Base            = "base_gmodentity"

ENT.PrintName       = "Microphone"
ENT.Author          = "Recon"
ENT.Contact         = ""
ENT.Purpose         = "To link your minging with the world"
ENT.Instructions    = "Broadcasts voice to radios"
ENT.Category        = "Roleplay Ents"

ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.DeleteOnClassChange = true

function ENT:SetupDataTables()
    self:DTVar("Bool", 0, "On")
	self:DTVar("Entity",1,"owning_ent")
end
