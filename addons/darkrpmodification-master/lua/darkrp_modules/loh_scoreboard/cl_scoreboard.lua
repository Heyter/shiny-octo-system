-- DarkRP scoreboard 
-- Coded by AC²

-- Remove these hooks first because FAdmin scoreboard 
hook.Remove("ScoreboardHide", "FAdmin_scoreboard")
hook.Remove("ScoreboardShow", "FAdmin_scoreboard")

-- Remove default scoreboard?
hook.Add("Initialize", "RemoveGamemodeFunctions", function()
    GAMEMODE.ScoreboardShow = nil 
    GAMEMODE.ScoreboardHide = nil
end)

-- Used later
local scoreboard

-- Create the scoreboard
local function CreateScoreboard()
    -- Settings
    local config = GetScoreboardConfig()

    -- Create a DFrame
    scoreboard = vgui.Create("DFrame")
    scoreboard:SetSize(ScrW() - (ScrW() / 2 - 200), ScrH() - 100)
    scoreboard:Center()
    scoreboard:SetTitle("")
    scoreboard:ShowCloseButton(false)
    scoreboard:SetDraggable(false)
    scoreboard:MakePopup()

    -- Since this is static
    local x, y = scoreboard:GetPos()

    -- Paint it
    scoreboard.Paint = function(self, w, h)
        -- Cut off the blur
        render.SetScissorRect(x, y, w + x, h + y, true)

        -- Draw blur
        if (config.bEnableBlur) then
            Derma_DrawBackgroundBlur(self, 0)
        end

        -- Black box
        surface.SetDrawColor(config.cBackground)
        surface.DrawRect(0, 0, w, h)

        -- Outline
        surface.SetDrawColor(config.cBackgroundOutline)
        surface.DrawOutlinedRect(0, 0, w, h)

        -- Header box
        surface.SetDrawColor(config.cHeader)
        surface.DrawRect(10, 10, w - 20, 90)

        -- Header outline
        surface.SetDrawColor(config.cLine)
        surface.DrawOutlinedRect(10, 10, w - 20, 90)

        -- Server name 
        draw.SimpleText(GetHostName(), "scoreboard.title", w / 2, 55, config.cServerName, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        -- Line under name
        surface.SetDrawColor(config.cLine)
        surface.DrawLine(10, 125, w - 10, 125)

        -- Secondary line
        surface.SetDrawColor(Color(62, 62, 62, 255))
        surface.DrawLine(10, 126, w - 10, 126)

        -- Player names label
        draw.SimpleText("Имя", "scoreboard.info", 13, 115, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        -- Player job label
        draw.SimpleText("Работа", "scoreboard.info", w / 2, 115, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        -- Player rank label
        draw.SimpleText("Ранг", "scoreboard.info", w - 75, 115, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

        -- Player ping label
        draw.SimpleText("Пинг", "scoreboard.info", w - 23, 115, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

        -- Здфнук сщгтекн дфиуд
        draw.SimpleText("Страна", "scoreboard.info", w - 129, 115, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

        -- Stop
        render.SetScissorRect(0, 0, 0, 0, false)
    end

    -- Scrollpanel
    local scrollpanel = scoreboard:Add("DScrollPanel")
    scrollpanel:SetPos(10, 130)
    scrollpanel:SetSize(scoreboard:GetWide() - 20 + 16, scoreboard:GetTall() - 140)

    -- Hide the scrollbar
    scrollpanel.VBar.Paint = function() end
    scrollpanel.VBar.btnUp.Paint = scrollpanel.VBar.Paint
    scrollpanel.VBar.btnDown.Paint = scrollpanel.VBar.Paint
    scrollpanel.VBar.btnGrip.Paint = scrollpanel.VBar.Paint

    -- Scoreboard update function
    scoreboard.Update = function()
        -- Clear the layout
        scrollpanel:Clear()

        -- Add all players
        for k, v in pairs(player.GetAll()) do
            -- Create a DPanel
            local panel = scrollpanel:Add("DPanel")
            panel:SetSize(scrollpanel:GetWide() - 16, 36)
            panel:SetPos(0, k * 37 - 37)

            local avatar = panel:Add("AvatarImage")
            avatar:SetSize(32, 32)
            avatar:SetPos(2, 2)
            avatar:SetPlayer(v)

            -- Paint over it
            avatar.PaintOver = function(self, w, h)
                -- Outline
                surface.SetDrawColor(config.cPlayerOutline)
                surface.DrawOutlinedRect(0, 0, w, h)
            end
        
            -- Get the color
            local clr = team.GetColor(v:Team())
            -- Reduces opacity
            clr.a = 170

            -- Get name, job, country
            local name = v:Name()
            local job = v:getJobTable().name
            local icon = config.mIconGroups[v:GetUserGroup()] or config.mIconGroups.guest
            local country = Material("flags16/"..system.GetCountry()..".png")

            -- Steamid checks
            if (config.mIconGroups[v:SteamID()]) then
                icon = config.mIconGroups[v:SteamID()]
            end

            -- Paint the DPanel
            panel.Paint = function(self, w, h)
                -- Invalid users up in my scoreboard?
                if not v:IsValid() then
                    -- Remove em and update
                    scoreboard:Update()
                    -- Stop
                    return
                end

                -- Background color
                surface.SetDrawColor(clr)
                surface.DrawRect(0, 0, w, h)

                -- Outline 
                surface.SetDrawColor(config.cPlayerOutline)
                surface.DrawOutlinedRect(0, 0, w, h)

                -- Player name
                draw.SimpleText(name, "scoreboard.player", 40, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                -- Player job
                draw.SimpleText(job, "scoreboard.player", w / 2 + 5, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                -- Player rang
                surface.SetDrawColor(color_white)
                surface.SetMaterial(icon)
                surface.DrawTexturedRect(w - 75 - 12, h / 2 - 8, 16, 16)

                -- Player ping
                draw.SimpleText(v:Ping(), "scoreboard.player", w - 20, h / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                
                -- Player country
                surface.SetDrawColor(color_white)
                surface.SetMaterial(country)
                surface.DrawTexturedRect(w - 75 - 75, h / 2 - 5, 20, 10) 
            end 
        end
    end

    -- Update when created aswell
    scoreboard:Update()
end 

-- Called when the tab button is pressed 
hook.Add("ScoreboardShow", "DarkRP.custom.scoreboard.show", function()
    -- Check if we already created it
    if not (scoreboard == nil) then
         -- Update
        scoreboard:Update()
         -- We did, just show it
        scoreboard:SetVisible(true)
    else 
        -- We didn't, create it
        CreateScoreboard()
    end 
end)

-- Called when you let go of the tab button 
hook.Add("ScoreboardHide", "DarkRP.custom.scoreboard.hide", function()
    -- Should it be invalid for some reason
    if (scoreboard) then
        -- Hide it
        scoreboard:SetVisible(false)
    end
end)