--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--
--          =--Leaked by Teoren  --=             --
--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--

DOORHANDLE.ViewDistance = 512 -- the farthest a player can see a label. Higher numbers will create more FPS lag.
DOORHANDLE.DefaultColor = Color(255,255,255) -- the default color for door labels

DOORHANDLE.PresetFonts = { -- add more fonts and they will be available in the doorHandle menu! Make sure to send them to the players!
	"Roboto", -- The first entry in the table is the default font.
	"Roboto Bold",
	"System",
	"Comic Sans MS",
	"Georgia",
	"Papyrus",
	"Times New Roman",
	"Palatino Linotype",
	"Coolvetica",
	"Helvetica",
	"Impact",
	"Verdana",
	"Trebuchet MS",
	"Courier New",
	"Copperplate Gothic Bold",
	"Franklin Gothic",
	"Symbol",
}

DOORHANDLE.MaxTextScale = 4
DOORHANDLE.MinTextScale = 0.25

-- appendix I

DOORHANDLE.DefaultTextScale = 3.5 -- this must be a number between MaxTextScale and MinTextScale
DOORHANDLE.BuyableTextScale = 2 -- this is how big the text is when the door has not been purchased.
DOORHANDLE.DisplayBuyableText = true -- change this to false to hide the "Press F2 to purchase" text.

-- appendix II

DOORHANDLE.UseKeysMenu = true -- true to enable the button in the keys menu, false to remove the button (if the button conflicts with another addon)

-- appendix III

DOORHANDLE.LookAt = {}
DOORHANDLE.LookAt.PurchaseText = false -- When set to true, the player has to be looking at the door to see the relevant text. This one is related to the "Press F2 To Purchase" text.
DOORHANDLE.LookAt.NonOwnableText = false -- Text which is displayed when the door is un-ownable
DOORHANDLE.LookAt.GroupOwnableText = false -- Text displayed when the door is owned by a group (e.g. Civil Protection)
DOORHANDLE.LookAt.PlayerOwnedText = false -- Text displayed when a player(s) owns a door

-- appendix IV

DOORHANDLE.AllowTransparency = false -- set this to false to disable invisible door labels.

-- appendix V - more text options

DOORHANDLE.French = false -- set this to true if your server speaks mostly french.

DOORHANDLE.strings = {
	co_owners = "Совладельцы", -- shown when listing other owners
	only = "только",
	_and = "и",
	purchasetext = "Нажмите F2 чтобы купить",
	Text_Scale = "Размер текста",
	Font = "Шрифт",
	Open_Doorhandle_Menu = "Открыть меню двери",
	Edit_Title_Appearance = "Изменить текст"
}

DOORHANDLE.fr_strings = { -- since this was requested by a french customer :)
	co_owners = "Co-Propriétaires", 
	only = "seulement",
	_and = "et",
	purchasetext = "Appuyez sur F2 pour acheter cette porte.",
	Text_Scale = "Échelle du texte",
	Font = "Fonte",
	Open_Doorhandle_Menu = "Ouvrir Doorhandle Menu",
	Edit_Title_Appearance = "Modifier le titre Apparence"
}

-- appendix VI - "rex" update

DOORHANDLE.AdminOnly = false