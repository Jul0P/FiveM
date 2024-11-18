ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("G_Bank:pf") AddEventHandler("G_Bank:pf", function(fct, amount) TriggerClientEvent("G_Bank:portefeuille", source, ESX.GetPlayerFromId(source).getMoney()) end)
RegisterServerEvent("G_Bank:banque") AddEventHandler("G_Bank:banque", function(fct, amount) TriggerClientEvent("G_Bank:compte", source, ESX.GetPlayerFromId(source).getBank()) end)

RegisterServerEvent("deposer")
AddEventHandler("deposer", function(somme)
    if ESX.GetPlayerFromId(source).getMoney() >= somme then
    	ESX.GetPlayerFromId(source).addAccountMoney('bank', somme)
    	ESX.GetPlayerFromId(source).removeMoney(somme)
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Fleeca Bank', "Vous avez déposé ~g~"..somme.."$", 'CHAR_BANK_FLEECA', 9)
    else
        TriggerClientEvent('esx:showNotification', source, "Le montant est trop élevé")
    end    
end)

RegisterServerEvent("retirer")
AddEventHandler("retirer", function(somme)
    if ESX.GetPlayerFromId(source).getBank() >= somme then
    	ESX.GetPlayerFromId(source).removeAccountMoney('bank', somme)
    	ESX.GetPlayerFromId(source).addMoney(somme)
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Fleeca Bank', "Vous avez retiré ~g~"..somme.."$", 'CHAR_BANK_FLEECA', 9)
    else
        TriggerClientEvent('esx:showNotification', source, "Le montant est trop élevé")
    end    
end)

RegisterServerEvent('transfere')
AddEventHandler('transfere', function(iban2, montant2)
    local balance = 0
    if (ESX.GetPlayerFromId(iban2) == nil or ESX.GetPlayerFromId(iban2) == -1) then
        TriggerClientEvent('esx:showNotification', source, "Votre destinataire est introuvable")
    else
        balance = ESX.GetPlayerFromId(source).getAccount('bank').money
        zbalance = ESX.GetPlayerFromId(iban2).getAccount('bank').money
        if tonumber(source) == tonumber(iban2) then
            TriggerClientEvent('esx:showNotification', source, "Vous ne pouve pas transférer de l'argent à votre IBAN")
        else
            if balance <= 0 or balance < tonumber(montant2) or tonumber(montant2) <= 0 then
                TriggerClientEvent('esx:showAdvancedNotification', source, 'Fleeca Bank', "Infos Transfère", "Vous n'avez pas les fonds", 'CHAR_BANK_FLEECA', 9)
            else
                ESX.GetPlayerFromId(source).removeAccountMoney('bank', tonumber(montant2))
                ESX.GetPlayerFromId(iban2).addAccountMoney('bank', tonumber(montant2))
                TriggerClientEvent('esx:showAdvancedNotification', source, "Fleeca Bank", 'Infos Transfère', "Vous avez transféré ~g~"..montant2.."$\n~s~IBAN du destinataire : "..iban2..".", 'CHAR_BANK_FLEECA', 9)
                TriggerClientEvent('esx:showAdvancedNotification', iban2, "Fleeca Bank", 'Infos Transfère', "Vous avez reçu ~g~"..montant2.."$\n~s~IBAN de l'auteur : "..source..".", 'CHAR_BANK_FLEECA', 9)
            end
        end
    end
end)
