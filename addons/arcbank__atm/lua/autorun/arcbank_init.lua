-- This shit is under copyright.
-- Any 3rd party content has been used as either public domain or with permission.
-- © Copyright 2014 Aritz Beobide-Cardinal All rights reserved.

function ARCBankMsg(msg)
	Msg("ARCBank: "..tostring(msg).."\n")
	if !ARCBank then return end
	if ARCBank.LogFileWritten then
		file.Append(ARCBank.LogFile, os.date("%d-%m-%Y %H:%M:%S").." > "..tostring(msg).."\n")
	end
end
ARCBankMsg("Running...\n ____ ____ _ ___ ___     ____ ____ ____ ____ _  _ ____ ____    ___  ____ _  _ _  _ _ _  _ ____ \n |__| |__/ |  |    /     |    |__/ |__| |    |_/  |___ |__/    |__] |__| |\\ | |_/  | |\\ | | __ \n |  | |  \\ |  |   /__    |___ |  \\ |  | |___ | \\_ |___ |  \\    |__] |  | | \\| | \\_ | | \\| |__] \n")
ARCBankMsg(table.Random({"FREE HOOKER EDITION!","FREEEE!!! I'M FREEEE!!","Isn't this amazing?","That's one fiiiine addon you got there!","Just in time for the holidays!"}))
ARCBankMsg("By Aritz Beobide-Cardinal (ARitz Cracker)")

ARCBank = ARCBank or {}
ARCBank.Update = "August 2nd 2014"
ARCBank.Version = "[FREE VERSION 2]"

--TRANSACTION ERRORS
ARCBANK_ERRORSTRINGS = {}
ARCBANK_ERROR_VOICE = {}
ARCBANK_ERROR_NONE = 0
ARCBANK_ERROR_VOICE[0] = "vo/heavy_goodjob02.wav"
ARCBANK_ERRORSTRINGS[0] = "Completed Successfully"
ARCBANK_ERROR_NO_CASH_PLAYER = 1
ARCBANK_ERROR_VOICE[1] = "vo/heavy_domination03.wav"
ARCBANK_ERRORSTRINGS[1] = "Your wallet doesn't have enough cash!"
ARCBANK_ERROR_NO_CASH = 2
ARCBANK_ERROR_VOICE[2] = "vo/heavy_laughlong01.wav"
ARCBANK_ERRORSTRINGS[2] = "The account doesn't have enough\nmoney!"
ARCBANK_ERROR_NO_ACCES = 3
ARCBANK_ERROR_VOICE[3] = "vo/heavy_domination02.wav"
ARCBANK_ERRORSTRINGS[3] = "You do not have acces to this\noperation!"
ARCBANK_ERROR_NIL_ACCOUNT = 4
ARCBANK_ERROR_VOICE[4] = "vo/heavy_jeers03.wav"
ARCBANK_ERRORSTRINGS[4] = "Account Doesn't Exist"
ARCBANK_ERROR_PLAYER_FOREVER_ALONE = 5
ARCBANK_ERROR_VOICE[5] = "vo/heavy_fairyprincess10.wav"
ARCBANK_ERRORSTRINGS[5] = "You do not have acces to any group\naccounts. :("
ARCBANK_ERROR_NIL_PLAYER = 6
ARCBANK_ERROR_VOICE[6] = "vo/heavy_jeers03.wav"
ARCBANK_ERRORSTRINGS[6] = "The player you tried to select doesn't\nexist or is invalid."
ARCBANK_ERROR_DUPE_PLAYER = 7
ARCBANK_ERROR_VOICE[7] = "vo/heavy_jeers03.wav"
ARCBANK_ERRORSTRINGS[7] = "The player you tried to add to the\ngroup is already a member!"

ARCBANK_ERROR_TOO_MUCH_CASH = 8
ARCBANK_ERROR_VOICE[8] = "vo/heavy_jeers03.wav"
ARCBANK_ERRORSTRINGS[8] = "An account cannot have more than\n100 Trillion Credits"

