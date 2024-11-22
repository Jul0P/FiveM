if not pGangBuilder.LastLegacy then
    ESX = nil

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(5000)
        end
    end)
end

local SocietyName,SocietyLabel,SocietyGrade,SocietySalary = "","","",""

function SocietyMenu(k, v)
    local society_menu = false

    local Index4 = 1
    local Index5 = 1

    local mainMenu = RageUI.CreateMenu("Gestion Société", v.label)
    local subMenu = RageUI.CreateSubMenu(mainMenu, "Gestion des membres", v.label)
    local subMenu2 = RageUI.CreateSubMenu(mainMenu, "Gestion des grades", v.label)
    local subMenu3 = RageUI.CreateSubMenu(subMenu2, "Ajouter un grade", v.label)
    mainMenu.Closed = function()
        society_menu = false
    end
    if not society_menu then society_menu = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while society_menu do
                RageUI.IsVisible(mainMenu,function()
                    if v.society_gestion == "1" then
                        RageUI.Button("Gestion des membres", nil, {RightLabel = "→"}, true, {}, subMenu)
                        RageUI.Button("Gestion des grades", nil, {RightLabel = "→"}, true, {}, subMenu2)
                    else
                        if #getData.Employees == 0 then
                            RageUI.Separator("Aucun membre")
                        end
                        for y,z in pairs(getData.Employees) do
                            if z.job.grade_name == "boss" then
                                RageUI.List(z.name.." - "..z.job.grade_label, {"Recruter", "Virer", "Promouvoir", "Destituer"}, Index4, nil, {}, true, {
                                    onListChange = function(Index)
                                        Index4 = Index
                                    end,
                                    onSelected = function()
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                            if Index4 == 1 then
                                                TriggerServerEvent("pGangBuilder:proxyrecruter", z, GetPlayerServerId(closestPlayer))
                                                Wait(100)
                                                getDataEmployees(z.job.name)
                                            elseif Index4 == 2 then
                                                TriggerServerEvent("pGangBuilder:proxyvirer", z, GetPlayerServerId(closestPlayer))
                                                Wait(100)
                                                getDataEmployees(z.job.name)
                                            elseif Index4 == 3 then
                                                TriggerServerEvent("pGangBuilder:proxypromouvoir", z, GetPlayerServerId(closestPlayer))
                                                Wait(100)
                                                getDataEmployees(z.job.name)
                                            elseif Index4 == 4 then
                                                TriggerServerEvent("pGangBuilder:proxydestituer", z, GetPlayerServerId(closestPlayer))
                                                Wait(100)
                                                getDataEmployees(z.job.name)
                                            end
                                        else
                                            ESX.ShowNotification('Aucun joueur à proximité')
                                        end
                                    end
                                })
                                RageUI.Separator("↓ Liste des membres ↓")
                            else
                                RageUI.List(z.name.." - "..z.job.grade_label, {"Recruter", "Virer", "Promouvoir", "Destituer"}, Index4, nil, {}, true, {
                                    onListChange = function(Index)
                                        Index4 = Index
                                    end,
                                    onSelected = function()
                                        if Index4 == 1 then
                                            TriggerServerEvent("pGangBuilder:recruter", z)
                                            Wait(100)
                                            getDataEmployees(z.job.name)
                                        elseif Index4 == 2 then
                                            TriggerServerEvent("pGangBuilder:virer", z)
                                            Wait(100)
                                            getDataEmployees(z.job.name)
                                        elseif Index4 == 3 then
                                            TriggerServerEvent("pGangBuilder:promouvoir", z)
                                            Wait(100)
                                            getDataEmployees(z.job.name)
                                        elseif Index4 == 4 then
                                            TriggerServerEvent("pGangBuilder:destituer", z)
                                            Wait(100)
                                            getDataEmployees(z.job.name)
                                        end
                                    end
                                })
                            end
                        end
                    end
                end)
                RageUI.IsVisible(subMenu,function()
                    if #getData.Employees == 0 then
                        RageUI.Separator("Aucun membre")
                    end
                    for y,z in pairs(getData.Employees) do
                        if z.job.grade_name == "boss" then
                            RageUI.List(z.name.." - "..z.job.grade_label, {"Recruter", "Virer", "Promouvoir", "Destituer"}, Index4, nil, {}, true, {
                                onListChange = function(Index)
                                    Index4 = Index
                                end,
                                onSelected = function()
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer() 
                                    if closestPlayer ~= -1 and closestDistance <= 3.0 then                             
                                        if Index4 == 1 then
                                            TriggerServerEvent("pGangBuilder:proxyrecruter", z, GetPlayerServerId(closestPlayer))
                                            Wait(100)
                                            getDataEmployees(z.job.name)
                                        elseif Index4 == 2 then
                                            TriggerServerEvent("pGangBuilder:proxyvirer", z, GetPlayerServerId(closestPlayer))
                                            Wait(100)
                                            getDataEmployees(z.job.name)
                                        elseif Index4 == 3 then
                                            TriggerServerEvent("pGangBuilder:proxypromouvoir", z, GetPlayerServerId(closestPlayer))
                                            Wait(100)
                                            getDataEmployees(z.job.name)
                                        elseif Index4 == 4 then
                                            TriggerServerEvent("pGangBuilder:proxydestituer", z, GetPlayerServerId(closestPlayer))
                                            Wait(100)
                                            getDataEmployees(z.job.name)
                                        end
                                    else
                                        ESX.ShowNotification('Aucun joueur à proximité')
                                    end 
                                end
                            })
                            RageUI.Separator("↓ Liste des membres ↓")
                        else
                            RageUI.List(z.name.." - "..z.job.grade_label, {"Recruter", "Virer", "Promouvoir", "Destituer"}, Index4, nil, {}, true, {
                                onListChange = function(Index)
                                    Index4 = Index
                                end,
                                onSelected = function()                               
                                    if Index4 == 1 then
                                        TriggerServerEvent("pGangBuilder:recruter", z)
                                        Wait(100)
                                        getDataEmployees(z.job.name)
                                    elseif Index4 == 2 then
                                        TriggerServerEvent("pGangBuilder:virer", z)
                                        Wait(100)
                                        getDataEmployees(z.job.name)
                                    elseif Index4 == 3 then
                                        TriggerServerEvent("pGangBuilder:promouvoir", z)
                                        Wait(100)
                                        getDataEmployees(z.job.name)
                                    elseif Index4 == 4 then
                                        TriggerServerEvent("pGangBuilder:destituer", z)
                                        Wait(100)
                                        getDataEmployees(z.job.name)
                                    end
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(subMenu2,function() 
                    RageUI.Button("Ajouter un grade", nil, {RightLabel = "→"}, true, {}, subMenu3)
                    RageUI.Line()
                    if #getData.Grade == 0 then
                        RageUI.Separator("Aucun grade")
                    end                  
                    for y,z in pairs(getData.Grade) do
                        RageUI.List(z.label, {"Modifier le label", "Modifier le name", "Modifier le salaire", "Modifier le grade", "Supprimer"}, Index5, nil, {}, true, {
                            onActive = function()
                                RageUI.Info("Information des grades", 
                                    {
                                        "Label :", 
                                        "Name :", 
                                        "Salaire :", 
                                        "Numéro du grade :"
                                    }, 
                                    {
                                        "~b~"..z.label, 
                                        "~o~"..z.name, 
                                        "~g~"..z.salary.."$", 
                                        "~p~"..z.grade
                                    }
                                )
                            end,
                            onListChange = function(Index)
                                Index5 = Index
                            end,
                            onSelected = function()
                                if Index5 == 1 then
                                    SocietyLabel = KeyboardInput("Donner un label", z.label, 50)
                                    for a,b in pairs(getData.Grade) do
                                        if z.label ~= b.label then
                                            if b.label == SocietyLabel then
                                                ESX.ShowNotification("Vous ne pouvez pas avoir deux labels identique")
                                                return
                                            end
                                        end
                                    end
                                    if SocietyLabel == nil or SocietyLabel == "" or tonumber(SocietyLabel) then
                                        SocietyLabel = ""
                                        ESX.ShowNotification("Vous devez rentrer un label valide")
                                    else                       
                                        ESX.ShowNotification("Vous avez renommé ce grade ~b~"..SocietyLabel)
                                        TriggerServerEvent("pGangBuilder:modifySociety", "label", SocietyLabel, z) 
                                        Wait(100)
                                        getDataGrade(z.job_name) 
                                    end          
                                elseif Index5 == 2 then
                                    SocietyName = KeyboardInput("Donner un nom", z.name, 50)
                                    for a,b in pairs(getData.Grade) do
                                        if z.name ~= b.name then
                                            if b.name == SocietyName then
                                                ESX.ShowNotification("Vous ne pouvez pas avoir deux names identique")
                                                return
                                            end
                                        end
                                    end
                                    if SocietyName == nil or SocietyName == "" or tonumber(SocietyName) then
                                        SocietyName = ""
                                        ESX.ShowNotification("Vous devez rentrer un nom valide")
                                    else                       
                                        ESX.ShowNotification("Vous avez renommé ce grade ~b~"..SocietyName)
                                        TriggerServerEvent("pGangBuilder:modifySociety", "name", SocietyName, z)
                                        Wait(100)
                                        getDataGrade(z.job_name) 
                                    end
                                elseif Index5 == 3 then
                                    SocietySalary = KeyboardInput("Donner un salaire", z.salary, 50)
                                    for a,b in pairs(getData.Grade) do
                                        if z.salary ~= b.salary then
                                            if b.salary == tonumber(SocietySalary) then
                                                ESX.ShowNotification("Vous ne pouvez pas avoir deux names identique")
                                                return
                                            end
                                        end
                                    end
                                    if SocietySalary == nil or SocietySalary == "" or not tonumber(SocietySalary) then
                                        SocietySalary = ""
                                        ESX.ShowNotification("Vous devez rentrer un salaire valide")
                                    else                       
                                        ESX.ShowNotification("Vous avez redonné un salaire ~b~"..SocietySalary)
                                        TriggerServerEvent("pGangBuilder:modifySociety", "salary", SocietySalary, z)
                                        Wait(100)
                                        getDataGrade(z.job_name) 
                                    end
                                elseif Index5 == 4 then
                                    SocietyGrade = KeyboardInput("Donner un grade", z.grade, 50)
                                    for a,b in pairs(getData.Grade) do
                                        if z.grade ~= b.grade then
                                            if b.grade == tonumber(SocietyGrade) then
                                                ESX.ShowNotification("Vous ne pouvez pas avoir deux names identique")
                                                return
                                            end
                                        end
                                    end
                                    if SocietyGrade == nil or SocietyGrade == "" or not tonumber(SocietyGrade) then
                                        SocietyGrade = ""
                                        ESX.ShowNotification("Vous devez rentrer un grade valide")
                                    else                       
                                        ESX.ShowNotification("Vous avez redonné un grade ~b~"..SocietyGrade)
                                        TriggerServerEvent("pGangBuilder:modifySociety", "grade", SocietyGrade, z)
                                        Wait(100)
                                        getDataGrade(z.job_name) 
                                    end
                                elseif Index5 == 5 then
                                    TriggerServerEvent("pGangBuilder:modifySociety", "delete", true, z)
                                    Wait(100)
                                    getDataGrade(z.job_name)
                                end
                            end
                        })
                    end
                end)
                RageUI.IsVisible(subMenu3,function() 
                    RageUI.Button("Nom", nil, {RightLabel = "~b~"..SocietyName.." ~s~→"}, true, {
                        onSelected = function()
                            SocietyName = KeyboardInput("Donner un nom à votre grade", nil, 50)
                            if SocietyName == nil or SocietyName == "" then
                                SocietyName = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre grade ~b~"..SocietyName)
                            end
                        end
                    })
                    RageUI.Button("Label", nil, {RightLabel = "~b~"..SocietyLabel.." ~s~→"}, true, {
                        onSelected = function()
                            SocietyLabel = KeyboardInput("Donner un label à votre grade", nil, 50)
                            if SocietyLabel == nil or SocietyLabel == "" then
                                SocietyLabel = ""
                                ESX.ShowNotification("Vous devez rentrer un label valide")
                            else                       
                                ESX.ShowNotification("Vous avez mis un label sur votre grade ~b~"..SocietyLabel)
                            end
                        end
                    })
                    RageUI.Button("Grade", nil, {RightLabel = "~b~"..SocietyGrade.." ~s~→"}, true, {
                        onSelected = function()
                            SocietyGrade = KeyboardInput("Donner un numéro à votre grade", nil, 50)
                            if SocietyGrade == nil or SocietyGrade == "" or not tonumber(SocietyGrade) then
                                SocietyGrade = ""
                                ESX.ShowNotification("Vous devez rentrer un numéro valide")
                            else                       
                                ESX.ShowNotification("Vous avez numéroté votre grade ~b~"..SocietyGrade)
                            end
                        end
                    })
                    RageUI.Button("Salaire", nil, {RightLabel = "~g~"..SocietySalary.." ~s~→"}, true, {
                        onSelected = function()
                            SocietySalary = KeyboardInput("Donner un salaire à votre grade", nil, 50)
                            if SocietySalary == nil or SocietySalary == "" or not tonumber(SocietySalary) then
                                SocietySalary = ""
                                ESX.ShowNotification("Vous devez rentrer un salaire valide")
                            else     
                                SocietySalary = SocietySalary.."$"          
                                ESX.ShowNotification("Vous avez définis un salaire de ~b~"..SocietySalary)
                            end
                        end
                    })
                    RageUI.Button("Valider", nil, pGangBuilder.RightLabel, true, {
                        onSelected = function()                         
                            TriggerServerEvent("pGangBuilder:modifySociety", "add", {grade = SocietyGrade, name = SocietyName, label = SocietyLabel, salary = SocietySalary}, ESX.PlayerData.job2.name)
                            Wait(100)
                            SocietyName,SocietyLabel,SocietyGrade,SocietySalary = "","","",""
                            getDataGrade(ESX.PlayerData.job2.name)
                            RageUI.GoBack()
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

data_garage = {}

function GarageMenu(k, v)
    local garage_menu = false 
    local mainMenu = RageUI.CreateMenu("Garage", v.label)
    mainMenu.Closed = function()
        garage_menu = false
    end
    if not garage_menu then garage_menu = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while garage_menu do 
                RageUI.IsVisible(mainMenu,function() 
                    RageUI.Separator("↓ Véhicules prédéfinis ↓")
                    for _,y in pairs(data_garage) do         
                        if y.count == -1 then 
                            RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(y.props.model)).." ~g~∞", nil, {RightLabel = "[~o~"..y.plate.."~s~] →"}, true, {
                                onSelected = function()  
                                    SpawnVehicle(y.props, v.spawn_pos)
                                    RageUI.CloseAll()
                                    garage_menu = false
                                    data_garage = {}
                                end
                            })
                        elseif y.count ~= nil then
                            if y.count > 0 then
                                RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(y.props.model)).." ~g~x"..math.round(tonumber(y.count), 0), nil, {RightLabel = "[~o~"..y.plate.."~s~] →"}, true, {
                                    onSelected = function()
                                        table.remove(data_garage, _)
                                        table.insert(data_garage, _, {name = y.name, count = y.count - 1, plate = y.plate, props = y.props})   
                                        SpawnVehicle(y.props, v.spawn_pos)
                                        TriggerServerEvent("pGangBuilder:modifyGarage", v.id, data_garage)
                                        Wait(200)
                                        getDataGang()
                                        RageUI.CloseAll()
                                        garage_menu = false
                                        data_garage = {}
                                    end
                                })
                            end
                        end
                    end
                    if v.pnj == "1" then
                        RageUI.Separator("↓ Véhicules non-prédéfinis ↓")
                        for _,y in pairs(data_garage) do
                            if y.count == nil then
                                RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(y.props.model)), nil, {RightLabel = "[~o~"..y.plate.."~s~] →"}, true, {
                                    onSelected = function()  
                                        table.remove(data_garage, _)
                                        TriggerServerEvent("pGangBuilder:modifyGarage", v.id, data_garage)
                                        SpawnVehicle(y.props, v.spawn_pos)
                                        Wait(200)
                                        getDataGang()
                                        RageUI.CloseAll()
                                        garage_menu = false
                                        data_garage = {}
                                    end
                                })
                            end
                        end
                    end
                end)  
            Wait(0)
            end
        end)
    end
