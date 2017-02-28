/*	
		(_______)       / __)                            	
		 _____   ____ _| |__ ___   ____ ____ _____  ____ 	
		|  ___) |  _ (_   __) _ \ / ___) ___) ___ |/ ___)	
		| |_____| | | || | | |_| | |  ( (___| ____| |    	
		|_______)_| |_||_|  \___/|_|   \____)_____)_|   	

	
	1.) Drag into your addons.
	2.) Change config to your needs, i recommend having all features on.
	3.) Enjoy the script!
	
	#####################################################################
	#-------------------------------------------------------------------#
	#		Chat Commands  < Admin / Super-admin only >                 #
	#-------------------------------------------------------------------#
	#	!rprops <player>	- Removes a players props					#
	#	!lag				- Attempts to clear and physics lag.		#
	#	!enforcer			- Opens the enforcer menu					#
	#	!fprops <player>	- Freeze a players props					#
	#	!bprops				- Disable a player from spawning props		#
	#####################################################################
	#-------------------------------------------------------------------#
	#							Change Log								#
	#-------------------------------------------------------------------#
	# 20/1/15 															#
	#-------------------------------------------------------------------#
	#																	#
	#	<Added - Command to revoke player from spawning any props>		#
	#	<Added - Unique notification system>							#
	#	<Fixed - Table sizes not being kept>							#
	#																	#
	#####################################################################

	Planned Features:
	
	Right click on a player row in the enforcer menu to get options for that player (Ban,Kick,Jail Etc... (ULX and Evolve))
	Custom scoreboard for the script (Shows how much props a player has too)
	Intergrate it into ulx for the people who really want it.
	Option to automatically freeze player when they prop spam?
	Add admin stick for props
	Tidy up code more.
	
	I will be adding more cool feautures soon ( ULX Support Etc.. )
	You can request features and if i see them as useful i will add them!
	
*/


-- AddCSLUA / Includes


AddCSLuaFile( "autorun/client/cl_init.lua" )
AddCSLuaFile( "autorun/client/cl_skin.lua" )


-- Pool Net Messages

util.AddNetworkString("Enforcer_Open_Menu")
util.AddNetworkString("EnforcerNotify")

-- The Config, 1 = On | 0 = Off Do not edit anything but the numbers.

ENF = ENF or {}
ENF.Settings = ENF.Settings or {}

ENF.Settings.NoCrash = 1				-- Automatic system to attempt to prevent prop related crashes
ENF.Settings.AntiPropKill = 1			-- Prevents prop kill
ENF.Settings.NoCarDamage = 1			-- Removes vehicle damage
ENF.Settings.NoCollideCars = 1			-- No collide cars with players
ENF.Settings.NoPropPush = 1				-- Prevents prop pushing
ENF.Settings.NoPropThrow = 1			-- Prevents throwing props
ENF.Settings.BlockPhysReload = 1		-- Block people unfreezing props using 'R'
ENF.Settings.CantFreezeWithPlayer = 1	-- Prevent people freezing props with players inside
ENF.Settings.JailOnSpam = 1				-- Jail people for 5 seconds when they might be prop spamming.
ENF.Settings.JailTime = 15				-- How long do we jail the player for spamming?
ENF.Settings.NoThrowAdv = 1				-- No prop throwing, advanced.
ENF.Settings.EnableLogs = 1				-- Enable Logging?
ENF.Settings.RemoveSpammer = 1			-- Remove the spammers props if he gets caught?

-- Do NOT edit below this line, Support is not guaranteed if you have.


local Enf_PropLogs = {}		-- Do not change
local Enf_DeathLogs = {}		-- Do not change
local Enf_DamageLogs = {}		-- Do not change

cleanup._Add = cleanup._Add or cleanup.Add -- store the original function

