/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

-- Variables
TCB_Settings = {}

-- Settings
TCB_Settings.ActivationKey1 = "ShowSpare2"		// F1 (ShowHelp), 	F2 (ShowTeam), 	F3 (ShowSpare1), 	F4 (ShowSpare2)
TCB_Settings.ActivationKey2	= KEY_F4			// F1 (KEY_F1), 	F2 (KEY_F2), 	F3 (KEY_F3), 		F4 (KEY_F4)

TCB_Settings.CheckVersion	= true

TCB_Settings.HideWrongJob	= true

TCB_Settings.TitleOne		= "MadBay.Net"
TCB_Settings.TitleTwo		= "СОРОКОВЫЕ ГОДЫ ПИЗДОС!"

TCB_Settings.PrimaryColor		= Color(245, 206, 34, 255 )
TCB_Settings.SecondaryColor		= Color(245, 206, 34, 255 )
TCB_Settings.ThirdColor     	= Color(245, 206, 34, 255)
TCB_Settings.BaseColor  		= Color(43, 29, 17, 255)
TCB_Settings.TextColor  		= Color(245, 206, 34, 255 )
TCB_Settings.BlackColor 		= Color(0, 0, 0, 255) 
TCB_Settings.ButtonColor1 		= Color(36, 36, 36, 255 )
TCB_Settings.ButtonColor2 		= Color(56, 38, 22, 255 )
TCB_Settings.ButtonColor3 		= Color(71, 49, 29,255 )
TCB_Settings.ButtonColor4 		= Color(84, 57, 34, 255)
TCB_Settings.WhiteColor 		= Color(255, 255, 255, 255 )
TCB_Settings.SoftBlack 			= Color(0, 0, 0, 100 )
TCB_Settings.Transparent 		= Color(255, 255, 255, 0 )
TCB_Settings.LightBrown 		= Color( 69,46,27,255 )
TCB_Settings.Green1Color 		= Color( 46, 204, 113, 255 ) 
TCB_Settings.Green2Color 		= Color( 39, 174, 96, 255 ) 
TCB_Settings.Blue1Color 		= Color( 52, 152, 219, 255 ) 
TCB_Settings.Blue2Color 		= Color( 41, 128, 185, 255 ) 
TCB_Settings.Gray1Color			= Color( 149, 165, 166, 255 )
TCB_Settings.Gray2Color			= Color( 127, 140, 141, 255 )
TCB_Settings.Gray3Color			= Color( 255, 255, 255, 25 ) 

-- Custom Web Panels (If Enabled Below)
TCB_Settings.WebPanel_1		= "http://madbay.net/community/index.php"
TCB_Settings.WebPanel_2		= "http://www.thecodingbeast.com"
TCB_Settings.WebPanel_3		= "http://www.thecodingbeast.com"
TCB_Settings.WebPanel_4		= "http://www.thecodingbeast.com" 

-- Buttons
TCB_Settings.SidebarButtons = {
	
	{ text = "Команды", 	panel = "tcb_panel_commands", 	info = true, 	func = 6			},

	{ text = "Divider",		panel = "",						info = false,	func = 0 			},

	{ text = "Форум",		panel = "tcb_panel_custom1",	info = false,	func = 1 	,link = "http://madbay.net/community/index.php"	},
	{ text = "Магазин",		panel = "tcb_panel_custom1",	info = false,	func = 1 	,link = "http://madbay.net/community/index.php?pages/donations/"},
	--{ text = "Правила",		panel = "tcb_panel_custom2",	info = false,	func = 0 			},
	--{ text = "Магазин",		panel = "tcb_panel_custom3",	info = false,	func = 0 			},
	--{ text = "Команда",		panel = "tcb_panel_custom4",	info = false,	func = 0 			},

	{ text = "Divider",		panel = "",						info = false,	func = 0 			},

	{ text = "Работы", 		panel = "tcb_panel_jobs",		info = true,	func = "jobs"  		},
	{ text = "Предметы",	panel = "tcb_panel_entities",	info = true,	func = "entities"	},
	{ text = "Оружие",		panel = "tcb_panel_guns",		info = true,	func = "weapons"	},
	--{ text = "Партии",	    panel = "tcb_panel_shipments",	info = true,	func = "shipments" 	},
	{ text = "Патроны",		panel = "tcb_panel_ammo",		info = true,	func = "ammo" 		},
	--{ text = "Транспорт",	panel = "tcb_panel_vehicles",	info = true,	func = "vehicles"	},

}

-- Version (Don't Change)
TCB_Settings.Version 		= "1.8"