end

data_coffre_items = {}
data_coffre_weapons = {}

temp_name = {}
temp_name2 = {}

function CoffreMenu(k, v)
    local coffre_menu = false 
    local Index2 = 1
    local Index3 = 1

    local mainMenu = RageUI.CreateMenu("Coffre", v.label)
    local Withdraw = RageUI.CreateSubMenu(mainMenu, "Retirer", v.label)
    local Deposit = RageUI.CreateSubMenu(mainMenu, "Déposer", v.label)
    mainMenu.Closed = function()
        coffre_menu = false
    end
    if not coffre_menu then coffre_menu = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while coffre_menu do 
                RageUI.IsVisible(mainMenu,function() 
                    RageUI.Button("Retirer", nil, {RightLabel = "→"}, true, {}, Withdraw)          
                    RageUI.Button("Déposer", nil, {RightLabel = "→"}, true, {}, Deposit)      
                end)  
                RageUI.IsVisible(Withdraw,function() 
                    if pGangBuilder.LocalWeightActive or pGangBuilder.WeightActive then
                        local currentWeight = 0
                        if pGangBuilder.LocalWeightActive then
                            for y,z in pairs(getData.Gang[k].coffre_data.items) do
                                if z.count > 0 then
                                    for left,right in pairs(pGangBuilder.LocalWeight.Item) do
                                        if left == z.name then
                                            currentWeight = currentWeight + (z.count * right)
                                        end
                                    end
                                end
                            end
                        end
                        if pGangBuilder.WeightActive then
                            for y,z in pairs(getData.Gang[k].coffre_data.items) do
                                if z.count > 0 then
                                    for left,right in pairs(getData.Items) do
                                        if right.name == z.name then
                                            currentWeight = currentWeight + (z.count * right.weight)
                                        end
                                    end
                                end
                            end
                        end
                        for y,z in pairs(getData.Gang[k].coffre_data.weapons) do
                            if z.count > 0 then
                                for left,right in pairs(pGangBuilder.LocalWeight.Weapon) do
                                    if left == z.name then
                                        currentWeight = currentWeight + (z.count * right)
                                    end
                                end
                            end
                        end
                        currentWeight = currentWeight + (getData.Gang[k].coffre_data.money * pGangBuilder.LocalWeight.money) + (getData.Gang[k].coffre_data.dirtymoney * pGangBuilder.LocalWeight.dirtymoney)
                        RageUI.Separator("Poids : "..currentWeight.." / "..getData.Gang[k].weight.."Kg")
                    end
                    RageUI.Button("Argent Propre", nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(getData.Gang[k].coffre_data.money).."$ ~s~→"}, true, {
                        onSelected = function()
                            WithdrawMoney = KeyboardInput("Donner un montant à retirer", nil, 20)
                            if WithdrawMoney == nil or WithdrawMoney == "" or not tonumber(WithdrawMoney) or tonumber(WithdrawMoney) > getData.Gang[k].coffre_data.money or tonumber(WithdrawMoney) <= 0 then
                                WithdrawMoney = ""
                                ESX.ShowNotification("Vous devez rentrer un montant valide")
                            else             
                                TriggerServerEvent("pGangBuilder:giveMoneyCoffre", math.round(tonumber(WithdrawMoney), 0))
                                TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money - math.round(tonumber(WithdrawMoney), 0), dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                ESX.ShowNotification("Vous venez de retirer ~g~"..math.round(tonumber(WithdrawMoney), 0).."$")
                                Wait(200)
                                getDataGang()
                            end
                        end
                    })
                    RageUI.Button("Argent Sale", nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(getData.Gang[k].coffre_data.dirtymoney).."$ ~s~→"}, true, {
                        onSelected = function()
                            WithdrawDirtyMoney = KeyboardInput("Donner un montant à retirer", nil, 20)
                            if WithdrawDirtyMoney == nil or WithdrawDirtyMoney == "" or not tonumber(WithdrawDirtyMoney) or tonumber(WithdrawDirtyMoney) > getData.Gang[k].coffre_data.dirtymoney or tonumber(WithdrawDirtyMoney) <= 0 then
                                WithdrawDirtyMoney = ""
                                ESX.ShowNotification("Vous devez rentrer un montant valide")
                            else         
                                TriggerServerEvent("pGangBuilder:giveDirtyMoneyCoffre", math.round(tonumber(WithdrawDirtyMoney), 0))  
                                TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney - math.round(tonumber(WithdrawDirtyMoney), 0), items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                ESX.ShowNotification("Vous venez de retirer ~g~"..math.round(tonumber(WithdrawDirtyMoney), 0).."$")
                                Wait(200)
                                getDataGang()
                            end
                        end
                    })
                    RageUI.Line()
                    RageUI.List("Filtre :", {"Aucun", "Items", "Armes"}, Index2, nil, {}, true, {
                        onListChange = function(Index)
                            Index2 = Index
                        end
                    })
                    if Index2 == 1 or Index2 == 2 then
                        RageUI.Separator("↓ Liste des items ↓")
                        for y,z in pairs(data_coffre_items) do
                            RageUI.Button("~b~x"..math.round(tonumber(z.count), 0).." ~s~"..z.label, nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    DepositItem = KeyboardInput("Donner un item à retirer", nil, 20)
                                    if DepositItem == nil or DepositItem == "" or not tonumber(DepositItem) or z.count < math.round(tonumber(DepositItem), 0) or math.round(tonumber(DepositItem), 0) <= 0 then
                                        DepositItem = ""
                                        ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                    else
                                        TriggerServerEvent("pGangBuilder:giveItemCoffre", math.round(tonumber(DepositItem), 0), z.name)
                                        if (z.count - math.round(tonumber(DepositItem), 0)) >= 1 then
                                            table.remove(data_coffre_items, y)
                                            table.insert(data_coffre_items, y, {name = z.name, label = z.label, count = z.count - math.round(tonumber(DepositItem), 0)})
                                        else
                                            table.remove(data_coffre_items, y)
                                        end       
                                        TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = data_coffre_items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                        ESX.ShowNotification("Vous venez de retirer ~y~x"..math.round(tonumber(DepositItem), 0).." ~b~"..z.label)
                                        Wait(200)
                                        getDataGang()
                                    end
                                end
                            })
                        end
                    end
                    if Index2 == 1 or Index2 == 3 then
                        RageUI.Separator("↓ Liste des armes ↓")
                        for y,z in pairs(data_coffre_weapons) do
                            if z.munition ~= nil then 
                                RageUI.Button("~b~x"..math.round(tonumber(z.count), 0).." ~s~"..z.label.." (~o~x"..math.round(tonumber(z.munition), 0).."~s~)", nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        Amount = KeyboardInput("Donner un nombre de munition à retirer", nil, 5)
                                        if Amount == nil or Amount == "" or not tonumber(Amount) or z.munition < math.round(tonumber(Amount), 0) or math.round(tonumber(Amount), 0) < 0 then
                                            Amount = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                        else   
                                            ESX.TriggerServerCallback("pGangBuilder:hasWeapon", function(result)
                                                if result == true then
                                                    TriggerServerEvent("pGangBuilder:giveWeaponCoffre", math.round(tonumber(Amount), 0), z.name)
                                                    --if (z.munition - math.round(tonumber(Amount), 0)) >= 1 then
                                                        if (z.count - 1) >= 1 then
                                                            table.remove(data_coffre_weapons, y)
                                                            table.insert(data_coffre_weapons, y, {label = z.label, name = z.name, count = z.count-1, munition = z.munition - math.round(tonumber(Amount), 0)})
                                                        else
                                                            table.remove(data_coffre_weapons, y)
                                                        end
                                                    -- else
                                                    --     table.remove(data_coffre_weapons, y)
                                                    -- end       
                                                    TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = data_coffre_weapons})                                      
                                                    ESX.ShowNotification("Vous venez de retirer ~y~x1 ~b~"..z.label.." ~s~avec ~o~x"..math.round(tonumber(Amount), 0).." ~s~munitions")
                                                    Wait(200)
                                                    getDataGang()
                                                else
                                                    ESX.ShowNotification("Vous avez déjà cette arme sur vous")
                                                end
                                            end, z.name)
                                        end
                                    end
                                })
                            else             
                                RageUI.Button("~b~x"..math.round(tonumber(z.count), 0).." ~s~"..z.label, nil, {RightLabel = "→"}, true, {
                                    onSelected = function()  
                                        ESX.TriggerServerCallback("pGangBuilder:hasWeapon", function(result)
                                            if result == true then
                                                TriggerServerEvent("pGangBuilder:giveWeaponCoffre", 0, z.name)
                                                if (z.count - 1) >= 1 then
                                                    table.remove(data_coffre_weapons, y)
                                                    table.insert(data_coffre_weapons, y, {label = z.label, name = z.name, count = z.count-1, munition = nil})
                                                else
                                                    table.remove(data_coffre_weapons, y)
                                                end
                                                TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = data_coffre_weapons})                                      
                                                ESX.ShowNotification("Vous venez de retirer ~y~x1 ~b~"..z.label)
                                                Wait(200)
                                                getDataGang()
                                            else
                                                ESX.ShowNotification("Vous avez déjà cette arme sur vous")
                                            end
                                        end, z.name)
                                    end
                                })
                            end
                        end
                    end
                end)  
                RageUI.IsVisible(Deposit,function() 
                    ESX.PlayerData = ESX.GetPlayerData()
                    local currentWeight = 0
                    if pGangBuilder.LocalWeightActive then
                        for y,z in pairs(getData.Gang[k].coffre_data.items) do
                            if z.count > 0 then
                                for left,right in pairs(pGangBuilder.LocalWeight.Item) do
                                    if left == z.name then
                                        currentWeight = currentWeight + (z.count * right)
                                    end
                                end
                            end
                        end
                    end
                    if pGangBuilder.WeightActive then
                        for y,z in pairs(getData.Gang[k].coffre_data.items) do
                            if z.count > 0 then
                                for left,right in pairs(getData.Items) do
                                    if right.name == z.name then
                                        currentWeight = currentWeight + (z.count * right.weight)
                                    end
                                end
                            end
                        end
                    end
                    for y,z in pairs(getData.Gang[k].coffre_data.weapons) do
                        if z.count > 0 then
                            for left,right in pairs(pGangBuilder.LocalWeight.Weapon) do
                                if left == z.name then
                                    currentWeight = currentWeight + (z.count * right)
                                end
                            end
                        end
                    end
                    currentWeight = currentWeight + (getData.Gang[k].coffre_data.money * pGangBuilder.LocalWeight.money) + (getData.Gang[k].coffre_data.dirtymoney * pGangBuilder.LocalWeight.dirtymoney)
                    if pGangBuilder.NotLegacy then 
                        RageUI.Button("Argent Propre", nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(ESX.PlayerData.money).."$ ~s~→"}, true, {
                            onSelected = function()
                                DepositMoney = KeyboardInput("Donner un montant à déposer", nil, 20)
                                if DepositMoney == nil or DepositMoney == "" or not tonumber(DepositMoney) or tonumber(DepositMoney) > ESX.PlayerData.money or tonumber(DepositMoney) <= 0 then
                                    DepositMoney = ""
                                    ESX.ShowNotification("Vous devez rentrer un montant valide")
                                else  
                                    if pGangBuilder.LocalWeightActive or pGangBuilder.WeightActive then
                                        if currentWeight + (tonumber(DepositMoney) * pGangBuilder.LocalWeight.money) <= tonumber(getData.Gang[k].weight) then
                                            TriggerServerEvent("pGangBuilder:removeMoneyCoffre", math.round(tonumber(DepositMoney), 0))         
                                            TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money + math.round(tonumber(DepositMoney), 0), dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                            ESX.ShowNotification("Vous venez de déposer ~g~"..math.round(tonumber(DepositMoney), 0).."$")
                                            Wait(200)
                                            getDataGang()
                                        else
                                            ESX.ShowNotification("Il n'y a plus assez de place dans le coffre")
                                        end
                                    else
                                        TriggerServerEvent("pGangBuilder:removeMoneyCoffre", math.round(tonumber(DepositMoney), 0))         
                                        TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money + math.round(tonumber(DepositMoney), 0), dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                        ESX.ShowNotification("Vous venez de déposer ~g~"..math.round(tonumber(DepositMoney), 0).."$")
                                        Wait(200)
                                        getDataGang()
                                    end
                                end
                            end
                        })
                        for i = 1, #ESX.PlayerData.accounts, 1 do
                            if ESX.PlayerData.accounts[i].name == pGangBuilder.BlackMoney then
                                RageUI.Button("Argent Sale", nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).."$ ~s~→"}, true, {
                                    onSelected = function()
                                        DepositDirtyMoney = KeyboardInput("Donner un montant à déposer", nil, 20)
                                        if DepositDirtyMoney == nil or DepositDirtyMoney == "" or not tonumber(DepositDirtyMoney) or tonumber(DepositDirtyMoney) > ESX.PlayerData.accounts[i].money or tonumber(DepositDirtyMoney) <= 0 then
                                            DepositDirtyMoney = ""
                                            ESX.ShowNotification("Vous devez rentrer un montant valide")
                                        else    
                                            if pGangBuilder.LocalWeightActive or pGangBuilder.WeightActive then      
                                                if currentWeight + (tonumber(DepositDirtyMoney) * pGangBuilder.LocalWeight.dirtymoney) <= tonumber(getData.Gang[k].weight) then
                                                    TriggerServerEvent("pGangBuilder:removeDirtyMoneyCoffre", math.round(tonumber(DepositDirtyMoney), 0))       
                                                    TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney + math.round(tonumber(DepositDirtyMoney), 0), items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                                    ESX.ShowNotification("Vous venez de déposer ~g~"..math.round(tonumber(DepositDirtyMoney), 0).."$")
                                                    Wait(200)
                                                    getDataGang()
                                                else
                                                    ESX.ShowNotification("Il n'y a plus assez de place dans le coffre")
                                                end
                                            else
                                                TriggerServerEvent("pGangBuilder:removeDirtyMoneyCoffre", math.round(tonumber(DepositDirtyMoney), 0))       
                                                TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney + math.round(tonumber(DepositDirtyMoney), 0), items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                                ESX.ShowNotification("Vous venez de déposer ~g~"..math.round(tonumber(DepositDirtyMoney), 0).."$")
                                                Wait(200)
                                                getDataGang()
                                            end
                                        end
                                    end
                                })
                            end
                        end
                    else
                        for i = 1, #ESX.PlayerData.accounts, 1 do
                            if ESX.PlayerData.accounts[i].name == pGangBuilder.Money then
                                RageUI.Button("Argent Propre", nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).."$ ~s~→"}, true, {
                                    onSelected = function()
                                        DepositMoney = KeyboardInput("Donner un montant à déposer", nil, 20)
                                        if DepositMoney == nil or DepositMoney == "" or not tonumber(DepositMoney) or math.round(tonumber(DepositMoney), 0) > ESX.PlayerData.accounts[i].money or math.round(tonumber(DepositMoney), 0) <= 0 then
                                            DepositMoney = ""
                                            ESX.ShowNotification("Vous devez rentrer un montant valide")
                                        else  
                                            if pGangBuilder.LocalWeightActive or pGangBuilder.WeightActive then 
                                                if currentWeight + (tonumber(DepositMoney) * pGangBuilder.LocalWeight.money) <= tonumber(getData.Gang[k].weight) then
                                                    TriggerServerEvent("pGangBuilder:removeMoneyCoffre", math.round(tonumber(DepositMoney), 0))         
                                                    TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money + math.round(tonumber(DepositMoney), 0), dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                                    ESX.ShowNotification("Vous venez de déposer ~g~"..math.round(tonumber(DepositMoney), 0).."$")
                                                    Wait(200)
                                                    getDataGang()
                                                else
                                                    ESX.ShowNotification("Il n'y a plus assez de place dans le coffre")
                                                end
                                            else
                                                TriggerServerEvent("pGangBuilder:removeMoneyCoffre", math.round(tonumber(DepositMoney), 0))         
                                                TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money + math.round(tonumber(DepositMoney), 0), dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                                ESX.ShowNotification("Vous venez de déposer ~g~"..math.round(tonumber(DepositMoney), 0).."$")
                                                Wait(200)
                                                getDataGang()
                                            end
                                        end
                                    end
                                })
                            end
                            if ESX.PlayerData.accounts[i].name == pGangBuilder.BlackMoney then
                                RageUI.Button("Argent Sale", nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).."$ ~s~→"}, true, {
                                    onSelected = function()
                                        DepositDirtyMoney = KeyboardInput("Donner un montant à déposer", nil, 20)
                                        if DepositDirtyMoney == nil or DepositDirtyMoney == "" or not tonumber(DepositDirtyMoney) or math.round(tonumber(DepositDirtyMoney), 0) > ESX.PlayerData.accounts[i].money or math.round(tonumber(DepositDirtyMoney), 0) <= 0 then
                                            DepositDirtyMoney = ""
                                            ESX.ShowNotification("Vous devez rentrer un montant valide")
                                        else     
                                            if pGangBuilder.LocalWeightActive or pGangBuilder.WeightActive then      
                                                if currentWeight + (tonumber(DepositDirtyMoney) * pGangBuilder.LocalWeight.dirtymoney) <= tonumber(getData.Gang[k].weight) then
                                                    TriggerServerEvent("pGangBuilder:removeDirtyMoneyCoffre", math.round(tonumber(DepositDirtyMoney), 0))       
                                                    TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney + math.round(tonumber(DepositDirtyMoney), 0), items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                                    ESX.ShowNotification("Vous venez de déposer ~g~"..math.round(tonumber(DepositDirtyMoney), 0).."$")
                                                    Wait(200)
                                                    getDataGang()
                                                else
                                                    ESX.ShowNotification("Il n'y a plus assez de place dans le coffre")
                                                end
                                            else
                                                TriggerServerEvent("pGangBuilder:removeDirtyMoneyCoffre", math.round(tonumber(DepositDirtyMoney), 0))       
                                                TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney + math.round(tonumber(DepositDirtyMoney), 0), items = getData.Gang[k].coffre_data.items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                                ESX.ShowNotification("Vous venez de déposer ~g~"..math.round(tonumber(DepositDirtyMoney), 0).."$")
                                                Wait(200)
                                                getDataGang()
                                            end
                                        end
                                    end
                                })
                            end
                        end
                    end
                    RageUI.Line()
                    RageUI.List("Filtre :", {"Aucun", "Items", "Armes"}, Index3, nil, {}, true, {
                        onListChange = function(Index)
                            Index3 = Index
                        end
                    })
                    if Index3 == 1 or Index3 == 2 then
                        RageUI.Separator("↓ Liste des items ↓")
                        for i = 1, #ESX.PlayerData.inventory, 1 do
                            if ESX.PlayerData.inventory[i].count > 0 then
                                RageUI.Button("~b~x"..math.round(tonumber(ESX.PlayerData.inventory[i].count), 0).." ~s~"..ESX.PlayerData.inventory[i].label, nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        DepositItem = KeyboardInput("Donner un item à déposer", nil, 20)
                                        if DepositItem == nil or DepositItem == "" or not tonumber(DepositItem) or math.round(tonumber(ESX.PlayerData.inventory[i].count), 0) < math.round(tonumber(DepositItem), 0) or math.round(tonumber(DepositItem), 0) <= 0 then
                                            DepositItem = ""
                                            ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                        else
                                            if pGangBuilder.LocalWeightActive then
                                                for left,right in pairs(pGangBuilder.LocalWeight.Item) do
                                                    if left == ESX.PlayerData.inventory[i].name then
                                                        currentWeight = currentWeight + (DepositItem * right)
                                                    end
                                                end
                                            end
                                            if pGangBuilder.WeightActive then
                                                for left,right in pairs(getData.Items) do
                                                    if right.name == ESX.PlayerData.inventory[i].name then
                                                        currentWeight = currentWeight + (DepositItems * right.weight)
                                                    end
                                                end
                                            end
                                            if pGangBuilder.LocalWeightActive or pGangBuilder.WeightActive then 
                                                if currentWeight <= tonumber(getData.Gang[k].weight) then
                                                    TriggerServerEvent("pGangBuilder:removeItemCoffre", math.round(tonumber(DepositItem), 0), ESX.PlayerData.inventory[i].name)
                                                    for y,z in pairs(getData.Gang[k].coffre_data.items) do
                                                        temp_name = {name = z.name, value = y}
                                                    end
                                                    if temp_name.name == ESX.PlayerData.inventory[i].name then
                                                        if (ESX.PlayerData.inventory[i].count - math.round(tonumber(DepositItem), 0)) >= 1 then
                                                            table.remove(data_coffre_items, temp_name.value)
                                                            table.insert(data_coffre_items, temp_name.value, {name = ESX.PlayerData.inventory[i].name, label = ESX.PlayerData.inventory[i].label, count = getData.Gang[k].coffre_data.items[temp_name.value].count + math.round(tonumber(DepositItem), 0)})
                                                        else
                                                            table.remove(data_coffre_items, temp_name.value)
                                                        end 
                                                    else
                                                        table.insert(data_coffre_items, {name = ESX.PlayerData.inventory[i].name, label = ESX.PlayerData.inventory[i].label, count = math.round(tonumber(DepositItem), 0)})
                                                    end 
                                                    TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = data_coffre_items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                                    ESX.ShowNotification("Vous venez de déposer ~y~x"..math.round(tonumber(DepositItem), 0).." ~b~"..ESX.PlayerData.inventory[i].label)
                                                    Wait(200)
                                                    getDataGang()
                                                else
                                                    ESX.ShowNotification("Il n'y a plus assez de place dans le coffre")
                                                end
                                            else
                                                TriggerServerEvent("pGangBuilder:removeItemCoffre", math.round(tonumber(DepositItem), 0), ESX.PlayerData.inventory[i].name)
                                                for y,z in pairs(getData.Gang[k].coffre_data.items) do
                                                    temp_name = {name = z.name, value = y}
                                                end
                                                if temp_name.name == ESX.PlayerData.inventory[i].name then
                                                    if (ESX.PlayerData.inventory[i].count - math.round(tonumber(DepositItem), 0)) >= 1 then
                                                        table.remove(data_coffre_items, temp_name.value)
                                                        table.insert(data_coffre_items, temp_name.value, {name = ESX.PlayerData.inventory[i].name, label = ESX.PlayerData.inventory[i].label, count = getData.Gang[k].coffre_data.items[temp_name.value].count + math.round(tonumber(DepositItem), 0)})
                                                    else
                                                        table.remove(data_coffre_items, temp_name.value)
                                                    end 
                                                else
                                                    table.insert(data_coffre_items, {name = ESX.PlayerData.inventory[i].name, label = ESX.PlayerData.inventory[i].label, count = math.round(tonumber(DepositItem), 0)})
                                                end 
                                                TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = data_coffre_items, weapons = getData.Gang[k].coffre_data.weapons})                                      
                                                ESX.ShowNotification("Vous venez de déposer ~y~x"..math.round(tonumber(DepositItem), 0).." ~b~"..ESX.PlayerData.inventory[i].label)
                                                Wait(200)
                                                getDataGang()
                                            end
                                        end
                                    end
                                })
                            end
                        end
                    end
                    if Index3 == 1 or Index3 == 3 then
                        RageUI.Separator("↓ Liste des armes ↓")
                        for i = 1, #WeaponList, 1 do                        
                            if HasPedGotWeapon(PlayerPedId(), WeaponList[i].hash, false) then                               
                                local ammo = GetAmmoInPedWeapon(PlayerPedId(), WeaponList[i].hash)
                                local value = WeaponList[i].name
                                local label = WeaponList[i].label 
                                RageUI.Button("~b~x1 ~s~"..WeaponList[i].label.." (~o~x"..math.round(tonumber(GetAmmoInPedWeapon(PlayerPedId(), WeaponList[i].hash)), 0).."~s~)", nil, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        if GetAmmoInPedWeapon(PlayerPedId(), WeaponList[i].hash) ~= 0 then
                                            Amount = KeyboardInput("Donner un nombre de munition à déposer", nil, 5)
                                            if Amount == nil or Amount == "" or not tonumber(Amount) or GetAmmoInPedWeapon(PlayerPedId(), WeaponList[i].hash) < math.round(tonumber(Amount), 0) or math.round(tonumber(Amount), 0) <= 0 then
                                                Amount = ""
                                                ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                            else   
                                                for left,right in pairs(pGangBuilder.LocalWeight.Weapon) do
                                                    if left == WeaponList[i].name then
                                                        currentWeight = currentWeight + right
                                                    end
                                                end
                                                if pGangBuilder.LocalWeightActive or pGangBuilder.WeightActive then
                                                    if currentWeight <= tonumber(getData.Gang[k].weight) then
                                                        TriggerServerEvent("pGangBuilder:removeWeaponCoffre", math.round(tonumber(Amount), 0), WeaponList[i].name)
                                                        for y,z in pairs(getData.Gang[k].coffre_data.weapons) do
                                                            if WeaponList[i].name == z.name then
                                                                temp_name2 = {name = z.name, value = y, munition = z.munition}
                                                            end
                                                        end
                                                        if temp_name2.name == WeaponList[i].name then
                                                            table.remove(data_coffre_weapons, temp_name2.value)
                                                            table.insert(data_coffre_weapons, temp_name2.value, {name = WeaponList[i].name, label = WeaponList[i].label, count = (getData.Gang[k].coffre_data.weapons[temp_name2.value].count or 0) + 1, munition = (getData.Gang[k].coffre_data.weapons[temp_name2.value].munition or 0) + math.round(tonumber(Amount), 0)})
                                                        else
                                                            table.insert(data_coffre_weapons, {name = WeaponList[i].name, label = WeaponList[i].label, count = 1, munition = math.round(tonumber(Amount), 0)})
                                                        end    
                                                        TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = data_coffre_weapons})                                      
                                                        ESX.ShowNotification("Vous venez de retirer ~y~x1 ~b~"..WeaponList[i].label)
                                                        Wait(200)
                                                        getDataGang()
                                                        temp_name2 = {}
                                                    else
                                                        ESX.ShowNotification("Il n'y a plus assez de place dans le coffre")
                                                    end
                                                else
                                                    TriggerServerEvent("pGangBuilder:removeWeaponCoffre", math.round(tonumber(Amount), 0), WeaponList[i].name)
                                                    for y,z in pairs(getData.Gang[k].coffre_data.weapons) do
                                                        if WeaponList[i].name == z.name then
                                                            temp_name2 = {name = z.name, value = y, munition = z.munition}
                                                        end
                                                    end
                                                    if temp_name2.name == WeaponList[i].name then
                                                        table.remove(data_coffre_weapons, temp_name2.value)
                                                        table.insert(data_coffre_weapons, temp_name2.value, {name = WeaponList[i].name, label = WeaponList[i].label, count = (getData.Gang[k].coffre_data.weapons[temp_name2.value].count or 0) + 1, munition = (getData.Gang[k].coffre_data.weapons[temp_name2.value].munition or 0) + math.round(tonumber(Amount), 0)})
                                                    else
                                                        table.insert(data_coffre_weapons, {name = WeaponList[i].name, label = WeaponList[i].label, count = 1, munition = math.round(tonumber(Amount), 0)})
                                                    end    
                                                    TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = data_coffre_weapons})                                      
                                                    ESX.ShowNotification("Vous venez de retirer ~y~x1 ~b~"..WeaponList[i].label)
                                                    Wait(200)
                                                    getDataGang()
                                                    temp_name2 = {}
                                                end
                                            end
                                        else
                                            for left,right in pairs(pGangBuilder.LocalWeight.Weapon) do
                                                if left == WeaponList[i].name then
                                                    currentWeight = currentWeight + right
                                                end
                                            end
                                            if pGangBuilder.LocalWeightActive or pGangBuilder.WeightActive then
                                                if currentWeight <= tonumber(getData.Gang[k].weight) then
                                                    TriggerServerEvent("pGangBuilder:removeWeaponCoffre", 1, WeaponList[i].name)
                                                    for y,z in pairs(getData.Gang[k].coffre_data.weapons) do
                                                        if WeaponList[i].name == z.name then
                                                            if z.munition ~= nil then
                                                                temp_name2 = {name = z.name, value = y, munition = z.munition}
                                                            else
                                                                temp_name2 = {name = z.name, value = y, munition = nil}
                                                            end
                                                        end
                                                    end
                                                    if temp_name2.munition ~= nil then
                                                        if temp_name2.name == WeaponList[i].name then
                                                            table.remove(data_coffre_weapons, temp_name2.value)
                                                            table.insert(data_coffre_weapons, temp_name2.value, {name = WeaponList[i].name, label = WeaponList[i].label, count = (getData.Gang[k].coffre_data.weapons[temp_name2.value].count or 0) + 1, munition = (getData.Gang[k].coffre_data.weapons[temp_name2.value].munition or 0)})
                                                        else
                                                            table.insert(data_coffre_weapons, {name = WeaponList[i].name, label = WeaponList[i].label, count = 1, munition = (getData.Gang[k].coffre_data.weapons[temp_name2.value].munition or 0)})
                                                        end    
                                                    else
                                                        if temp_name2.name == WeaponList[i].name then
                                                            table.remove(data_coffre_weapons, temp_name2.value)
                                                            table.insert(data_coffre_weapons, temp_name2.value, {name = WeaponList[i].name, label = WeaponList[i].label, count = (getData.Gang[k].coffre_data.weapons[temp_name2.value].count or 0) + 1, munition = nil})
                                                        else
                                                            table.insert(data_coffre_weapons, {name = WeaponList[i].name, label = WeaponList[i].label, count = 1, munition = nil})
                                                        end 
                                                    end
                                                    TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = data_coffre_weapons})                                      
                                                    ESX.ShowNotification("Vous venez de retirer ~y~x1 ~b~"..WeaponList[i].label)
                                                    Wait(200)
                                                    getDataGang()
                                                    temp_name2 = {}
                                                else
                                                    ESX.ShowNotification("Il n'y a plus assez de place dans le coffre")
                                                end
                                            else
                                                TriggerServerEvent("pGangBuilder:removeWeaponCoffre", 1, WeaponList[i].name)
                                                for y,z in pairs(getData.Gang[k].coffre_data.weapons) do
                                                    if WeaponList[i].name == z.name then
                                                        if z.munition ~= nil then
                                                            temp_name2 = {name = z.name, value = y, munition = z.munition}
                                                        else
                                                            temp_name2 = {name = z.name, value = y, munition = nil}
                                                        end
                                                    end
                                                end
                                                if temp_name2.munition ~= nil then
                                                    if temp_name2.name == WeaponList[i].name then
                                                        table.remove(data_coffre_weapons, temp_name2.value)
                                                        table.insert(data_coffre_weapons, temp_name2.value, {name = WeaponList[i].name, label = WeaponList[i].label, count = (getData.Gang[k].coffre_data.weapons[temp_name2.value].count or 0) + 1, munition = (getData.Gang[k].coffre_data.weapons[temp_name2.value].munition or 0)})
                                                    else
                                                        table.insert(data_coffre_weapons, {name = WeaponList[i].name, label = WeaponList[i].label, count = 1, munition = (getData.Gang[k].coffre_data.weapons[temp_name2.value].munition or 0)})
                                                    end    
                                                else
                                                    if temp_name2.name == WeaponList[i].name then
                                                        table.remove(data_coffre_weapons, temp_name2.value)
                                                        table.insert(data_coffre_weapons, temp_name2.value, {name = WeaponList[i].name, label = WeaponList[i].label, count = (getData.Gang[k].coffre_data.weapons[temp_name2.value].count or 0) + 1, munition = nil})
                                                    else
                                                        table.insert(data_coffre_weapons, {name = WeaponList[i].name, label = WeaponList[i].label, count = 1, munition = nil})
                                                    end 
                                                end
                                                TriggerServerEvent("pGangBuilder:modifyCoffre", v.id, {money = getData.Gang[k].coffre_data.money, dirtymoney = getData.Gang[k].coffre_data.dirtymoney, items = getData.Gang[k].coffre_data.items, weapons = data_coffre_weapons})                                      
                                                ESX.ShowNotification("Vous venez de retirer ~y~x1 ~b~"..WeaponList[i].label)
                                                Wait(200)
                                                getDataGang()
                                                temp_name2 = {}
                                            end
                                        end
                                    end
                                })
                            end
                        end
                    end
                end)  
            Wait(0)
            end
        end)
    end
