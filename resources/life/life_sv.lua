RegisterServerEvent('garage:fixed')
AddEventHandler('garage:fixed', function()
  	print("Player ID " ..source)
  	local salary = 100
	-- Get the players money amount
	TriggerEvent('es:getPlayerFromId', source, function(user)

  	-- update player money amount
  	user:addMoney((salary + 0.0))
 	--TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Salaire de base de "..salary.." ~g~$ de reparation")
 	end)
end)