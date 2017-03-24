weedPrices = {
	seaweed1 = 10,
	seaweed2 = 10,
	seaweed3 = 15,
	seaweed4 = 30,
	seaweed5 = 45,
	seaweed6 = 50,
	seaweed7 = 250,
}
if SERVER then
resource.AddWorkshop("214869675")
resource.AddFile("sound/getmoney.wav")
local function CreateFolder()
	if not file.IsDir("weedsplants", "DATA") then
        file.CreateDir("weedsplants")
    end
end
hook.Add( "Initialize", "FolderCreateWeeds", CreateFolder )


function saveWeeds(pl, cmd, org)
	if not isArchitector(pl) then return end
	local temp = {}
	for i,v in ipairs(ents.FindByClass("seaweed_spawner")) do
		local vec = v:GetPos()
		local vectemp = {vec.x,vec.y,vec.z}
		PrintTable(vectemp)
		table.insert(temp,#temp+1,vectemp)
	end
	PrintTable(temp)
	file.Write("weedsplants/weeds.txt", util.TableToJSON(temp))
	print("All weedspawners saved")
end

concommand.Add("save_weeds",saveWeeds)

timer.Simple(5, 
function()
	if file.Exists( "weedsplants/weeds.txt", "DATA" ) then
		local data = util.JSONToTable(file.Read("weedsplants/weeds.txt"))
		for k,v in pairs(data) do
			local vec = Vector(v[1],v[2],v[3])
			local s = ents.Create("seaweed_spawner")
			print(vec)
			s:SetPos(vec)
			s:Spawn()

		end

	end
	if file.Exists( "weedsplants/npc.txt", "DATA" ) then
		local data = util.JSONToTable(file.Read("weedsplants/npc.txt"))
		PrintTable(data)
		v = data
			print(k,v)
			local vec = Vector(v[1],v[2],v[3])
			local ang = Angle(v[5],v[6],v[7])
			local s = ents.Create(v[4])
			s:SetPos(vec)
			s:SetAngles(ang)
			s:Spawn()


	end		
	
end)


function weed_npc( pl, cmd, org )

	if pl:IsSuperAdmin() or pl:IsSuperAdmin() or pl:IsUserGroup("superadmin") or pl:IsUserGroup("superadmin") or pl:IsUserGroup("owner") then
		for i,v in ipairs(ents.FindByClass("weednpc")) do
			v:Remove()
		end
		orgNPC = ents.Create("weednpc")
		orgNPC:SetPos(pl:GetPos())
		orgNPC:SetAngles(pl:GetAngles())
		orgNPC:Spawn()
		local vec = pl:GetPos()
		local ang = pl:GetAngles()
		local temp = {vec.x,vec.y,vec.z,"weednpc",ang.p,ang.y,ang.r}
		file.Write("weedsplants/npc.txt", util.TableToJSON(temp))
	end
end
concommand.Add("weed_npc", weed_npc)

timer.Create( "weedspawner", 300, 0, function() 
	for k,v in pairs(ents.FindByClass("seaweed_spawner")) do
		if v:IsValid() then
			v:SpawnWeeds()
		end

	end

end )


else

	function DrawHudShit()
		local tr = LocalPlayer():GetEyeTraceNoCursor()
		if tr.Entity.onHover then
			tr.Entity:onHover()
		end
		




	end
	hook.Add("HUDPaint", "DrawWeedOwerlay", DrawHudShit)
end