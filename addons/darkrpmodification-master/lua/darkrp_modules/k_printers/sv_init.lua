 --#NoSimplerr#
meta = FindMetaTable( "Player" )

function meta:CanBuyPrinter()
	if self.printers >= self.maxprinters then
		return false
	else
		return true
	end
end
function meta:AddPrinter()
	self.printers = self.printers + 1
end

function meta:RemovePrinter()
	self.printers = self.printers - 1
end
local function plyjoin(ply)
	ply.printers = 0
	ply.maxprinters = 4
end
hook.Add("PlayerInitialSpawn","PrinterJoin",plyjoin)