--CREATION ERRORS
ARCBANK_ERROR_NAME_DUPE = 9
ARCBANK_ERROR_VOICE[9] = "vo/heavy_jeers03.wav"
ARCBANK_ERRORSTRINGS[9] = "Account with the same or a similar\nname already exists."
ARCBANK_ERROR_UNDERLING = 10
ARCBANK_ERROR_VOICE[10] = "vo/heavy_domination01.wav"
ARCBANK_ERRORSTRINGS[10] = "You don't have a high enough player\nrank."
ARCBANK_ERROR_INVALID_RANK = 11
ARCBANK_ERROR_VOICE[11] = "vo/heavy_no03.wav"
--ARCBANK_ERRORSTRINGS[11] = "Cannot upgrade account. Already at\nhighest rank."
ARCBANK_ERRORSTRINGS[11] = "The rank you tried to assign this\naccount to was TOO DAMN HIGH!"

ARCBANK_ERROR_TOO_MANY_ACCOUNTS = 12
ARCBANK_ERROR_VOICE[12] = "vo/heavy_no03.wav"
ARCBANK_ERRORSTRINGS[12] = "You've reached the limit of accounts\nyou can have."

ARCBANK_ERROR_DEBT = 13
ARCBANK_ERROR_VOICE[13] = "vo/heavy_laughlong01.wav"
ARCBANK_ERRORSTRINGS[13] = "You can't do this while you're in debt."
--OTHER ERRORS
ARCBANK_ERROR_NOT_LOADED = 14
ARCBANK_ERROR_VOICE[14] = "vo/heavy_negativevocalization06.wav"
ARCBANK_ERRORSTRINGS[14] = "The ARCBank system failed to load."
ARCBANK_ERROR_UNKNOWN = 15
ARCBANK_ERROR_VOICE[15] = "vo/heavy_jeers09.wav"
ARCBANK_ERRORSTRINGS[15] = "Unknown Error. Try again."

ARCBANK_ERRORBITRATE = 8

ARCBANK_NAME = 1
ARCBANK_NAMETO = 2
ARCBANK_RANK = 2
ARCBANK_PLAYER = 3
ARCBANK_GROUP_OWNER = 3
ARCBANK_BALANCE = 4
ARCBANK_MONEY = 4
ARCBANK_GROUP_ACCES = 5
ARCBANK_UPGRADE = 6
ARCBANK_CHUNK = 6
ARCBANK_ID = 6
ARCBANK_CHUNK_TOTAL = 7
--OPERATIONS
ARCBANK_DEPOSIT = 0
ARCBANK_WITHDRAWL = 1
--ACCOUNTS
ARCBANK_ACCOUNTSTRINGS = {}
ARCBANK_PERSONALACCOUNTS_ = 0
ARCBANK_ACCOUNTSTRINGS[0] = "invalid"
ARCBANK_PERSONALACCOUNTS_STANDARD = 1
ARCBANK_ACCOUNTSTRINGS[1] = "standard"
ARCBANK_PERSONALACCOUNTS_BRONZE = 2
ARCBANK_ACCOUNTSTRINGS[2] = "bronze"
ARCBANK_PERSONALACCOUNTS_SILVER = 3
ARCBANK_ACCOUNTSTRINGS[3] = "silver"
ARCBANK_PERSONALACCOUNTS_GOLD = 4
ARCBANK_ACCOUNTSTRINGS[4] = "gold"
ARCBANK_GROUPACCOUNTS_ = 5
ARCBANK_ACCOUNTSTRINGS[5] = "group_invalid"
ARCBANK_GROUPACCOUNTS_STANDARD = 6
ARCBANK_ACCOUNTSTRINGS[6] = "group_standard"
ARCBANK_GROUPACCOUNTS_PREMIUM = 7
ARCBANK_ACCOUNTSTRINGS[7] = "group_premium"
ARCBANK_ACCOUNTBITRATE = 4


