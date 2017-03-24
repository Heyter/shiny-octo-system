AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Thompson 1928A1 WW2"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
    SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.MuzzlePosMod = {x = 4.5, y = 20, z = -2}
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87
	
	SWEP.IronsightPos = Vector(-3.474, 0, 2.15)
	SWEP.IronsightAng = Vector(-0.071, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-3.465, -4.2, 1.442)
	SWEP.MicroT1Ang = Vector(0.0, 0, 0)
	
	SWEP.EoTechPos = Vector(-3.503, -4.4, 1.213)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-3.49, -2.5, 1.379)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-3.474, -10.051, 1.195)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(6.834, -2.01, 0.402)
	SWEP.SprintAng = Vector(-4.926, 45.025, 7.034)

	SWEP.CustomizePos = Vector(6.432, -2.613, 0.201)
	SWEP.CustomizeAng = Vector(8.442, 36.583, 7.034)
	
	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 3.33, 0)
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.LuaVMRecoilAxisMod = {vert = 2, hor = 3, roll = 2, forward = 2, pitch = 1}

		SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "wpn_body", pos = Vector(-0.01, 3.9, 2.565), angle = Angle(0, 0, 0), size = Vector(0.37, 0.37, 0.37)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "wpn_body", pos = Vector(0.209, -5.801, -7.2), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "wpn_body", pos = Vector(-0.22, -0.9, -2.06), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "wpn_body", pos = Vector(-0.301, -0.8, -2.161), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "wpn_body", pos = Vector(0.2, 4.5, 1.5), angle = Angle(0, 90, 0), size = Vector(0.4, 0.899, 0.5)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "wpn_body", pos = Vector(-0, 17.299, 1.179), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5)}
	}
	
	SWEP.CustomizationMenuScale = 0.1

	SWEP.LaserPosAdjust = {x = 0, y = 0, z = 0}
	SWEP.LaserAngAdjust = {p = -1, y = 180, r = 0}
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.012
end



SWEP.BarrelBGs = {main = 2, sd = 1, k = 2, regular = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_tundra9mm"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

reload = {[1] = {time = 0, sound = "CW_TMGA1_MAGIN"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "GoldenGrizzly CW:2.0"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_thompsont.mdl"
SWEP.WorldModel		= "models/weapons/w_thompsont.mdl"
SWEP.DrawTraditionalWorldModel = true
SWEP.WM = "models/weapons/w_thompsont.mdl"
SWEP.WMPos = Vector(-0, -0, -0.519)
SWEP.WMAng = Vector(1.169, 0, -180)

SWEP.ADSFireAnim = false
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.Chamberable = false
SWEP.AimViewModelFOV = 75

SWEP.FireDelay = 0.0909090909
SWEP.FireSound = "CW_TMGA1_FIRE"
SWEP.FireSoundSuppressed = "CW_MP5_FIRE_SUPPRESSED"
SWEP.Recoil = 0.75

SWEP.HipSpread = 0.040
SWEP.AimSpread = 0.011
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 34
SWEP.DeployTime = 1.2

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt = 2.6
SWEP.ReloadHalt_Empty = 3.5