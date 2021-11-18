ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterServerEvent("ace_drugs:coke", function(type)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local cokeCount = math.random(1, 7)
	local transformChance = math.random(1, 4)

	if type == "Collecting" and xPlayer.getInventoryItem("coke").count < 60 then
		xPlayer.showNotification('Pomyślnie zebrano ' .. cokeCount .. ' Liści Kokainy', 'warning', 'OSTRZEŻENIE')
		xPlayer.addInventoryItem('coke', cokeCount)
	else if type == "Collecting" and xPlayer.getInventoryItem("coke").count >= 60 then
		xPlayer.showNotification('Nie posiadasz miejsca w ekwipunku!', 'warning', 'OSTRZEŻENIE')
		end
	end


	if type == "Transform" and xPlayer.getInventoryItem("chem1_3").count >= 5 and xPlayer.getInventoryItem("coke").count >= 3 and transformChance ~= 1 then
		xPlayer.showNotification('Pomyślnie wytworzyłeś Porcję Kokainy', '', 'OSTRZEŻENIE')
		xPlayer.removeInventoryItem('coke', 3)
		xPlayer.addInventoryItem('coke_pooch', 1)
	else if type == "Transform" and xPlayer.getInventoryItem("chem1_3").count < 5 or xPlayer.getInventoryItem("coke").count < 3 then
		xPlayer.showNotification('Nie posiadasz wystarczającej ilośći przedmiotów do wytworzenia Porcji Kokainy', 'warning', 'OSTRZEŻENIE')
		else if type == "Transform" and transformChance == 1 then
			xPlayer.showNotification('Przy wytwarzaniu Porcji Kokainy oparzyłeś się Chemikaliami!', 'warning', 'OSTRZEŻENIE')
			TriggerClientEvent('dragi:oparzenie', source)
			end
		end
	end
end)


RegisterServerEvent('ace_drugs:chemikalia', function(type)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local miszankoChance = math.random(1, 4)

	if(type == "Mieszanie") then 
		if(xPlayer.getInventoryItem("chem"))
	end


end)

RegisterServerEvent("ace_drugs:meth", function(type)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local methCount = math.random(1, 4)
	local methChance = math.random(1, 6)

	if type == "Collecting" and xPlayer.getInventoryItem("meth").count < 60 and xPlayer.getInventoryItem("chem1_3").count >= 5 and methChance ~= 1 or methChance ~= 4 then
		xPlayer.showNotification('Wytworzono ' .. methCount .. " Kryształu Metamfetaminy", 'poprawny', 'NARKOTYKI')
		xPlayer.addInventoryItem("meth", methCount)
		xPlayer.removeInventoryItem('chem1_3', 5)
	else if type == "Collecting" and xPlayer.getInventoryItem("meth").count >= 60 then
		xPlayer.showNotification('Nie posiadasz miejsca w ekwipunku', 'warning', 'OSTRZEŻENIE')
	else if type == "Collecting" and xPlayer.getInventoryItem("chem1_3").count < 5 then
		xPlayer.showNotification('Nie posiadasz wystarczającej ilości Chemikaliów', 'warning', 'OSTRZEŻENIE')
	else if type == "Collecting" and methChance == 4 or methChance == 1 then
		xPlayer.showNotification('Przy gotowaniu metamfetaminy poparzyłeś się', 'warning', 'OSTRZEŻENIE')	
		TriggerClientEvent('dragi:oparzenie', source)
			end
		end	
	end
end
		if type == "Transform" and xPlayer.getInventoryItem('meth').count >= 3 then
			xPlayer.showNotification('Wytworzono 1 Porcje Metamfetaminy', 'poprawny', 'NARKOTYKI')
			xPlayer.removeInventoryItem('meth', 3)
			xPlayer.addInventoryItem('meth_pooch', 1)
		else if type == "Transform" and xPlayer.getInventoryItem('meth').count < 3 then
			xPlayer.showNotification('Nie posiadasz wystarczającej ilośći Kryształu Metamfetaminy', 'niepoprawny', 'NARKOTYKI')
		end
	end
end)