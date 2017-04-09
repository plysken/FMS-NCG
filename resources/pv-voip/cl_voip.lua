local voip = {}
voip['default'] = {name = 'default', setting = 15.0}
voip['local'] = {name = 'local', setting = 10.0}
voip['whisper'] = {name = 'whisper', setting = 2.0}
voip['yell'] = {name = 'yell', setting = 25.0}

local radio = false

AddEventHandler('onClientMapStart', function()
	NetworkSetTalkerProximity(voip['default'].setting)
end)

function RadioTalk()
	if not radio then
		radio = true
		NotificationMessage("Vous parlez sur le canal 1")
		NetworkSetVoiceChannel(1)
		NetworkSetVoiceActive(true)
	elseif radio then
		radio = false
		NotificationMessage("Vous parlez normallement")
		--NetworkSetTalkerProximity(voip['default'].setting)
    	N_0xe036a705f989e049()
    	NetworkSetVoiceActive(true)
    end
end



Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(1, 214) or IsDisabledControlJustPressed(1, 214) then --Trouver la touche "E"
			RadioTalk()
        end
    end
end)

RegisterNetEvent('pv:voip')
AddEventHandler('pv:voip', function(voipDistance)

	if voip[voipDistance]then
		distanceName = voip[voipDistance].name
		distanceSetting = voip[voipDistance].setting
	else
		distanceName = voip['default'].name
		distanceSetting = voip['default'].setting
	end
	
	NotificationMessage("Your VOIP is now ~b~" .. distanceName ..".")
	NetworkSetTalkerProximity(distanceSetting)
		
end)

function NotificationMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end