function cleanup.Add( ply, Type, Ent )

         if ( Type:lower() == "duplicates" ) then
            Ent.IsDupe = true
            elseif( Type:lower() == "advdupe2" ) then
            Ent.IsDupe = true  
            else
            Ent.IsDupe = false
         end         
		
         return cleanup._Add( ply, Type, Ent )
end


local function ENFNotify( ply, Text )

	net.Start("EnforcerNotify")
		net.WriteString(Text)
	net.Send(ply)
		
end

local function ENFNotifyAll( Text )

	for k, v in pairs( player.GetAll() ) do
		Notify( v, Text );
	end

end


local function ENFOwnerGet( Ent )
	
	local Owner = Owner or nil
	local CPPI = CPPI or nil
	
	if !CPPI then return false end
	
	if Ent.CPPIGetOwner and Ent:CPPIGetOwner() then 
		CPPI,x = Ent:CPPIGetOwner() 
	end
		
	Owner = CPPI or Ent.FPPOwner or Ent.Owner
		
	return Owner


end

local function ENFGhostProp(Ent)

		Ent.Ghosted = true
		if Ent:GetClass() != "prop_physics" then return false end
		
		local OldGroup = Ent:GetCollisionGroup()
		Ent.OldCollisionGroup = OldGroup
		
		Ent:SetRenderMode(RENDERMODE_TRANSALPHA)
		Ent:DrawShadow(false)
		Ent:SetColor(Color(255, 255, 255, 190)) 		

		if not ( OldCollisionGroup == COLLISION_GROUP_WEAPON or OldCollisionGroup == COLLISION_GROUP_WORLD ) then
		
				Ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			    Ent.CollisionGroup = COLLISION_GROUP_WEAPON

		end
		
	
		
end

local function ENFUnGhostProp(Ent)

	if IsValid(Ent) then
				Ent.Ghosted = false
				Ent:DrawShadow(true)
				Ent:SetColor(Color(255, 255, 255, 255)) 
				if Ent.OldCollisionGroup ~= 1 then
					Ent:SetCollisionGroup(0)
				end
	end
	
end


if (ENF.Settings.NoCrash == 1) then

	timer.Create("NoCrashPlease",10,0,function()
	
		for _,p in pairs(ents.FindByClass("prop_physics")) do

			if IsValid(p) then
			
				if p.Picked then return "" end
				if p:IsPlayerHolding( ) then return "" end
				if p:IsVehicle() then return "" end
            if p:GetParent():IsVehicle() then return end
            		
				local PObj = p:GetPhysicsObject()
				if PObj:IsValid() then
				PObj:EnableMotion(false)
				end	
				
			end
		end		
	end)
end

timer.Create("RemoveAllNotify",6,0,function()

	for k,v in pairs(player.GetAll()) do
		v:ConCommand("Enforcer_clear")
	end

end)

	
hook.Add("PhysgunPickup","NoPropPushPlease",function(ply,Ent)
	
	if Ent:IsPlayer() then return false end
	
	if Ent:GetClass() == "prop_door_rotating" then return end
	
	if ENFOwnerGet(Ent) == ply then 	
      Ent.Picked = true
      if (ENF.Settings.NoPropPush == 1) then	
         ENFGhostProp(Ent)		
      end  
   end
   
end)

hook.Add("PhysgunDrop","Enf_ReturnOldPhysGroup",function(ply,Ent)

	if Ent:IsPlayer() then return end
	
	Ent.FoundPlayers = {}
	Ent.Picked = false
	for k,v in pairs(ents.FindInSphere(Ent:GetPos(),24)) do
		if v:IsPlayer() then 
			table.insert(Ent.FoundPlayers,v)
		end
	end
	
	if table.Count(Ent.FoundPlayers) >= 1 then
		if IsValid(ply) then
			ENFNotify(ply,"Can't un-ghost prop with a player trapped")
		end
	else

	timer.Simple(3,function()
		ENFUnGhostProp(Ent)
	end)
   
	end

end)

