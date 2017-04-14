
function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end

function JobMenu()
    MenuTitle = "Choisis un metier"
    ClearMenu()
    Menu.addButton("Chauffeur de Bus","busJob")    
    Menu.addButton("Chauffeur de Taxi","taxiJob",nil) -- No arg
    Menu.addButton("Chauffeur de Fourgon Blindé","blindJob",nil) -- No arg
    Menu.addButton("Journaliste (Bientot)","newsJobs",nil)
    Menu.addButton("Rouleur (Bientot)","roulJob",nil)
    Menu.addButton("Eboueur (Bientot)","wasteJob",nil)
    Menu.addButton("Depaneur (Bientot)","towJob",nil)
    Menu.addButton("Livreur de pizza (Bientot)","pizzaJob",nil)
    Menu.addButton("Livreur de colis (Bientot)","colisJob",nil)
    Menu.addButton("Pecheur (Bientot)","fishJob",nil)
    Menu.addButton("Force de l'ordre (Bientot)","copJob",nil)
    Menu.addButton("Medecin (Bientot)","medicJob",nil)
    Menu.addButton("Chomeur","noJob",nil) 
    -- ...
end

function MissionText(text,time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
 end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            DecorRegister("job",  3)
        	NetworkSetFriendlyFireOption(true)
			--SetCanAttackFriendly(GetPlayerPed(-1), true, true)
            --TriggerServerEvent('life:getskin')
            blipPoleEmploi = AddBlipForCoord(-266.455108642578, -961.3701171875, 31.2231349945068)
            SetBlipSprite(blipPoleEmploi,  407) --416: RP - 407: i - 
            SetBlipColour(blipPoleEmploi,  3)
            SetBlipAsShortRange(blipPoleEmploi,  true)
            BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Pole Emploi')
			EndTextCommandSetBlipName(blipPoleEmploi)
            return
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        DecorRegister("job",  3)
        local lPlyCoords = GetEntityCoords(GetPlayerPed(-1),  true)
        DrawMarker(1, -266.455108642578, -961.3701171875, 30.2231349945068, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 2.0, 0, 192, 255, 70, 0, 0, 2, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(lPlyCoords.x, lPlyCoords.y, lPlyCoords.z, -266.455108642578, -961.3701171875, 31.2231349945068, true ) < 5 then
            --DrawRect(0.104, 0.4, 0.185, 0.206, 0, 0, 0, 150)
            --DrawAdvancedText(0.196, 0.316, 0.005, 0.0028, 0.856, "Pole Emploi", 255, 255, 255, 255, 1, 0)
            --DrawAdvancedText(0.194, 0.408, 0.005, 0.0028, 0.4, "Ici, bientot, un menu", 255, 255, 255, 255, 0, 0)
            MissionText("Appuie sur ~g~Valider~w~ pour ouvrir le menu", 1000)
            if IsControlJustPressed(1,  Keys["H"]) then --201=valider
                JobMenu()                     -- Menu to draw
                Menu.hidden = not Menu.hidden    -- Hide/Show the menu
            end
            Menu.renderGUI()
        end
    end
end)