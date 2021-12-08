local PLUGIN = PLUGIN

PLUGIN.name = "Lite Network Intro System"
PLUGIN.author = "Riggs Mackay"
PLUGIN.description = "An Intro system that starts once you load your character for the first time."

if ( CLIENT ) then
    PLUGIN.IntroMusic = "LiteNetwork/hl2rp/music/teaser.ogg"
    if ( game.GetMap("rp_city17_district47_litenetwork") ) then
        PLUGIN.IntroInformation = {
            [1] = {{Vector(-891, -1999, 228), Angle(9, -164, 0)}, {Vector(566, -2299, 71), Angle(-0, 174, 0)}, "Welcome to Lite Network! We are a Half-Life 2 Semi-Serious, Roleplay Community."},
            [2] = {{Vector(-3507, 2042, 433), Angle(-6, 131, 0)}, {Vector(-7036, 2024, 449), Angle(-4, 52, 0)}, "You earn 5 XP every 10 Minutes, Which will be used for Factions and ranks within."},
            [3] = {{Vector(-694, 889, 434), Angle(4, -0, 0)}, {Vector(2092, 917, 334), Angle(-9, -18, 0)}, "Roleplay opportunities are present on many factions. Combine, Citizen and Resistance. Which can immerse you within the Half life universe."},
            [4] = {{Vector(-783, -203, 421), Angle(0, 5, 0)}, {Vector(-101, -194, 471), Angle(8, 11, 0)}, "Every hour, you gain the ability to retrieve your ration in one of these stations. Where of course you get fed by the Benefactors."},
            [5] = {{Vector(3221, 1332, 403), Angle(7, 61, 0)}, {Vector(3965, 1341, 400), Angle(5, 123, 0)}, "You may open up bars, stores, factories.. whatever you like as a Civil Worker's Union. Due to their loyalty to the Universal Union."},
            [6] = {{Vector(-5140, 4485, 803), Angle(17, 119, 0)}, {Vector(-5902, 4541, 810), Angle(13, 44, 0)}, "The Benefactors, called the Universal Union which are also referred to as; 'The Combine' have taken over earth in a matter of only seven hours!"},
            [7] = {{Vector(-6191, 823, 429), Angle(-3, -15, 0)}, {Vector(-5589, 503, 604), Angle(-42, 65, 0)}, "You may resist and seek shelter in the sewers, try to build a revolution, Take back what humanity has lost. But it will certainly be no easy task."},
            [8] = {{Vector(-9141, 2934, 403), Angle(0, 14, 0)}, {Vector(-8060, 2942, 437), Angle(-22, 35, 0)}, "If you resist against the Benefactors, you may end up stirring the hornet's nest and face the full might of the Combine. So watch yourself."},
            [9] = {{Vector(3519, -3009, 581), Angle(8, 162, 0)}, {Vector(-336, -2108, 288), Angle(8, -178, 0)}, "It is up to you to make decisions that depend on your characters life. What they do, What they're like. All up to you."},
            [10] = {{Vector(-5184, 3410, 426), Angle(-6, -75, 0)}, {Vector(-5835, 3180, 949), Angle(-30, -75, 0)}, "Welcome to Lite Network. We hope you enjoy your stay and have a good time!"},
        }
    elseif ( game.GetMap("rp_city17__litenetwork") ) then
        PLUGIN.IntroInformation = {
            [1] = {{Vector(-891, -1999, 228), Angle(9, -164, 0)}, {Vector(566, -2299, 71), Angle(-0, 174, 0)}, "Welcome to Lite Network! We are a Half-Life 2 Semi-Serious, Roleplay Community."},
            [2] = {{Vector(-3507, 2042, 433), Angle(-6, 131, 0)}, {Vector(-7036, 2024, 449), Angle(-4, 52, 0)}, "You earn 5 XP every 10 Minutes, Which will be used for Factions and ranks within."},
            [3] = {{Vector(-694, 889, 434), Angle(4, -0, 0)}, {Vector(2092, 917, 334), Angle(-9, -18, 0)}, "Roleplay opportunities are present on many factions. Combine, Citizen and Resistance. Which can immerse you within the Half life universe."},
            [4] = {{Vector(-783, -203, 421), Angle(0, 5, 0)}, {Vector(-101, -194, 471), Angle(8, 11, 0)}, "Every hour, you gain the ability to retrieve your ration in one of these stations. Where of course you get fed by the Benefactors."},
            [5] = {{Vector(3221, 1332, 403), Angle(7, 61, 0)}, {Vector(3965, 1341, 400), Angle(5, 123, 0)}, "You may open up bars, stores, factories.. whatever you like as a Civil Worker's Union. Due to their loyalty to the Universal Union."},
            [6] = {{Vector(-5140, 4485, 803), Angle(17, 119, 0)}, {Vector(-5902, 4541, 810), Angle(13, 44, 0)}, "The Benefactors, called the Universal Union which are also referred to as; 'The Combine' have taken over earth in a matter of only seven hours!"},
            [7] = {{Vector(-6191, 823, 429), Angle(-3, -15, 0)}, {Vector(-5589, 503, 604), Angle(-42, 65, 0)}, "You may resist and seek shelter in the sewers, try to build a revolution, Take back what humanity has lost. But it will certainly be no easy task."},
            [8] = {{Vector(-9141, 2934, 403), Angle(0, 14, 0)}, {Vector(-8060, 2942, 437), Angle(-22, 35, 0)}, "If you resist against the Benefactors, you may end up stirring the hornet's nest and face the full might of the Combine. So watch yourself."},
            [9] = {{Vector(3519, -3009, 581), Angle(8, 162, 0)}, {Vector(-336, -2108, 288), Angle(8, -178, 0)}, "It is up to you to make decisions that depend on your characters life. What they do, What they're like. All up to you."},
            [10] = {{Vector(-5184, 3410, 426), Angle(-6, -75, 0)}, {Vector(-5835, 3180, 949), Angle(-30, -75, 0)}, "Welcome to Lite Network. We hope you enjoy your stay and have a good time!"},
        }
    end

    local function ixIntroStart(ply)
        ply.ixIntroBool = true

        ply.ixIntroPos = nil
        ply.ixIntroAng = nil
        ply.ixIntroStage = 1
        ply.ixIntroStageDelay = CurTime() + 15

        net.Start("ixIntroStarted")
            net.WriteVector(PLUGIN.IntroInformation[ply.ixIntroStage][1][1])
        net.SendToServer()

        timer.Simple(1, function() surface.PlaySound(PLUGIN.IntroMusic) end)
    end

    net.Receive("ixIntroStart", function()
        ixIntroStart(LocalPlayer())
    end)

    function PLUGIN:HUDPaint()
        local ply = LocalPlayer()

        if ( LocalPlayer().ixIntroBool ) then
            if ( IsValid(PlayerIcon) ) then
                PlayerIcon:Remove()
            end

            local letterBoxHeight = 100

            surface.SetDrawColor(color_black)
            surface.DrawRect(0, 0, ScrW(), letterBoxHeight)
            surface.DrawRect(0, (ScrH() - letterBoxHeight) + 1, ScrW(), letterBoxHeight)

            if not ( PLUGIN.IntroInformation[ply.ixIntroStage] ) then return end

            draw.DrawText(PLUGIN.IntroInformation[ply.ixIntroStage][3] or "", "LiteNetworkFont32", ScrW() / 2, ScrH() - 60 , color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    function PLUGIN:CalcView(ply, pos, ang, fov)
        if ( ply.ixIntroBool ) then
            local view = {
                origin = pos,
                angles = ang,
                fov = fov,
            }

            if not ( ply.ixIntroStage ) then
                ply.ixIntroStage = 1
            end

            if not ( ply.ixIntroStageDelay ) then
                ply.ixIntroStageDelay = CurTime() + 15
            end

            if not ( PLUGIN.IntroInformation[ply.ixIntroStage] ) then return end

            if not ( ply.ixIntroPos or ply.ixIntroAng ) then
                ply.ixIntroPos = PLUGIN.IntroInformation[ply.ixIntroStage][1][1]
                ply.ixIntroAng = PLUGIN.IntroInformation[ply.ixIntroStage][1][2]

                net.Start("ixIntroStarted")
                    net.WriteVector(PLUGIN.IntroInformation[ply.ixIntroStage][1][1])
                net.SendToServer()
            end
    
            ply.ixIntroPos = LerpVector(FrameTime() * 0.2, ply.ixIntroPos, PLUGIN.IntroInformation[ply.ixIntroStage][2][1])
            ply.ixIntroAng = LerpAngle(FrameTime() * 0.2, ply.ixIntroAng, PLUGIN.IntroInformation[ply.ixIntroStage][2][2])
    
            if ( ply.ixIntroStageDelay < CurTime() ) then
                ply.ixIntroStage = ply.ixIntroStage + 1
                ply.ixIntroStageDelay = CurTime() + 15
    
                ply:ScreenFade(SCREENFADE.OUT, color_black, 0, 2)
                ply:ScreenFade(SCREENFADE.IN, color_black, 2, 0.75)
    
                if ( PLUGIN.IntroInformation[ply.ixIntroStage] ) then
                    ply.ixIntroPos = PLUGIN.IntroInformation[ply.ixIntroStage][1][1]
                    ply.ixIntroAng = PLUGIN.IntroInformation[ply.ixIntroStage][1][2]

                    net.Start("ixIntroUpdate")
                        net.WriteVector(PLUGIN.IntroInformation[ply.ixIntroStage][1][1])
                    net.SendToServer()
                else
                    net.Start("ixIntroComplete")
                    net.SendToServer()

                    surface.PlaySound("music/hl2_song2.mp3")

                    ply.ixIntroBool = nil
                end
            end
    
            view.origin = ply.ixIntroPos
            view.angles = ply.ixIntroAng
            view.fov = 60
    
            return view
        end
    end

    concommand.Add("ix_dev_getpos", function(ply)
        local pos = ply:GetPos()
        local introDetails = "Vector("..pos.x..", "..pos.y..", "..pos.z..")"

        SetClipboardText(introDetails)
    end)

    concommand.Add("ix_dev_getang", function(ply)
        local ang = ply:GetAngles()
        local introDetails = "Angle("..ang.p..", "..ang.y..", "..ang.r..")"

        SetClipboardText(introDetails)
    end)

    concommand.Add("ix_dev_getposang", function(ply)
        local pos = ply:GetPos()
        local introDetails = "Vector("..pos.x..", "..pos.y..", "..pos.z..")"

        local ang = ply:GetAngles()
        local introDetails = introDetails..", Angle("..ang.p..", "..ang.y..", "..ang.r..")"

        SetClipboardText(introDetails)
    end)

    concommand.Add("ix_dev_startintro", function()
        ixIntroStart(LocalPlayer())
    end)

    concommand.Add("ix_dev_endintro", function()
        LocalPlayer().ixIntroBool = false
    
        LocalPlayer().ixIntroStage = nil

        net.Start("ixIntroComplete")
        net.SendToServer()

        LocalPlayer():ConCommand("play music/hl2_song2.mp3")
    end)
end

ix.util.Include("sv_plugin.lua")