hook.Add("OnPhysgunReload","Enf_BlockPhysUnfreeze",function(g,ply)

	if ENF.Settings.BlockPhysReload == 1 then
		ENFNotify(ply,"Reloading with a physgun is disabled, unfreeze it manually.")
		return false 
	
	end

end)

hook.Add("EntityTakeDamage","Enf_NoPropKillPlease",function(Target, Dmg)

	local Class = Dmg:GetInflictor():GetClass()
	local Attacker, Inflictor, DmgAmt = Dmg:GetAttacker(), Dmg:GetInflictor(), Dmg:GetDamage()

	if ENF.Settings.AntiPropKill == 1 then
	
		if Inflictor:IsPlayer() then return "" end
		
		if Dmg:GetDamageType() == DMG_VEHICLE or Attacker:IsVehicle() or Inflictor:IsVehicle() or Class == "prop_vehicle_jeep" then
			Dmg:SetDamage(0)
			Dmg:ScaleDamage( 0 )
		end
		
		if (Class == "prop_physics") then
			Dmg:SetDamage(0)
			Dmg:ScaleDamage( 0 )	
		end
		
		if Dmg:GetDamageType() == DMG_CRUSH then
			Dmg:SetDamage(0)
			Dmg:ScaleDamage( 0 )	
		end
	end
end)

hook.Add("PlayerSpawnedVehicle","Enf_NoCollideSpawnedCars",function(Ent)

	if ENF.Settings.NoCollideCars == 1 then
		Ent:SetCollisionGroup(11)
	end
	
end)

hook.Add( "OnPhysgunFreeze", "Enf_PhysFreeze", function( Weapon, Phys, Ent, ply )
	if ENF.Settings.CantFreezeWithPlayer == 1 then
		Ent.FoundPlayers = {}
		
		for k,v in pairs(ents.FindInSphere(Ent:GetPos(),24)) do
		
			if v:IsPlayer() then 
				table.insert(Ent.FoundPlayers,v)
			end
		
		end
		
		if table.Count(Ent.FoundPlayers) >= 1 then
		
			ply:ChatPrint("Can't freeze prop with a player inside.")
		
		else

			Ent:DrawShadow(true)
			Ent:SetColor(Color(255, 255, 255, 255)) 
			if Ent.OldCollisionGroup ~= 1 then
				Ent:SetCollisionGroup(0)
			end
		end
	end
end )

hook.Add("PlayerSpawnedProp","ENFLogSpawns",function(ply, Model, Ent)

	timer.Simple(0.1,function() 
	
		ENFGhostProp( Ent )
		
		timer.Simple( 0.4, function()
			ENFUnGhostProp( Ent )
		end)
	
		if ENF.Settings.EnableLogs == 1 then
			Ent.ENFOwner = ply
			
			table.insert(Enf_PropLogs,os.date().."   :    " .. ply:Nick() .. " Spawned A Prop : " .. Model)
			
			if !Ent.IsDupe then
				ply.SpawnedProps = ply.SpawnedProps + 1
			end
			
		end	
	
	end)
end)

hook.Add("PlayerSpawnProp","Enf_StopBlockSpawners",function(ply)
	
	if (ply.BlockedSpawning) then
		ENFNotify(ply,"You are blocked from spawning props.")
		return false
	end
	
	
end)

hook.Add("EntityTakeDamage","Enf_DamageLogs",function(Target, Dmg)

	if ENF.Settings.EnableLogs == 1 then
		local Class = Dmg:GetInflictor():GetClass()
		local Attacker, Inflictor, DmgAmt = Dmg:GetAttacker(), Dmg:GetInflictor(), Dmg:GetDamage()
		
		if Target:IsPlayer() then
			table.insert(Enf_DamageLogs,os.date().."   :    " .. Target:Nick() .. " Was Attacked By " .. tostring(Attacker) .. " For " .. tostring(DmgAmt) .. " HP!")
		end
	end
	
end)

