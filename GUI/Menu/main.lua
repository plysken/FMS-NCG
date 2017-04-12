local afficherMenu = false

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if IsControlJustReleased(1, 167) and not blockinput then -- f6 (Voir pour changer la touche plus tard)
			if not afficherMenu then
				afficherMenu = true
				SendNUIMessage({
					afficherMenu = true
				})
			else
				afficherMenu = false
				SendNUIMessage({
					masquerMenu = true
				})
			end
		end

		if afficherMenu and not blockinput then
			if IsControlJustReleased(1, 176) then -- Entrer
				SendNUIMessage({
					menuEnter = true
				})
			elseif IsControlJustReleased(1, 177) then -- Retour / Clique droit
				SendNUIMessage({
					menuBack = true
				})
			end

			if IsControlJustReleased(1, 172) then -- Haut
				SendNUIMessage({
					menuUp = true
				})
			elseif IsControlJustReleased(1, 173) then -- Bas
				SendNUIMessage({
					menuDown = true
				})
			end

			if IsControlJustReleased(1, 174) then -- Gauche
				SendNUIMessage({
					menuLeft = true
				})
			elseif IsControlJustReleased(1, 175) then -- Droite
				SendNUIMessage({
					menuRight = true
				})
			end
		end
	end
end)

RegisterNUICallback("playsound", function(data, cb)
	PlaySoundFrontend(-1, data.name, "HUD_FRONTEND_DEFAULT_SOUNDSET",  true)

	cb("ok")
end)

RegisterNUICallback("fermertureMenu", function(data, cb)
	afficherMenu = false

	cb("ok")
end)

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function stringsplit(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end
