--#NoSimplerr#
resource.AddFile("materials/Waypoint.png")
util.AddNetworkString( "CombineRequest" )
local function CombineRequest(ply, args)
    local players = {}
    for _, plyr in pairs(player.GetAll()) do
        if plyr:isCP() then
            table.insert(players,plyr)
        end
    end
    net.Start("CombineRequest")
    net.WriteVector( ply:EyePos() )
    net.Send(players)
    DarkRP.notify(players,0,4,"Кому-то нужна помощь!")
    DarkRP.notify(ply,0,4,"Помощь уже в пути")
end

for _, cmd in pairs{"cr", "911", "999", "112", "000"} do
    DarkRP.defineChatCommand(cmd, CombineRequest, 60)
end

function DarkRP.hooks:canArrest(arrester, arrestee)
    if IsValid(arrestee) and arrestee:IsPlayer() and arrestee:isCP() and not GAMEMODE.Config.cpcanarrestcp then
        return false, DarkRP.getPhrase("cant_arrest_other_cp")
    end

    if not GAMEMODE.Config.npcarrest and arrestee:IsNPC() then
        return false, DarkRP.getPhrase("unable", "arrest", "NPC")
    end

    if GAMEMODE.Config.needwantedforarrest and not arrestee:IsNPC() and not arrestee:getDarkRPVar("wanted") then
        return false, DarkRP.getPhrase("must_be_wanted_for_arrest")
    end

    if arrestee:IsPlayer() and arrestee:Team() == TEAM_ADMINONDUTY then
        return false, ("Вы чо охуели??")
    end

    local jpc = DarkRP.jailPosCount()

    if not jpc or jpc == 0 then
        return false, DarkRP.getPhrase("cant_arrest_no_jail_pos")
    end

    if arrestee.Babygod then
        return false, DarkRP.getPhrase("cant_arrest_spawning_players")
    end

    return true
end