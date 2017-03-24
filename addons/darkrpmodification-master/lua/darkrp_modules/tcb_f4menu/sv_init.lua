util.AddNetworkString("fixModelsShitBullshitFuck")
hook.Add("PlayerInitialSpawn","fixModelsShitBullshitFuckHook",function(ply)
	net.Start("fixModelsShitBullshitFuck")
	net.Send(ply)


end)