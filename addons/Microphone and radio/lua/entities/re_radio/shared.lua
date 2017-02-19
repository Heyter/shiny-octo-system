ENT.Type            = "anim"
ENT.Base            = "base_gmodentity"

ENT.PrintName       = "Radio"
ENT.Author          = "Recon"
ENT.Contact         = ""
ENT.Purpose         = "Listen to the beautiful mic spam."
ENT.Instructions    = "Talk into the microphone!"
ENT.Category       = "Roleplay Ents"

ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
    self:DTVar("Bool", 0, "On")
	self:DTVar("Entity",1,"owning_ent")
end
