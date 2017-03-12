AddCSLuaFile()

if SERVER then
    AddCSLuaFile("cl_menu.lua")
    include("sv_init.lua")
end

if CLIENT then
    include("cl_menu.lua")
end

SWEP.PrintName = "Инвентарь"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.Base = "weapon_cs_base2"

SWEP.Author = "DarkRP Developers"
SWEP.Instructions = "Левый клик чтобы положить вещь в инвентарь\nПравый клик чтобы открыть инвентарь"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPPocket = true

SWEP.IconLetter = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix  = "rpg"
SWEP.WorldModel = ""

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "DarkRP (Utility)"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    return true
end

function SWEP:DrawWorldModel() end

function SWEP:PreDrawViewModel(vm)
    return true
end

function SWEP:Holster()
    if not SERVER then return true end

    self:GetOwner():DrawViewModel(true)
    self:GetOwner():DrawWorldModel(true)

    return true
end

function SWEP:PrimaryAttack()
 

    if not SERVER then return end

    local ent = self:GetOwner():GetEyeTrace().Entity
    
    hook.Call("PocketUse",nil,self:GetOwner(),ent)

end


function SWEP:SecondaryAttack()
    if not SERVER then return end
    self:GetOwner():ConCommand("drp_showinv")

end

function SWEP:Reload()
    if not CLIENT then return end

    
end

local meta = FindMetaTable("Player")
DarkRP.stub{
    name = "getPocketItems",
    description = "Get a player's pocket items.",
    parameters = {
    },
    returns = {
        {
            name = "items",
            description = "A table containing crucial information about the items in the pocket.",
            type = "table"
        }
    },
    metatable = meta,
    realm = "Shared"
}