net.Receive("Enforcer_Open_Menu",function(len,ply)

	if !Enf_DeathLogs then return end
	if !Enf_PropLogs then return end
	if !Enf_DamageLogs then return end

	if ply:IsAdmin() then
	
	if ENF.Settings.EnableLogs == 1 then
	
		net.Start("Enforcer_Open_Menu")
		net.WriteTable(Enf_PropLogs)
		net.WriteTable(Enf_DeathLogs)
		net.WriteTable(Enf_DamageLogs)
		net.WriteDouble(1)
		net.Send(ply)
		
	else

		net.Start("Enforcer_Open_Menu")
		net.WriteTable(Enf_PropLogs)
		net.WriteTable(Enf_DeathLogs)
		net.WriteTable(Enf_DamageLogs)
		net.WriteDouble(0)
		net.Send(ply)	
	
	
	end
		
	end
	
end)

local function ENF_DoPlayerDeath( ply,  attacker, CTakeDamageInfo, dmginfo)

	if ENF.Settings.EnableLogs == 1 then

		if attacker:IsPlayer() then nick = attacker:Nick() else nick = attacker end
		
		table.insert(Enf_DeathLogs,os.date().."   :    " .. ply:Nick() .. " Was Killed By " .. tostring(nick) )

	end
		
end
hook.Add("PlayerDeath","EnforcerDeathLogs",ENF_DoPlayerDeath)

timer.Create( "CheckLogs", 5, 0, function()	-- Does not really matter if this goes above 150 every now and then.
	
	
	if ENF.Settings.EnableLogs == 1 then
	
		if table.Count(Enf_PropLogs) > 400 then
			table.remove(Enf_PropLogs,1)
		end
		if table.Count(Enf_DeathLogs) > 400 then
			table.remove(Enf_DeathLogs,1)
		end
		if table.Count(Enf_DamageLogs) > 400 then
			table.remove(Enf_DamageLogs,1)
		end	
	end
end )
 
local function ENFFindPlayer(name)
	
	if not name then return end
	if not isstring(name) then return end

	local Matches = {}
	
	for _,v in pairs(player.GetAll()) do
		if(v:GetName():lower():match( name:lower())) then
			table.insert(Matches,v)
		end
	end
	
	if ( table.Count(Matches) == 0 ) then MsgN("Player Not Found!")	end
	
	if ( table.Count(Matches) > 1 ) then MsgN("Multiple Players Found") return false end

	return Matches[1]
end
 
local function RemovePlayerProps(ply)

	for _,v in pairs(ents.FindByClass("prop_physics")) do
		if v.ENFOwner == ply then
			v:Remove()
		end
	end
	ENFNotify(ply,"The server or an admin has removed your props.")

end

local function FreezePlayerProps(ply)

	for _,v in pairs(ents.FindByClass("prop_physics")) do
			if v.ENFOwner == ply then
				local PObj = v:GetPhysicsObject()
				if PObj:IsValid() then
				PObj:EnableMotion(false)
			end
		end
	end
	
	ENFNotify(ply,"An admin has frozen your props.")

end 

local function BlockPlayerProps(ply)

	if ply.BlockedSpawning then
	
		ply.BlockedSpawning = false
		ENFNotify(ply,"An admin has allowed you to spawn props again.")
		
	else
	
		ply.BlockedSpawning = true
		ENFNotify(ply,"An admin has blocked you from spawning props.")
		
	end

end

local function ENFClearLag()

	for _,v in pairs(ents.FindByClass("prop_physics")) do

		if IsValid(v) then
				local PObj = v:GetPhysicsObject()
				if PObj:IsValid() then
				PObj:EnableMotion(false)
			end		
		end
	end
	
end