end

local ClothesIndex = 1
local boss_ClothesName = ""
local boss_data_clothes = {}
local boss_ModifyClothes = {value = nil, verify = false}

function VestiaireMenu(k, v)
    local vestiaire_menu = false 

    veste,veste1 = {},1
    vestecolor,vestecolor1 = {},1
    tshirt,tshirt1 = {},1
    tshirtcolor,tshirtcolor1 = {},1
    pantalon,pantalon1 = {},1
    pantaloncolor,pantaloncolor1 = {},1
    chaussure,chaussure1 = {},1
    chaussurecolor,chaussurecolor1 = {},1
    bras,bras1 = {},1
    calque,calque1 = {},1
    calquecolor,calquecolor1 = {},1
    chaine,chaine1 = {},1
    chainecolor,chainecolor1 = {},1
    casque,casque1 = {},1
    casquecolor,casquecolor1 = {},1
    lunette,lunette1 = {},1
    lunettecolor,lunettecolor1 = {},1
    oreille,oreille1 = {},1
    oreillecolor,oreillecolor1 = {},1
    montre,montre1 = {},1
    montrecolor,montrecolor1 = {},1
    bracelet,bracelet1 = {},1
    braceletcolor,braceletcolor1 = {},1
    sac,sac1 = {},1
    saccolor,saccolor1 = {},1

    local mainMenu = RageUI.CreateMenu("Vestiaire", v.label)
    local subMenu = RageUI.CreateSubMenu(mainMenu, "Gestion des tenues", v.label)
    local subMenu2 = RageUI.CreateSubMenu(subMenu, "Ajouter une tenue", v.label)
    mainMenu.Closed = function()
        vestiaire_menu = false
    end
    subMenu2.Closed = function()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        RenderScriptCams(0, 1, 1000, 1, 1)
        DestroyAllCams(true)
    end
    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Descendre"})
    subMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Monter"})

    subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 47, 0), [2] = "Tourner à Gauche"})
    subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 23, 0), [2] = "Tourner à Droite"}) 
    subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 82, 0), [2] = "Activer/Désactiver la Caméra"})
    subMenu2:AddInstructionButton({[1] = GetControlInstructionalButton(0, 22, 0), [2] = "Tourner 90°"})
    if not vestiaire_menu then vestiaire_menu = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while vestiaire_menu do 
                RageUI.IsVisible(mainMenu,function()  
                    mainMenu:UpdateInstructionalButtons(true) 
                    if v.society_gestion == "1" and ESX.PlayerData.job2.grade_name == "boss" then
                        RageUI.Button("Gestion des tenues", nil, {RightLabel = "→"}, true, {}, subMenu)
                        RageUI.Line()
                    end
                    RageUI.Button("Tenue : Civile", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin, jobSkin) 
                                TriggerEvent("skinchanger:loadSkin", skin)
                            end)
                        end
                    })
                    RageUI.Separator("↓ Liste des tenues ↓")
                    for y,z in pairs(getData.Gang[k].vestiaire_data) do
                        RageUI.Button(z.name, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                startAnimAction('missmic4', 'michael_tux_fidget')
                                Citizen.Wait(4500)
                                ClearPedTasks(PlayerPedId())
                                TriggerEvent("skinchanger:loadSkin", z.skin)
                            end
                        })
                    end                                      
                end)  
                RageUI.IsVisible(subMenu,function()  
                    subMenu:UpdateInstructionalButtons(true) 
                    RageUI.Button("Ajouter une tenue", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            boss_ModifyClothes = {value = nil, verify = false}
                            boss_ClothesName = ""
                            GetSkinValue() 
                            CreateMain() 
                            Wait(100) 
                            FreezeEntityPosition(GetPlayerPed(-1), true)
                        end
                    }, subMenu2)
                    RageUI.Separator("↓ Liste des tenues ↓")
                    if #boss_data_clothes == 0 then
                        RageUI.Separator("Aucune tenue présente") 
                    end
                    for y,z in pairs(boss_data_clothes) do
                        RageUI.List(z.name, {"Modifier", "Supprimer"}, ClothesIndex, nil, {}, true, {
                            onActive = function()
                                if y ~= GetkTable(boss_data_clothes) then
                                    if IsControlJustPressed(0, 11) then
                                        table.remove(boss_data_clothes, y)
                                        table.insert(boss_data_clothes, y+1, {name = z.name, skin = z.skin})
                                    end
                                end
                                if y ~= 1 then
                                    if IsControlJustPressed(0, 10) then
                                        table.remove(boss_data_clothes, y)
                                        table.insert(boss_data_clothes, y-1, {name = z.name, skin = z.skin})
                                    end 
                                end
                            end,
                            onListChange = function(Index)
                                ClothesIndex = Index
                            end,
                            onSelected = function()
                                if ClothesIndex == 1 then
                                    boss_ModifyClothes = {value = y, verify = true}
                                    boss_ClothesName = z.name
                                    veste1 = z.skin.torso_1+1
                                    vestecolor1 = z.skin.torso_2+1
                                    tshirt1 = z.skin.tshirt_1+1
                                    tshirtcolor1 = z.skin.tshirt_2+1
                                    pantalon1 = z.skin.pants_1+1
                                    pantaloncolor1 = z.skin.pants_2+1
                                    chaussure1 = z.skin.shoes_1+1
                                    chaussurecolor1 = z.skin.shoes_2+1
                                    bras1 = z.skin.arms+1
                                    calque1 = z.skin.decals_1+1
                                    calquecolor1 = z.skin.decals_2+1
                                    chaine1 = z.skin.chain_1+1
                                    chainecolor1 = z.skin.chain_2+1
                                    casque1 = z.skin.helmet_1+2
                                    casquecolor1 = z.skin.helmet_2+1
                                    lunette1 = z.skin.glasses_1+1
                                    lunettecolor1 = z.skin.glasses_2+1
                                    oreille1 = z.skin.ears_1+2
                                    oreillecolor1 = z.skin.ears_2+1
                                    montre1 = z.skin.watches_1+2
                                    montrecolor1 = z.skin.watches_2+1
                                    bracelet1 = z.skin.bracelets_1+2
                                    braceletcolor1 = z.skin.bracelets_2+1
                                    sac1 = z.skin.bags_1+1
                                    saccolor1 = z.skin.bags_2+1
                                    TriggerEvent('skinchanger:loadSkin', z.skin)
                                    GetSkinValue() 
                                    CreateMain() 
                                    Wait(100) 
                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                    RageUI.Visible(subMenu2, true)
                                elseif ClothesIndex == 2 then
                                    table.remove(boss_data_clothes, y)
                                end
                            end
                        })
                    end 
                    RageUI.Line()
                    RageUI.Button("Valider les nouvelles tenues", nil, pGangBuilder.RightLabel, true, {
                        onSelected = function()
                            TriggerServerEvent("pGangBuilder:saveNewClothes", v.id, boss_data_clothes)
                            Wait(200)
                            getDataGang()
                            RageUI.GoBack()
                        end
                    })
                end)
                RageUI.IsVisible(subMenu2,function() 
                    subMenu2:UpdateInstructionalButtons(true)   
                    GetIndex() 
                    Load_Clothes()                                        
                    RageUI.Button("Nom de la tenue", nil, {RightLabel = "~b~"..boss_ClothesName.." ~s~→"}, true, {
                        onSelected = function()
                            boss_ClothesName = KeyboardInput("Donner un nom à votre tenue", nil, 50)
                            if boss_ClothesName == nil or boss_ClothesName == "" then
                                boss_ClothesName = ""
                                ESX.ShowNotification("Vous devez rentrer un nom valide")
                            else                       
                                ESX.ShowNotification("Vous avez nommé votre tenue ~b~"..boss_ClothesName)
                            end
                        end
                    })
                    RageUI.Line()                
                    RageUI.List("Veste", veste, veste1, nil, {}, true, {
                        onListChange = function(Index)
                            veste1 = Index                          
                            TriggerEvent("skinchanger:change", "torso_1", veste1-1)
                            vestecolor1 = 1                         
                            TriggerEvent("skinchanger:change", "torso_2", vestecolor1-1) 
                        end                      
                    })
                    RageUI.List("Style de Veste", vestecolor, vestecolor1, nil, {}, true, {
                        onListChange = function(Index)
                            vestecolor1 = Index
                            TriggerEvent("skinchanger:change", "torso_2", vestecolor1-1)
                        end
                    })
                    RageUI.List("T-Shirt", tshirt, tshirt1, nil, {}, true, {
                        onListChange = function(Index)
                            tshirt1 = Index
                            TriggerEvent("skinchanger:change", "tshirt_1", tshirt1-1)
                            tshirtcolor1 = 1
                            TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)
                        end  
                    })
                    RageUI.List("Style de T-Shirt", tshirtcolor, tshirtcolor1, nil, {}, true, {
                        onListChange = function(Index)
                            tshirtcolor1 = Index
                            TriggerEvent("skinchanger:change", "tshirt_2", tshirtcolor1-1)                            
                        end
                    })
                    RageUI.List("Pantalon", pantalon, pantalon1, nil, {}, true, {
                        onListChange = function(Index)
                            pantalon1 = Index
                            TriggerEvent("skinchanger:change", "pants_1", pantalon1-1)
                            pantaloncolor1 = 1
                            TriggerEvent("skinchanger:change", "pants_2", pantaloncolor1-1)
                        end
                    })
                    RageUI.List("Style de Pantalon", pantaloncolor, pantaloncolor1, nil, {}, true, {
                        onListChange = function(Index)
                            pantaloncolor1 = Index
                            TriggerEvent("skinchanger:change", "pants_2", pantaloncolor1-1)
                        end
                    })
                    RageUI.List("Chaussure", chaussure, chaussure1, nil, {}, true, {
                        onListChange = function(Index)
                            chaussure1 = Index
                            TriggerEvent("skinchanger:change", "shoes_1", chaussure1-1)
                            chaussurecolor1 = 1
                            TriggerEvent("skinchanger:change", "shoes_2", chaussurecolor1-1)
                        end
                    })
                    RageUI.List("Style de Chaussure", chaussurecolor, chaussurecolor1, nil, {}, true, {
                        onListChange = function(Index)
                            chaussurecolor1 = Index
                            TriggerEvent("skinchanger:change", "shoes_2", chaussurecolor1-1)
                        end
                    })
                    RageUI.List("Bras", bras, bras1, nil, {}, true, {
                        onListChange = function(Index)
                            bras1 = Index
                            TriggerEvent("skinchanger:change", "arms", bras1-1)
                        end
                    })
                    RageUI.List("Calque", calque, calque1, nil, {}, true, {
                        onListChange = function(Index)
                            calque1 = Index
                            TriggerEvent("skinchanger:change", "decals_1", calque1-1)
                            calquecolor1 = 1
                            TriggerEvent("skinchanger:change", "decals_2", calquecolor1-1)
                        end
                    })
                    RageUI.List("Style de Calque", calquecolor, calquecolor1, nil, {}, true, {
                        onListChange = function(Index)
                            calquecolor1 = Index
                            TriggerEvent("skinchanger:change", "decals_2", calquecolor1-1)
                        end,
                        onSelected = function()
                            ESX.ShowNotification("Cet article n'est pas achetable seul")
                        end
                    })
                    RageUI.List("Chaine", chaine, chaine1, nil, {}, true, {
                        onListChange = function(Index)
                            chaine1 = Index
                            TriggerEvent("skinchanger:change", "chain_1", chaine1-1)
                            chainecolor1 = 1
                            TriggerEvent("skinchanger:change", "chain_2", chainecolor1-1)
                        end
                    })
                    RageUI.List("Style de Chaine", chainecolor, chainecolor1, nil, {}, true, {
                        onListChange = function(Index)
                            chainecolor1 = Index
                            TriggerEvent("skinchanger:change", "chain_2", chainecolor1-1)
                        end
                    })
                    RageUI.List("Casque", casque, casque1, nil, {}, true, {
                        onListChange = function(Index)
                            casque1 = Index
                            TriggerEvent("skinchanger:change", "helmet_1", casque1-2)
                            casquecolor1 = 1
                            TriggerEvent("skinchanger:change", "helmet_2", casquecolor1-1)
                        end
                    })
                    RageUI.List("Style de Casque", casquecolor, casquecolor1, nil, {}, true, {
                        onListChange = function(Index)
                            casquecolor1 = Index
                            TriggerEvent("skinchanger:change", "helmet_2", casquecolor1-1)
                        end,
                        onSelected = function()
                            ESX.ShowNotification("Cet article n'est pas achetable seul")
                        end
                    })
                    RageUI.List("Lunette", lunette, lunette1, nil, {}, true, {
                        onListChange = function(Index)
                            lunette1 = Index
                            TriggerEvent("skinchanger:change", "glasses_1", lunette1-1)
                            lunettecolor1 = 1
                            TriggerEvent("skinchanger:change", "glasses_2", lunettecolor1-1)
                        end
                    })
                    RageUI.List("Style de Lunette", lunettecolor, lunettecolor1, nil, {}, true, {
                        onListChange = function(Index)
                            lunettecolor1 = Index
                            TriggerEvent("skinchanger:change", "glasses_2", lunettecolor1-1)
                        end
                    })
                    RageUI.List("Accessoire d'Oreille", oreille, oreille1, nil, {}, true, {
                        onListChange = function(Index)
                            oreille1 = Index
                            TriggerEvent("skinchanger:change", "ears_1", oreille1-2)
                            oreillecolor1 = 1
                            TriggerEvent("skinchanger:change", "ears_2", oreillecolor1-1)
                        end
                    })
                    RageUI.List("Style d'Accessoire d'Oreille", oreillecolor, oreillecolor1, nil, {}, true, {
                        onListChange = function(Index)
                            oreillecolor1 = Index
                            TriggerEvent("skinchanger:change", "ears_2", oreillecolor1-1)
                        end
                    })
                    RageUI.List("Montre", montre, montre1, nil, {}, true, {
                        onListChange = function(Index)
                            montre1 = Index
                            TriggerEvent("skinchanger:change", "watches_1", montre1-2)
                            montrecolor1 = 1
                            TriggerEvent("skinchanger:change", "watches_2", montrecolor1-1)
                        end
                    })
                    RageUI.List("Style de Montre", montrecolor, montrecolor1, nil, {}, true, {
                        onListChange = function(Index)
                            montrecolor1 = Index
                            TriggerEvent("skinchanger:change", "watches_2", montrecolor1-1)
                        end
                    })
                    RageUI.List("Bracelet", bracelet, bracelet1, nil, {}, true, {
                        onListChange = function(Index)
                            bracelet1 = Index
                            TriggerEvent("skinchanger:change", "bracelets_1", bracelet1-2)
                            braceletcolor1 = 1
                            TriggerEvent("skinchanger:change", "bracelets_2", braceletcolor1-1)
                        end
                    })
                    RageUI.List("Style de Bracelet", braceletcolor, braceletcolor1, nil, {}, true, {
                        onListChange = function(Index)
                            braceletcolor1 = Index
                            TriggerEvent("skinchanger:change", "bracelets_2", braceletcolor1-1)
                        end
                    })
                    RageUI.List("Sac", sac, sac1, nil, {}, true, {
                        onListChange = function(Index)
                            sac1 = Index
                            TriggerEvent("skinchanger:change", "bags_1", sac1-1)
                            saccolor1 = 1
                            TriggerEvent("skinchanger:change", "bags_2", saccolor1-1)
                        end
                    })
                    RageUI.List("Style de Sac", saccolor, saccolor1, nil, {}, true, {
                        onListChange = function(Index)
                            saccolor1 = Index
                            TriggerEvent("skinchanger:change", "bags_2", saccolor1-1)
                        end
                    })
                    RageUI.Button("Valider", nil, pGangBuilder.RightLabel, true, {
                        onSelected = function()
                            if boss_ClothesName == nil or boss_ClothesName == "" then
                                ESX.ShowNotification("Vous n'avez pas donné de nom à la tenue")
                            else                       
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    if boss_ModifyClothes.verify == true then
                                        table.remove(boss_data_clothes, boss_ModifyClothes.value)
                                        table.insert(boss_data_clothes, boss_ModifyClothes.value, {name = boss_ClothesName, skin = skin})
                                        boss_ModifyClothes = {value = nil, verify = false}
                                        boss_ClothesName = ""
                                        RageUI.GoBack()
                                    else
                                        table.insert(boss_data_clothes, {name = boss_ClothesName, skin = skin})
                                        boss_ModifyClothes = {value = nil, verify = false}
                                        boss_ClothesName = ""
                                        RageUI.GoBack()
                                    end
                                end)
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                end)
                                FreezeEntityPosition(GetPlayerPed(-1), false)
                                RenderScriptCams(0, 1, 1000, 1, 1)
                                DestroyAllCams(true)
                            end                   
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(getData.Gang) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.name then
                if ESX.PlayerData.job2.grade_name == "boss" then
                    if v.society_pos ~= nil and v.society_pos ~= "" then               
                        local dist = Vdist(coords.x, coords.y, coords.z, v.society_pos.x, v.society_pos.y, v.society_pos.z)
                        if dist <= 2.0 then 
                            wait = 0
                            DrawMarker(v.markers.types, v.society_pos.x, v.society_pos.y, v.society_pos.z-1, 0.0, 0.0, 0.0, v.markers.rotX, v.markers.rotY, v.markers.rotZ, v.markers.scaleX, v.markers.scaleY, v.markers.scaleZ, v.markers.colorR, v.markers.colorV, v.markers.colorB, v.markers.colorO, false, false, p19, false) 
                            if dist <= 1.0 then 
                                wait = 0 
                                ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Menu Gestion Société - "..v.label)
                                if IsControlJustPressed(1,51) then 
                                    getDataEmployees(v.name)
                                    getDataGrade(v.name)
                                    Wait(100)
                                    SocietyMenu(k, v)
                                end
                            end
                        end
                    end
                end
                if v.garage_pos ~= nil and v.garage_pos ~= "" then               
                    local dist2 = Vdist(coords.x, coords.y, coords.z, v.garage_pos.x, v.garage_pos.y, v.garage_pos.z)
                    if dist2 <= 2.0 then 
                        wait = 0
                        DrawMarker(v.markers.types, v.garage_pos.x, v.garage_pos.y, v.garage_pos.z-1, 0.0, 0.0, 0.0, v.markers.rotX, v.markers.rotY, v.markers.rotZ, v.markers.scaleX, v.markers.scaleY, v.markers.scaleZ, v.markers.colorR, v.markers.colorV, v.markers.colorB, v.markers.colorO, false, false, p19, false) 
                        if dist2 <= 1.0 then 
                            wait = 0 
                            ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Menu Garage - "..v.label)
                            if IsControlJustPressed(1,51) then
                                data_garage = {}
                                GarageIndex = k
                                for y,z in pairs(getData.Gang[k].garage_data) do
                                    table.insert(data_garage, {name = z.name, count = z.count, plate = z.plate, props = z.props})
                                end
                                Wait(50)
                                GarageMenu(k, v)
                            end
                        end
                    end
                end
                if v.return_pos ~= nil and v.return_pos ~= "" then               
                    local dist3 = Vdist(coords.x, coords.y, coords.z, v.return_pos.x, v.return_pos.y, v.return_pos.z)
                    if dist3 <= 3.0 then 
                        wait = 0
                        DrawMarker(v.markers.types, v.return_pos.x, v.return_pos.y, v.return_pos.z-1, 0.0, 0.0, 0.0, v.markers.rotX, v.markers.rotY, v.markers.rotZ, v.markers.scaleX, v.markers.scaleY, v.markers.scaleZ, v.markers.colorR, v.markers.colorV, v.markers.colorB, v.markers.colorO, false, false, p19, false) 
                        if dist3 <= 2.0 then 
                            wait = 0 
                            ESX.ShowHelpNotification("~INPUT_TALK~ pour ranger votre véhicule dans le ~b~Garage - "..v.label)
                            if IsControlJustPressed(1,51) then
                                data_garage = {}
                                GarageIndex = k
                                for y,z in pairs(getData.Gang[k].garage_data) do
                                    table.insert(data_garage, {name = z.name, count = z.count, plate = z.plate, props = z.props})
                                end
                                Wait(50)
                                ReturnVehicle(k, v)
                            end
                        end
                    end
                end
                if v.coffre_pos ~= nil and v.coffre_pos ~= "" then               
                    local dist4 = Vdist(coords.x, coords.y, coords.z, v.coffre_pos.x, v.coffre_pos.y, v.coffre_pos.z)
                    if dist4 <= 2.0 then 
                        wait = 0
                        DrawMarker(v.markers.types, v.coffre_pos.x, v.coffre_pos.y, v.coffre_pos.z-1, 0.0, 0.0, 0.0, v.markers.rotX, v.markers.rotY, v.markers.rotZ, v.markers.scaleX, v.markers.scaleY, v.markers.scaleZ, v.markers.colorR, v.markers.colorV, v.markers.colorB, v.markers.colorO, false, false, p19, false) 
                        if dist4 <= 1.0 then 
                            wait = 0 
                            ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Menu Coffre - "..v.label)
                            if IsControlJustPressed(1,51) then 
                                data_coffre_items = {}
		                        data_coffre_weapons = {}
                                CoffreIndex = k
                                if not pGangBuilder.DebugDev then
                                    for y,z in pairs(v.coffre_data.items) do
                                        table.insert(data_coffre_items, {name = z.name, label = z.label, count = z.count})
                                    end
                                    for y,z in pairs(v.coffre_data.weapons) do
                                        table.insert(data_coffre_weapons, {label = z.label, name = z.name, count = z.count, munition = z.munition})
                                    end
                                else
                                    for y,z in pairs(getData.Gang[k].coffre_data.items) do
                                        table.insert(data_coffre_items, {name = z.name, label = z.label, count = z.count})
                                    end
                                    for y,z in pairs(getData.Gang[k].coffre_data.weapons) do
                                        table.insert(data_coffre_weapons, {label = z.label, name = z.name, count = z.count, munition = z.munition})
                                    end
                                end
                                Wait(50)
                                CoffreMenu(k, v)
                            end
                        end
                    end
                end
                if v.vestiaire_pos ~= nil and v.vestiaire_pos ~= "" then
                    local dist5 = Vdist(coords.x, coords.y, coords.z, v.vestiaire_pos.x, v.vestiaire_pos.y, v.vestiaire_pos.z)
                    if dist5 <= 2.0 then
                        wait = 0
                        DrawMarker(v.markers.types, v.vestiaire_pos.x, v.vestiaire_pos.y, v.vestiaire_pos.z-1, 0.0, 0.0, 0.0, v.markers.rotX, v.markers.rotY, v.markers.rotZ, v.markers.scaleX, v.markers.scaleY, v.markers.scaleZ, v.markers.colorR, v.markers.colorV, v.markers.colorB, v.markers.colorO, false, false, p19, false) 
                        if dist5 <= 1.0 then
                            wait = 0
                            ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Menu Vestiaire - "..v.label)
                            if IsControlJustPressed(1,51) then 
                                boss_data_clothes = {}
                                VestiaireIndex = k
                                if not pGangBuilder.DebugDev then
                                    for y,z in pairs(v.vestiaire_data) do
                                        table.insert(boss_data_clothes, {name = z.name, skin = z.skin})
                                    end
                                else
                                    for y,z in pairs(getData.Gang[k].vestiaire_data) do
                                        table.insert(boss_data_clothes, {name = z.name, skin = z.skin})
                                    end
                                end
                                Wait(50)
                                VestiaireMenu(k, v)
                            end
                        end
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

