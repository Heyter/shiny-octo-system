--Mayor Voting System Server Dist
VOTING = {}
VOTING.CurrentCandidates = {}
VOTING.InProgress = false
VOTING.AboutToBegin = false
VOTING.DarkRPSetup = false
include('sh_votingconfig.lua')
include('sv_votingdata.lua')
util.AddNetworkString("Voting_NewVote")
util.AddNetworkString("Voting_EndVote")
util.AddNetworkString("Voting_VoteCast")

function VOTING.Setup()
--Spawn the Mayor Election NPC
if VOTING.Settings.NPCEnabled then
	VOTING.SetupNPC(VOTING.Database.LoadNPC())
end
VOTING.SetupDarkRPTeam()
end 
hook.Add("Initialize","VOTING_Initialize",VOTING.Setup)

--DarkRP Mayor Team Functions
function VOTING.SetupDarkRPTeam()
	//Find mayor team
	local TEAM
	for k,v in pairs(RPExtraTeams) do
		if string.lower(v.name) == string.lower(VOTING.MayorTeamName) then
			TEAM = v
			VOTING.TeamID = k
		end
	end
	if not TEAM then 
		ErrorNoHalt("Invalid mayor team: " .. tostring(VOTING.MayorTeamName) .. " incorrect or does not exist!") 
		return false 
	end
	VOTING.DarkRPSetup = true
	VOTING.Team = TEAM
	TEAM.customCheck = function(ply)
	if ply.VoteWinner then return true end
	if VOTING.OnlyEnterUsingNPC then 
		VOTING.Team.CustomCheckFailMsg = "Подайте заявку в Полицейском Участке чтобы стать мэром!"
		return false
	else
		VOTING.Team.CustomCheckFailMsg = "Подтвердите свою кандидатуру на должность мэра!"
		SendUserMessage("VOTING_Confirm", ply)
		return false
	end
	end
	TEAM.CustomCheckFailMsg = "Подтвердите свою кандидатуру на должность мэра!"
	
end

function VOTING.CastVote(ply,cmd,args)
	if not IsValid(ply) or not args then return end
	if ply.HasVoted then return end
	if not VOTING.AllowCandidatesToVote and ply.HasEnteredVoting then 
		VOTING.SendDarkRPNotice(ply, 1, 4, "Кандидаты на должность мэра в голосовании не участвуют.") 
		return 
	end

	local candidate = VOTING.CurrentCandidates[tonumber(args[1])]
	if candidate then
		table.insert(candidate.votes, ply)
		ply.HasVoted = true
		net.Start("Voting_VoteCast")
			net.WriteEntity(candidate.player) --Candidate voted on
			net.WriteEntity(ply) --Player who voted
		net.Send(player.GetAll())
	else VOTING.SendDarkRPNotice(ply, 1, 4, "Вы не можете за него проголосовать.") end
end
concommand.Add("mayor_vote", VOTING.CastVote)

