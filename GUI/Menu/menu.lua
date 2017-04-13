RegisterNUICallback("animation", function(data, cb)

	local playerPed = GetPlayerPed(-1)
	local action = data.action

	if action == "dance" then
		-- Mettre l'action ici
		drawNotification("~g~Vous dansez.")
	end

	cb("ok")
end)

RegisterNUICallback("savepos", function(data, cb)

	local action = data.action

	if action == "mine" then
		-- Mettre l'action ici
		drawNotification("~g~Test.")
	end


	cb("ok")
end)