hook.Add("PlayerSay", "EnforcerCommands",function(ply,text,isteam)

	if ply:IsAdmin() then

			Text =  string.lower(text)
		
			if(string.sub(text,0,7) == "!rprops" ) then
			
				Text = string.Explode(" ", Text )
				local PlayerToRemove = ENFFindPlayer( Text[2] )
				RemovePlayerProps(PlayerToRemove)
				return false
				
			elseif(string.sub(Text,0,7) == "!fprops") then
			
				Text = string.Explode(" ", Text )
				local PlayerToFreeze = ENFFindPlayer( Text[2] )
				FreezePlayerProps(PlayerToFreeze)
				return false
				
			elseif(string.sub(Text,0,4) == "!lag") then
			
				ENFClearLag()
				return false
				
			elseif(string.sub(Text,0,9) == "!enforcer") then
			
				net.Start("Enforcer_Open_Menu")
					net.WriteTable(Enf_PropLogs)
					net.WriteTable(Enf_DeathLogs)
					net.WriteTable(Enf_DamageLogs)
				net.Send(ply)
				return false
				
			elseif(string.sub(Text,0,7) == "!bprops") then

				Text = string.Explode(" ", Text )
				local PlayerToBlock = ENFFindPlayer( Text[2] )
				BlockPlayerProps(PlayerToBlock)
				return false
				
			else
			
			end
		
		else end
		
	
	
end)

local function ResetPlayerLogs(ply)
	
	if IsValid(ply) then
	
		ply.SpawnedProps = 0
	
	end
	
end

local function NotifyPropSpam(ply)
	
	if not ( IsValid( ply ) ) then return end;
	if not ( ply:IsPlayer() ) then return end;
	
	if (ENF.Settings.JailOnSpam == 1) then
		RunConsoleCommand("ulx","jail",ply:Nick())
		timer.Simple(ENF.Settings.JailTime,function() RunConsoleCommand("ulx","unjail",ply:Nick()) end)
	end
	
	if ENF.Settings.RemoveSpammer == 1 then
		RemovePlayerProps(ply)
	end
	
	local Count = ply.SpawnedProps
	for k,v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			ENFNotify(v,ply:Nick() .. " May be prop spamming, Spawned " .. Count .. " Props in a short space of time. ")
		end
	end
end

hook.Add("PlayerInitialSpawn","SetUpEnforcerTable",function(ply)

	ply.SpawnedProps = 0
	ply.BlockedSpawning = false
	timer.Create( ply:SteamID() .. "ResetPropPlayer", 5, 0, function() ResetPlayerLogs(ply) end)
	
end)

hook.Add("PlayerDisconnect","DeleteEnforcerTimer",function(ply)

	timer.Destroy( ply:SteamID() .. "ResetPropPlayer" )  

end)

timer.Create( "Enf_CheckPropPlayer", 1.5, 0, function()
	for k,v in pairs(player.GetAll()) do
	
		if v.SpawnedProps >= 10 then
			NotifyPropSpam(v)
		end
	
	end
	
end)

hook.Add("Think","Enf_DirtyPhysfix",function()

	for k,v in pairs(ents.FindByClass("prop_physics")) do
	
		if v.Picked then
			if !v.Ghosted then
				ENFGhostProp(v)
			end
		end
	
	
	end


end)

hook.Add( "PhysgunDrop", "Enf_AntiThrowAdv", function( _, Ent )
		if ENF.Settings.NoThrowAdv == 1 then
			if( Ent and (Ent:IsValid() and !Ent:IsPlayer() and Ent:GetPhysicsObject())) then 
				Ent:SetVelocity(Vector(0,0,0))
				Ent:SetAbsVelocity(Vector(0,0,0))

				local PObj = Ent:GetPhysicsObject()
				if( PObj and IsValid(PObj) ) then
					PObj:AddAngleVelocity( PObj:GetAngleVelocity() * -1 )
					PObj:SetVelocityInstantaneous( Vector(0,0,0) )
			end
		end
	end
end)