function VOTING.EnterMayorVote(ply, cmd, args)
	if not VOTING.DarkRPSetup then VOTING.SetupDarkRPTeam() end
	if VOTING.NextElectionAllowed and not (CurTime() >= VOTING.NextElectionAllowed) then
		local timemsg = string.format("Подождите %i минут!", math.Round((VOTING.NextElectionAllowed - CurTime()) / 60 ))
		VOTING.SendDarkRPNotice(ply, 1, 4, timemsg)
	return false end
	
	if not VOTING.AllowNewElectionWithMayor then
		for k,v in pairs(player.GetAll()) do
			if (v:Team() == VOTING.TeamID) then
				VOTING.SendDarkRPNotice(ply, 1, 4, "Мэр уже избран!")
				return false
			end
		end
	end
	
	if VOTING.InProgress then
		VOTING.SendDarkRPNotice(ply, 1, 4, "Выборы уже идут!")
	return false end
	
	if ply.HasEnteredVoting then
		VOTING.SendDarkRPNotice(ply, 1, 4, "Вы уже участвуете в выборах.")
	return false end
	
	if VOTING.CanEnterVotingCustomFunction and not VOTING.CanEnterVotingCustomFunction(ply) then
		VOTING.SendDarkRPNotice(ply, 1, 4, VOTING.CustomFunctionFailed)
	return false end
	
	if (#VOTING.CurrentCandidates) >= VOTING.MaximumCandidates then
		VOTING.SendDarkRPNotice(ply, 1, 4, "Уже " .. tostring(VOTING.MaximumCandidates) .. " кандидатов, больше - нельзя." )
	return false end
		
	--Check cost
	if VOTING.CandidateCost and VOTING.CandidateCost > 0 then
		if (ply.CanAfford and not ply:CanAfford(VOTING.CandidateCost)) or (ply.canAfford and not ply:canAfford(VOTING.CandidateCost)) then
		VOTING.SendDarkRPNotice(ply, 1, 4, "Вы не можете себе позволить это.")
		return false end
	
		if ply.AddMoney then ply:AddMoney(-VOTING.CandidateCost)
		elseif ply.addMoney then ply:addMoney(-VOTING.CandidateCost) end
	end
	
	--Enter player into mayor elections
	ply.HasEnteredVoting = true
	table.insert(VOTING.CurrentCandidates, { player = ply, time = CurTime(), votes = {}})
	VOTING.SendDarkRPNotice(ply, 2, 4, "Вы участвуете в выборах. Удачи!")

	if VOTING.AboutToBegin then return false end
	if (#VOTING.CurrentCandidates >= VOTING.MinimumCandidates) then
		VOTING.AboutToBegin = true
			VOTING.ChatNotice("Следующие выборы мэра пройдут через " .. tostring(VOTING.AboutToBeginTime) .. " секунд!")
		timer.Simple(VOTING.AboutToBeginTime,
		function()
			if VOTING.MinutesUntilNextElection and VOTING.MinutesUntilNextElection > 0 then
				VOTING.NextElectionAllowed = (CurTime() + (VOTING.MinutesUntilNextElection * 60))
			end
			VOTING.InProgress = true
			VOTING.ChatNotice("Выборы начались. Удачи!")
			net.Start("Voting_NewVote")
				net.WriteTable(VOTING.CurrentCandidates)
			net.Send(player.GetAll())
			timer.Simple(VOTING.VoteTime, VOTING.EndVote)
		end)	
	end
	return false
end
concommand.Add("mayor_vote_enter", VOTING.EnterMayorVote)

function VOTING.EndVote()
if not VOTING.InProgress then return end
	//Find winner
	local winningvotes = 0
	local candidate
	for k,v in pairs(VOTING.CurrentCandidates) do
		if #v.votes > winningvotes then
			winningvotes = #v.votes
			candidate = v.player
		end
	end
	
	if (winningvotes == 0) then
		VOTING.ChatNotice("В выборах никто не проголосовал.")
		net.Start("Voting_EndVote")
		net.Send(player.GetAll())
	elseif IsValid(candidate) then
		net.Start("Voting_EndVote")
			net.WriteEntity(candidate)
		net.Send(player.GetAll())
		VOTING.ChatNotice(string.format("Поздравляем победителя - %s!", candidate:Nick()))
		--Update player team
		candidate.VoteWinner = true
		
		if VOTING.DemoteOtherMayorsOnWin then
			for k,v in pairs(player.GetAll()) do
				if (v:Team() == VOTING.TeamID) then
					if v.ChangeTeam then v:ChangeTeam(TEAM_CITIZEN, true)
					elseif v.changeTeam then v:changeTeam(TEAM_CITIZEN, true) end
				end
			end
		end
		
		if candidate.changeTeam then
			candidate:changeTeam(VOTING.TeamID, true)
		elseif candidate.ChangeTeam then
			candidate:ChangeTeam(VOTING.TeamID, true)
		end
	else
		VOTING.ChatNotice("Кандидат, победивших на выборах, покинул игру!")
		net.Start("Voting_EndVote")
		net.Send(player.GetAll())
	end

	for k,v in pairs(player.GetAll()) do
		if IsValid(v) then 
			v.HasEnteredVoting = nil
			v.HasVoted = nil
			v.VoteWinner = false
		end
	end
	VOTING.AboutToBegin = false
	VOTING.InProgress = false
	VOTING.CurrentCandidates = {}
end

function VOTING.PlayerDeath( vic, wep, kil )
if IsValid(vic) and VOTING.TeamID == vic:Team() then
	if VOTING.DemoteMayorOnDeath then
		if vic.ChangeTeam then vic:ChangeTeam(TEAM_CITIZEN, true)
		elseif vic.changeTeam then vic:changeTeam(TEAM_CITIZEN, true) end
		VOTING.ChatNotice("Мэр трагически погиб. Нужно провести выборы!")
		if VOTING.AllowNewElectionOnDeath then
			VOTING.NextElectionAllowed = nil
		end
	end
end
end
hook.Add( "PlayerDeath", "VOTING_PlayerDeath", VOTING.PlayerDeath )

function VOTING.SendDarkRPNotice(ply, msgtype, len, msg)
	if DarkRP and DarkRP.notify then
		DarkRP.notify(ply, msgtype, len, msg)
	elseif GAMEMODE and GAMEMODE.Notify then
		GAMEMODE:Notify(ply, msgtype, len, msg)
	end
end

function VOTING.ChatNotice(msg, ply)
	if not msg then return end
	if ply and IsValid(ply) then 
		umsg.Start("Voting_ChatNotice", ply)
			umsg.String(msg)
		umsg.End()
	elseif not ply then
		umsg.Start("Voting_ChatNotice")
			umsg.String(msg)
		umsg.End()
	end
end

--NPC Functions
function VOTING.SetupNPC(pos, ang)
	if pos and ang then
		for k,v in pairs(ents.FindByClass("npc_mayorvoting")) do
			v:Remove()
		end
		
		local npc = ents.Create("npc_mayorvoting")
		npc:SetModel(VOTING.Settings.NPCModel)
		npc:SetPos(pos)
		npc:SetAngles(ang)
		npc:PhysWake()
		npc:Spawn()
		npc:Activate()
		local sequence = npc:LookupSequence(VOTING.Settings.NPCSequence)
		npc:ResetSequence(sequence or 1);
	end
end

function VOTING.PlaceNPC(ply, cmd, args)
	if not VOTING.DarkRPSetup then VOTING.SetupDarkRPTeam() end
	if not IsValid(ply) or not ply:IsSuperAdmin() then return end
	local pos = ply:GetPos()
	local ang = ply:GetAngles()
	VOTING.Database.SaveNPC(pos, ang)
	VOTING.SetupNPC(pos, ang)	
	VOTING.SendDarkRPNotice(ply, 0, 4, "NPC Has been placed in your exact position!") 
	ply:ConCommand("noclip")
end
concommand.Add("mayor_vote_placenpc", VOTING.PlaceNPC)

-- DEBUG Functions
function VOTING.DebugVote(ply, cmd, args)
	if not ply:IsSuperAdmin() then return end
	print("Starting mayor system debug...")
	VOTING.CurrentCandidates = {}
	VOTING.NextElectionAllowed = nil
	//VOTING.InProgress = false
	//VOTING.AboutToBegin = false
	for i=1,4,1 do
		ply:ConCommand("bot")
	end
	for k,v in pairs(player.GetAll()) do
		v.HasEnteredVoting = false
		VOTING.EnterMayorVote(v, true)
	end
end
concommand.Add("mayor_vote_debug", VOTING.DebugVote)