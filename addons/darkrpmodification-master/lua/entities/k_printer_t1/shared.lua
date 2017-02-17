-- EDIT DEEZ --
ENT.Label_BG = Color( 150, 150, 150 ); -- or in the color format ( Color( r, g, b, a ) )
ENT.Label_TextColor = color_black; -- ^^^
ENT.PrintName = "Принтер уровня 1"; -- This is what will be printed on top
---------------

ENT.Type = "anim";
ENT.Base = "base_gmodentity";
ENT.Author = "Koolaidmini";
ENT.Spawnable = true;
ENT.AdminSpawnable = true;

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "price" );
	self:NetworkVar( "Entity", 0, "owning_ent" );
end;