--ATM OPERATORS
ARCBANK_ATM_SERVERMSG = -1
ARCBANK_ATM_PING = 0
ARCBANK_ATM_ACCOUNTINFO = 1
ARCBANK_ATM_CASH = 2
ARCBANK_ATM_TRANSFER = 3
ARCBANK_ATM_CREATE = 4
ARCBANK_ATM_GROUPADMIN = 5
ARCBANK_ATM_GETGROUPS = 6
ARCBANK_ATM_LOG = 7
ARCBANK_ATMBITRATE = 4
ARCBank.ATMMsgs = ARCBank.ATMMsgs or {}
ARCBank.CardMsgs = ARCBank.CardMsgs or {}
ARCBank.UserMsgs = ARCBank.UserMsgs or {}
function ARCBank.UpdateLang(lang)
	if lang == "fr" || lang == "french" then
		MsgN("ARCBank: French selected. - Translated by Theo312.")
		ARCBANK_ERRORSTRINGS[0] = "Succès"
		ARCBANK_ERRORSTRINGS[1] = "Vous n'avez pas assez d'argent sur\nvous!"
		ARCBANK_ERRORSTRINGS[2] = "Le compte n'a pas assez d'argent!"
		ARCBANK_ERRORSTRINGS[3] = "Vous n'avez pas accès à cette\noperation!"
		ARCBANK_ERRORSTRINGS[4] = "Le compte n'existe pas!"
		ARCBANK_ERRORSTRINGS[5] = "Vous n'avez accès à aucun compte de\ngroupe. :("
		ARCBANK_ERRORSTRINGS[6] = "Le joueur que vous essayer de choisir\nn'existe pas ou est invalide"
		ARCBANK_ERRORSTRINGS[7] = "Le joueur que vous essayer d'ajouter\nest déjà dans le groupe!"
		ARCBANK_ERRORSTRINGS[8] = "Un compte ne peut pas avoir plus de\n100 Trillion."
		ARCBANK_ERRORSTRINGS[9] = "Un autre compte utilise déjà ce nom."
		ARCBANK_ERRORSTRINGS[10] = "Vous n'avez pas un rang de joueur\nsuffisant."
		ARCBANK_ERRORSTRINGS[11] = "Impossible d'ameliorer le compte.\nCompte déjà au maximum."
		ARCBANK_ERRORSTRINGS[12] = "Vous possèdez trop de comptes pour\nen créez un nouveau."
		ARCBANK_ERRORSTRINGS[13] = "Vous ne pouvez pas faire ça car vous\nêtes dans le rouge."
		ARCBANK_ERRORSTRINGS[14] = "Le systeme ARCBank ne c'est pas\ninitialiser correctement."
		ARCBANK_ERRORSTRINGS[15] = "Erreur inconnu.\nEssayez à nouveau."
		ARCBank.ATMMsgs.NetworkError = "Je suis hors-service :(\n(ERREUR: 0x045)\n\nS'il vous plaît, contactez un administrateur système."
		ARCBank.ATMMsgs.HackingError = "Je suis hors-service :(\n(ERREUR: 0x539)\n\nS'il vous plaît, visitez un autre distributeur."
		ARCBank.ATMMsgs.HackBegin = "ATTENTION! SYSTEME EMP DETECTE!"
		ARCBank.ATMMsgs.Welcome = "Bienvenue"
		ARCBank.ATMMsgs.Loading = "Chargement..."
		ARCBank.ATMMsgs.Waiting = "En attente..." -- This shows in the title bar when the player has to take or put money in the ATM
		ARCBank.ATMMsgs.LoadingMsg = "Patientez..."
		ARCBank.ATMMsgs.TakeCash = "Prenez votre argent."
		ARCBank.ATMMsgs.GiveCash = "Inserez l'argent."
		ARCBank.ATMMsgs.Yes = "Oui"
		ARCBank.ATMMsgs.No = "Non"
		ARCBank.ATMMsgs.Keypad = "Entrer en utilisant le clavier:"
		ARCBank.ATMMsgs.Enter = "Appuyer sur \"ENTRER\" pour continuer"
		ARCBank.ATMMsgs.File = "Dossier texte - Page %PAGE%"
		ARCBank.ATMMsgs.FileNext = "Page suivante"
		ARCBank.ATMMsgs.FilePrev = "Page precedente"
		ARCBank.ATMMsgs.FileClose = "Appuyer sur \"ANNULER\" pour fermer"
		ARCBank.ATMMsgs.PersonalInformation = "Information\nCompte Personnel"
		ARCBank.ATMMsgs.PersonalUpgrade = "Ameliorer/Creer\nCompte Personnel"
		ARCBank.ATMMsgs.GroupInformation = "Information\nCompte de Groupe"
		ARCBank.ATMMsgs.GroupUpgrade = "Ameliorer/Creer\nCompte de Groupe"
		ARCBank.ATMMsgs.Fullscreen = "Utiliser le\nplein écran"
		ARCBank.ATMMsgs.Exit = "Sortir"
		ARCBank.ATMMsgs.Back = "Revenir"
		ARCBank.ATMMsgs.More = "Plus"
		ARCBank.ATMMsgs.Deposit = "Deposer de\nl'argent"
		ARCBank.ATMMsgs.Withdrawal = "Retirer de\nl'argent"
		ARCBank.ATMMsgs.DepositAsk = "Combien voulez vous déposer?"
		ARCBank.ATMMsgs.WithdrawalAsk = "Combien voulez vous retirer?"
		ARCBank.ATMMsgs.Transfer = "Transferer des\nfonds"
		ARCBank.ATMMsgs.ViewLog = "Voir les logs"
		ARCBank.ATMMsgs.OtherNumber = "Autre montant"
		ARCBank.ATMMsgs.MainMenu = "Bienvenue, %PLAYERNAME%.\nComment puis-je vous aidez?"
		ARCBank.ATMMsgs.Balance = "Argent:"
		ARCBank.ATMMsgs.MaximumCash = "Une vie gachée"
		ARCBank.ATMMsgs.ChooseAccount = "S'il vous plaît, choisissez un compte"
		ARCBank.ATMMsgs.ChoosePlayer = "S'il vous plaît, choisissez un joueur"
		ARCBank.ATMMsgs.SIDPrompt = "Entrer après %TEXT%" -- This is used when the player is entering a steam ID (Enter after STEAM_0:0:)
		ARCBank.ATMMsgs.SIDAsk = "Est ce que le Steam ID commence avec STEAM_0:1?"
		ARCBank.ATMMsgs.Entered = "Entrer:"
		ARCBank.ATMMsgs.GiveMoneyAccount = "Choisissez le compte ou vous souhaitez donnez l'argent."
		ARCBank.ATMMsgs.PlayerTooFar = "Vous êtes trop loin de l'ATM."
		ARCBank.ATMMsgs.NumberTooHigh = "Vous ne pouvez pas utiliser un\nnombre plus grand que\n%NUM%!" -- This is used when the player tries to enter a number too high.
		ARCBank.ATMMsgs.CloseAccount = "Fermer le compte"
		ARCBank.ATMMsgs.AddPlayerGroup = "Ajouter un joueur\nau groupe"
		ARCBank.ATMMsgs.RemovePlayerGroup = "Enlever un joueur\nau groupe"
		ARCBank.ATMMsgs.CloseNotice = "Vous êtes sur le point de fermer ce\ncompte. Tous l'argent dedans sera\nconsiderer comme une \"donation\" au\ngroupe ARCBank.\n\nEtes vous sûr?"
		ARCBank.ATMMsgs.OpenAccount = "Voulez vous ouvrir un compte Personnel?"
		ARCBank.ATMMsgs.CreateGroupAccount = "*Creer un compte de Groupe"
		ARCBank.ATMMsgs.PersonalAccount = "*Compte Personnel      "
		ARCBank.ATMMsgs.AskMoney = "Combien d'argent voulez vous donner?"
		ARCBank.ATMMsgs.OfflinePlayer = "Joueur deconnecté" -- When you want to select a player that's currently offline.
		ARCBank.CardMsgs.NoOwner = "Aucun proprietaire n'est attribué"
		ARCBank.CardMsgs.Owner = "Le proprietaire est %PLAYER%"
		ARCBank.CardMsgs.InvalidOwner = "Vous ne possédez pas ce dispositif!"
		ARCBank.CardMsgs.NoCard = "Ce dispositif ne demande pas une carte!"
		ARCBank.CardMsgs.InsertCard = "Client, s'il vous plaît insérer votre carte."
		ARCBank.CardMsgs.Account = "Quel compte voulez-vous utiliser?" 
		ARCBank.CardMsgs.AccountPay = "Avec quel compte voulez-vous payer?"
		ARCBank.CardMsgs.Label = "Quelle est la marque de cette transaction?"

		ARCBank.UserMsgs.Hack = "An ATM is being hacked!"
	else
		ARCBankMsg("INVALID LANGUAGE - "..lang)
		ARCBank.UpdateLang("fr")
	end