local Items = {}      
local Armes = {}   
local ArgentSale = {}  
local ArgentPropre = {}
local IsHandcuffed, DragStatus = false, {}
DragStatus.IsDragged = false

function getPlayerInv(player)
    Items = {}
    Armes = {}
    ArgentSale = {}
    ArgentPropre = {}
    ESX.TriggerServerCallback('pGangBuilder:getOtherPlayerData', function(data)
        if pGangBuilder.NotLegacy then
            if data.money > 0 then
                table.insert(ArgentPropre, {
                    amount = ESX.Math.Round(data.money),
                    value = pGangBuilder.Money,
                    itemType = 'item_money'
                })
            end
        else
            for i=1, #data.accounts, 1 do
                if data.accounts[i].name == pGangBuilder.Money and data.accounts[i].money > 0 then
                    table.insert(ArgentPropre, {
                        amount = ESX.Math.Round(data.accounts[i].money),
                        value = pGangBuilder.Money,
                        itemType = 'item_account'
                    })
                    break
                end
            end
        end
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == pGangBuilder.BlackMoney and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    amount = ESX.Math.Round(data.accounts[i].money),
                    value = pGangBuilder.BlackMoney,
                    itemType = 'item_account'
                })
                break
            end
        end
        for i=1, #data.weapons, 1 do
            table.insert(Armes, {
                label = ESX.GetWeaponLabel(data.weapons[i].name),
                value = data.weapons[i].name,
                amount = data.weapons[i].ammo,
                itemType = 'item_weapon'
            })
        end
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label = data.inventory[i].label,
                    amount = data.inventory[i].count,
                    value = data.inventory[i].name,
                    itemType = 'item_standard'
                })
            end
        end
    end, GetPlayerServerId(player))
