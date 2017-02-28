AddCSLuaFile()
net.Receive("NLRBox",
    function()
    ///// NFrame ///// - This contains the title of the whole NLR Box, BackGround Blur and if you can drag the box around the screen.
    local titletext = "На пол минуты в Чистилище" --Here you can change the title of the box
    local backgroundblur = true --Enable or disable blur around the box
    local makedraggable = false --Here you can change if you want the box to be drag-gable by your mouse
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
    ///// NPanel /////
    --[[NOTHING TO CONFIGURE HERE]]--
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
    ///// NLabel ///// - This is the text that shows up inside the NLR Box. Customize it how you please.
    local warningtext = [[Умерли ли вы по собственной глупости или вас убили - не важно. 
Вам запрещено возвращаться на место собственной смерти в течение трех минут, 
и запрещено мстить убийце. 
    Начните жизнь с чистого листа.]]
    local lfont = "DermaDefault"
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
    ///// NButton ///// -  This contains the button text, timer wait, and the timer text.
   
    local buttontext = "В мир живых" --Here you can change the spawn button text
    local bfont = "HUDSmall" -- Here you can change the button
    local tfont = "HUDSmall" -- Here you can change the countdown font to whatever you would like
    local timerwait = 10 --Here you can change how long you want to wait for the timer to countdown
    local timertext = "Подождите "..tostring(timerwait).." секунд" --Here you can change the timer button text
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 
 
 
    local NFrame = vgui.Create( "DFrame" )
    NFrame:SetPos( (surface.ScreenWidth()/2)-300, (surface.ScreenHeight()/2)-100)
    NFrame:SetSize( 600, 200)
    NFrame:SetTitle(titletext)
    NFrame:SetBackgroundBlur( backgroundblur )
    NFrame:SetVisible( true)
    NFrame:SetDraggable(makedraggable)
    NFrame:ShowCloseButton( false )
    NFrame:MakePopup()
    NFrame.Paint = function()
        draw.RoundedBox( 8, 0, 0, NFrame:GetWide(), NFrame:GetTall(), Color( 71, 49, 29, 255 ) )
    end
 
    local NPanel = vgui.Create( "DPanel", NFrame )
    NPanel:SetSize( 578, 150)
    NPanel:SetPos( 10, 31)
    NPanel.Paint = function()
        surface.SetDrawColor(43,29,17,255 )
        surface.DrawRect( 0, 0, NPanel:GetWide(), NPanel:GetTall() )
    end
 
 
 
    local NLabel = vgui.Create( "DLabel", NPanel )
    NLabel:SetPos(105, 30)
    NLabel:SetText(warningtext)
    NLabel:SetFont(lfont)
    NLabel:SetTextColor(TCB_Settings.PrimaryColor)
    NLabel:SizeToContents()
 
    local NButton = vgui.Create( "DButton", NFrame )
    NButton:SetPos( 210, 131 )
    NButton:SetText(timertext)
    NButton:SetFont(bfont)
	NButton:SetTextColor(TCB_Settings.BlackColor)
    NButton:SetSize( 180, 30 )
    NButton.Hover = false
    NButton.Active = false
    NButton.OnCursorEntered   = function() NButton.Hover = true  end
    NButton.OnCursorExited    = function() NButton.Hover = false end
    NButton.Paint = function( pnl, w, h )

        if NButton.Active == false then

            draw.RoundedBox( 0, 0, 0, w, h, Color(227, 210, 161, 255) )

            if NButton.Hover == false then
                draw.RoundedBox( 0, 0, 0, w, h, Color(227, 210, 161, 255) )
            else
                draw.RoundedBox( 0, 0, 0, w, h, Color(186, 175, 140, 255) )
            end
        end
        surface.DrawRect( 0, 0, NButton:GetWide(), NButton:GetTall() )            
    end

    NButton:SetDisabled( true )
   
    NButton.DoClick = function ()
        if NButton:GetDisabled() then
            return
        else
            NFrame:Close()
            net.Start("NLRBox")
            net.SendToServer()
        end
    end
    timer.Create("maintimer",timerwait+1,1,function() NButton:SetText(buttontext)
                                                NButton:SetDisabled(false)end)
    timer.Create("aaaaaa",1,timerwait+1, function() NButton:SetText("Подождите "..math.floor(timer.TimeLeft("maintimer")).." секунд") end)
   
   
end)