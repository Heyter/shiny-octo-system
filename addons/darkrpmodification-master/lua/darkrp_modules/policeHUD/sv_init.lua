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
end

for _, cmd in pairs{"cr", "911", "999", "112", "000"} do
    DarkRP.defineChatCommand(cmd, CombineRequest, 1.5)
end