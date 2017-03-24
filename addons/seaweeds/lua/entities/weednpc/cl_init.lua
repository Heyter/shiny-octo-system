include('shared.lua')
surface.CreateFont( "dialogueFont", {
	font = "Open Sans",
	size = 18,
	weight = 400,
	antialias = true
} )

net.Receive( "weedmenudialogue", function()

	local price = LocalPlayer():GetWeedPrice()
	local text = ""
	if price == 0 then
		text = "Ты бы еще консервных банок насобирал. Не видел вывеску снаружи? Иди на набережную и ищи водоросли в реке. Куплю их у тебя по приятной цене. Приятной для меня, хе."
	else
		text = "Отлично, хороший товар. Могу заплатить "..price.."$ за все. По рукам?"
	end
	local mainFrame = vgui.Create("DFrame")
	mainFrame:SetSize(500, 190)
	mainFrame:SetPos(ScrW() / 2 - (500 / 2), ScrH() / 1.5)
	mainFrame:SetDraggable( true )
	mainFrame:MakePopup()
	mainFrame:ShowCloseButton( false )
	mainFrame:SetTitle("Скупщик растений")

	local closeButton = vgui.Create("DButton", mainFrame)
	closeButton:SetSize( 75, 25 )
	closeButton:SetPos( 425 , 0 )
	closeButton:SetColor( Color( 0, 0, 0 ))
	closeButton:SetText("X")


	closeButton.DoClick = function()
		mainFrame:Close()
	end


	local panel = vgui.Create("DScrollPanel", mainFrame)
	panel:SetSize(488, 95)
	panel:SetPos(6, 30)
	panel.Paint = function(p,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, Color(255,255,255))
	end
	local dialogueTextLabel = vgui.Create("DLabel", panel)
	dialogueTextLabel:SizeToContents()
	dialogueTextLabel:SetPos(3,3)
	dialogueTextLabel:SetColor(Color(50, 50, 50))
	dialogueTextLabel:SetFont("dialogueFont")
	dialogueTextLabel:SetText( text)
	dialogueTextLabel:SetWrap( true )
	dialogueTextLabel:SetWide( 470 )
	dialogueTextLabel:SetAutoStretchVertical( true )

	local dialogueButton2 = vgui.Create("DFlatButton", mainFrame)
	dialogueButton2:SetSize(488, 25)
	dialogueButton2:SetPos(6, 155)
	dialogueButton2:SetText( "Продать все" )
	dialogueButton2.DoClick = function()
		LocalPlayer():SellWeeds()
		if price > 0 then
				chat.AddText(Color(127,255,0,255),"Успешная сделка! Вы продали водорослей на "..tostring(price).."$")
				sound.PlayFile( "sound/getmoney.wav", "", function( station )
					if ( IsValid( station ) ) then station:Play() end
				end )
		end
		mainFrame:Close()
	end

	local dialogueButton1 = vgui.Create("DFlatButton", mainFrame)
	dialogueButton1:SetSize(488, 25)
	dialogueButton1:SetPos(6, 128)
	dialogueButton1:SetText( "Узнать цены" )	
	dialogueButton1.DoClick = function()
		dialogueTextLabel:SetText("Ну, значит так, по ценам расклад следующий:\n\nМягкий Алмаз и Синецвет за 10$,\nКрасноцвет по 15$,\nПодводную Шишку по 30$, \nУтопшего Шута возьму по 50$, \nЗашедшее Солнце по 45$, \nСвет реки, если тебе повезет, по 250$.")
		
	end	
	
		

end)

function ENT:onHover()
	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 32500 then return end
		draw.SimpleTextOutlined("Нажмите \'Е\' чтобы поговорить с","DermaDefault",ScrW()/2,ScrH()/2+20,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
		draw.SimpleTextOutlined("Скупщиком водорослей","DermaDefault",ScrW()/2,ScrH()/2+35,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))

end