end
timer.Simple(0,function()
	gibemoniplos = ARCLib.MoneyLimit
	booltonumber = ARCLib.BoolToNumber
	player.GetBySteamID = ARCLib.GetPlayerBySteamID
	player.GetNearest = ARCLib.GetNearestPlayer
	arc_timestring = ARCLib.TimeString
	arc_fitstring = ARCLib.SplitString
	arc_randomround = ARCLib.RandomRound
	arc_timesentence = ARCLib.TimeString
	arc_randomexp = ARCLib.RandomExp
end)


ARCBankMsg("Version: "..ARCBank.Version)
ARCBankMsg("Updated on: "..ARCBank.Update)
ARCBank.UpdateLang("fr")
if SERVER then
	
	function ARC_AddDir(dir) // recursively adds everything in a directory to be downloaded by client
		local files, directories = file.Find( dir.."/*", "GAME" )
		if !files then return end
		for _,v in pairs(files) do
			resource.AddSingleFile(dir.."/"..v)
		end
		for _, fdir in pairs(directories) do
			if fdir != ".svn" && fdir != "_svn" then // Don't spam people with useless .svn folders
				ARC_AddDir(dir.."/"..fdir)
			end
		end
	end
	ARC_AddDir("models/arc")
	ARC_AddDir("materials/arc")
	ARC_AddDir("sound/arcbank")
	resource.AddFile("materials/VGUI/entities/sent_arc_atm.vmt")
	resource.AddFile("materials/VGUI/entities/sent_arc_pinmachine.vmt")
	resource.AddFile("materials/VGUI/entities/weapon_arc_atmcard.vmt")
	resource.AddFile("materials/VGUI/entities/weapon_arc_atmhack.vmt")
	if file.Exists( "materials/arc/atm_base/logo2.vtf", "GAME" ) then
		resource.AddSingleFile( "materials/arc/atm_base/logo2.vtf" ) 
	else
		ARCBankMsg("WARNING! ATM LOGO FILE NOT FOUND! READ THE README!!!!")
	end
	AddCSLuaFile()
	ARCBankMsg("####     Loading Serverside Files..     ####")
	local serverfiles, _ = file.Find( "arcbank/server/*.lua", "LUA" )
	for i, v in ipairs( serverfiles ) do
		ARCBankMsg("#### Loading: /arcbank/server/"..v.." ####")
		include( "arcbank/server/"..v )
	end
	ARCBankMsg("####     Sending Clientside Files..     ####")
	local clientfiles, _ = file.Find( "arcbank/client/*.lua", "LUA" )
	for i, v in ipairs( clientfiles ) do
		ARCBankMsg("#### Sending: /arcbank/client/"..v.." ####")
		AddCSLuaFile( "arcbank/client/"..v )
		--include( "arcbank/client/"..v )
	end
	util.AddNetworkString( "ARCBank_Msg" )
	util.AddNetworkString( "ARC_Sound" )
	function ARCBankMsgCL(ply,msg)
		--net.Start( "ARCBank_Msg" )
		--net.WriteString( msg )
		if !ply || !ply:IsPlayer() then
			ARCBankMsg(tostring(msg))
		else
			ply:PrintMessage( HUD_PRINTTALK, "ARCBank: "..tostring(msg))
			--net.Send(ply)
		end
	end
	net.Receive( "ARCBank_Msg", function(length,ply)
		local msg = net.ReadString() 
		MsgN("ARCBank - "..ply:Nick().." ("..ply:SteamID().."): "..msg)
	end)
	ARCBankMsg("####  Serverside Lua Loading Complete.  ####")
	timer.Simple(1,ARCBank.Load)
else
	ARCBankMsg("####     Loading Clientside Files..     ####")
	function arcbank_plysound(snd,ent)
		ARCLib.PlaySoundOnOtherPlayers(snd,ent,65,100)
	end
	
	local clientfiles, _ = file.Find( "arcbank/client/*.lua", "LUA" )
	for i, v in pairs( clientfiles ) do
		ARCBankMsg("#### Loading: /arcbank/client/"..v.." ####")
		include( "arcbank/client/"..v )
	end

	net.Receive( "ARCBank_Msg", function(length)
		local msg = net.ReadString() 
		MsgC(Color(255,255,255,255),"ARCBank Server: "..tostring(msg).."\n")
	end)
	function ARCBankMsgToServer(msg)
		net.Start( "ARCBank_Msg" )
		net.WriteString( msg )
		net.SendToServer()
	end
	
	ARCBankMsg("####  Clientside Lua Loading Complete.  ####")
end
