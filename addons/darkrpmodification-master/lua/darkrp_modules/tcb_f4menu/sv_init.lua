util.AddNetworkString("fixModelsShitBullshitFuck")
hook.Add("PlayerInitialSpawn","fixModelsShitBullshitFuckHook",function(ply)
	print("fixModelsShitBullshitFuckHook")
	net.Start("fixModelsShitBullshitFuck")
	net.Send(ply)


end)