end

function MenuF7(v)
    local menuf7_menu = false 
    local mainMenu = RageUI.CreateMenu("Menu F7", v.label)
    local subMenu = RageUI.CreateSubMenu(mainMenu, "Menu Fouille", v.label)
    mainMenu.Closed = function()
        menuf7_menu = false
    end
    if not menuf7_menu then menuf7_menu = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while menuf7_menu do 
                RageUI.IsVisible(mainMenu,function() 
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    RageUI.Button("Fouiller", nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, {
                        onSelected = function()
                            getPlayerInv(closestPlayer)
                        end
                    }, subMenu)
                    RageUI.Line()
                    RageUI.Button("Ligotter", nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, {
                        onSelected = function()
                            local target, distance = ESX.Game.GetClosestPlayer()
                            if distance <= 2.0 then
                                TriggerServerEvent('pGangBuilder:PutHandcuff', GetPlayerServerId(target), GetEntityHeading(GetPlayerPed(-1)), GetEntityCoords(GetPlayerPed(-1)), GetEntityForwardVector(PlayerPedId()))
                            end
                        end
                    })
                    RageUI.Button("Ligotter & Attacher", nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, {
                        onSelected = function()
                            local target, distance = ESX.Game.GetClosestPlayer()
                            if distance <= 2.0 then
                                TriggerServerEvent('pGangBuilder:PutHandcuffFreeze', GetPlayerServerId(target), GetEntityHeading(GetPlayerPed(-1)), GetEntityCoords(GetPlayerPed(-1)), GetEntityForwardVector(PlayerPedId()))
                            end
                        end
                    })
                    RageUI.Button("Déligotter", nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, {
                        onSelected = function()
                            local target, distance = ESX.Game.GetClosestPlayer()
                            if distance <= 2.0 then
                                TriggerServerEvent('pGangBuilder:RemoveHandcuff', GetPlayerServerId(target), GetEntityHeading(GetPlayerPed(-1)), GetEntityCoords(GetPlayerPed(-1)), GetEntityForwardVector(PlayerPedId()))
                            end
                        end
                    })
                    RageUI.Button("Escorter", nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, {
                        onSelected = function()
                            local target, distance = ESX.Game.GetClosestPlayer()
                            if distance <= 2.0 then
                                TriggerServerEvent('pGangBuilder:Escort', GetPlayerServerId(closestPlayer))
                            end
                        end
                    })
                    RageUI.Button("Mettre dans un véhicule", nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, {
                        onSelected = function()
                            local target, distance = ESX.Game.GetClosestPlayer()
                            if distance <= 2.0 then
                                TriggerServerEvent('pGangBuilder:putInVehicle', GetPlayerServerId(closestPlayer))
                            end
                        end
                    })
                    RageUI.Button("Sortir du véhicule", nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, {
                        onSelected = function()
                            local target, distance = ESX.Game.GetClosestPlayer()
                            if distance <= 2.0 then
                                TriggerServerEvent('pGangBuilder:OutVehicle', GetPlayerServerId(closestPlayer))
                            end
                        end
                    })
                end)  
                RageUI.IsVisible(subMenu,function() 
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if #ArgentPropre ~= 0 then
                        RageUI.Separator("↓ Argent Propre ↓")
                    end
                    for k,v in pairs(ArgentPropre) do
                        RageUI.Button("Argent Propre", nil, {RightLabel = "~g~"..v.amount.."$"}, true, {
                            onSelected = function()
                                local AmountMoney = KeyboardInput("Donner le montant d'argent sale que vous souhaitez retirer", nil, 100)
                                if AmountMoney == nil or AmountMoney == "" or not tonumber(AmountMoney) then
                                    ESX.ShowNotification("Vous devez rentrer un montant valide")
                                else
                                    TriggerServerEvent('pGangBuilder:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(AmountMoney))
                                    getPlayerInv(closestPlayer)
                                end
                            end	
                        })
                    end
                    if #ArgentSale ~= 0 then
                        RageUI.Separator("↓ Argent Sale ↓")
                    end
                    for k,v in pairs(ArgentSale) do
                        RageUI.Button("Argent sale", nil, {RightLabel = "~r~"..v.amount.."$"}, true, {
                            onSelected = function()
                                local AmountDirtyMoney = KeyboardInput("Donner le montant d'argent sale que vous souhaitez retirer", nil, 100)
                                if AmountDirtyMoney == nil or AmountDirtyMoney == "" or not tonumber(AmountDirtyMoney) then
                                    ESX.ShowNotification("Vous devez rentrer un montant valide")
                                else
                                    TriggerServerEvent('pGangBuilder:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(AmountDirtyMoney))
                                    getPlayerInv(closestPlayer)
                                end
                            end	
                        })
                    end
                    if #Items ~= 0 then
                        RageUI.Separator("↓ Items ↓")
                    end
                    for k,v in pairs(Items) do
                        RageUI.Button(v.label, nil, {RightLabel = "~b~x"..v.amount}, true, {
                            onSelected = function()
                                local AmountItem = KeyboardInput("Donner le nombre d'item que vous souhaitez retirer", nil, 10)
                                if AmountItem == nil or AmountItem == "" or not tonumber(AmountItem) then
                                    ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                else
                                    TriggerServerEvent('pGangBuilder:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(AmountItem))
                                    getPlayerInv(closestPlayer)
                                end
                            end
                        })
                    end
                    if #Armes ~= 0 then 
                        RageUI.Separator("↓ Armes ↓")
                    end
                    for k,v in pairs(Armes) do
                        RageUI.Button(v.label, nil, {RightLabel = "~o~x"..v.amount}, true, {
                            onSelected = function()
                                local AmountWeapon = KeyboardInput("Donner le nombre de munition que vous souhaitez retirer", nil, 10)
                                if AmountWeapon == nil or AmountWeapon == "" or not tonumber(AmountWeapon) then
                                    ESX.ShowNotification("Vous devez rentrer un nombre valide")
                                else
                                    TriggerServerEvent('pGangBuilder:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(AmountWeapon))
                                    getPlayerInv(closestPlayer)
                                end
                            end
                        })
                    end
                end)
            Wait(0)
            end
        end)
    end
end

Keys.Register("F7", "openf7menu", "Ouvrir le menu f7", function()
    for k,v in pairs(getData.Gang) do
        if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.name then
            MenuF7(v)
        end
    end
end)