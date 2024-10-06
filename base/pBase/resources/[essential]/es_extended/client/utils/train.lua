if Config.ActivateTrain then
    local trains = {}
    local inTram = false

    local currentNode = nil

    local stations = {
        { node = 179,  name = "Strawberry",      },
        { node = 271,  name = "Puerto Del Sol",  },
        { node = 388,  name = "LSIA Parking",    },
        { node = 434,  name = "LSIA Terminal 4", },
        { node = 530,  name = "LSIA Terminal 4", },
        { node = 578,  name = "LSIA Parking",    },
        { node = 689,  name = "Puerto Del Sol",  },
        { node = 782,  name = "Strawberry",      },
        { node = 1078, name = "Burton",          },
        { node = 1162, name = "Portola Drive",   },
        { node = 1233, name = "Del Perro",       },
        { node = 1331, name = "Little Seoul",    },
        { node = 1397, name = "Pillbox South",   },
        { node = 1522, name = "Davis",           },
        { node = 1649, name = "Davis",           },
        { node = 1791, name = "Pillbox South",   },
        { node = 1869, name = "Little Seoul",    },
        { node = 1977, name = "Del Perro",       },
        { node = 2066, name = "Portola Drive",   },
        { node = 2153, name = "Burton",          },
        { node = 2246, name = "Strawberry"       }
    }

    local StationTrain = {
        {StationName="Strawberry", Stationid=0, x=294.46011352539, y=-1203.5991210938, z=38.902496337891, h=90.168075561523},
        {StationName="Burton", Stationid=1, x=-294.76913452148, y=-303.44619750977, z=10.063159942627, h=185.19216918945},
        {StationName="Portola Drive", Stationid=2, x=-839.20843505859, y=-151.43312072754, z=19.950380325317, h=298.70877075195},
        {StationName="Del Perro", Stationid=3, x=-1337.9787597656, y=-488.36145019531, z=15.045375823975, h=28.487064361572},
        {StationName="Little Seoul", Stationid=4, x=-474.07037353516, y=-673.10729980469, z=11.809032440186, h=81.799621582031},
        {StationName="Pillbox South", Stationid=5, x=-222.13038635254, y=-1054.5043945313, z=30.139930725098, h=155.81954956055},
        {StationName="Davis", Stationid=6, x=133.13328552246, y=-1739.5617675781, z=30.109495162964, h=231.40335083008},
        {StationName="Puerto Del Sol", Stationid=7, x=-550.79998779297, y=-1302.4467773438, z=26.901605606079, h=155.53070068359},
        {StationName="LSIA Parking", Stationid=8, x=-891.87664794922, y=-2342.6486816406, z=-11.732737541199, h=353.59387207031},
        {StationName="LSIA Terminal 4", Stationid=9, x=-1099.6376953125, y=-2734.8957519531, z=-7.410129070282, h=314.91424560547}
    }

    local AllBlips = {}
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        for _, BlipInfo in pairs(StationTrain) do
            local blipMap = AddBlipForCoord(BlipInfo.x, BlipInfo.y, BlipInfo.z)

            SetBlipSprite(blipMap, 124)
            SetBlipDisplay(blipMap, 4)
            SetBlipScale(blipMap, 0.6)
            SetBlipColour(blipMap, 1)
            SetBlipAsShortRange(blipMap, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(BlipInfo.StationName)
            EndTextCommandSetBlipName(blipMap)
            SetBlipPriority(blipMap, 5)

            table.insert(AllBlips, blipMap)
        end
    end)

    AddEventHandler('onResourceStop', function(resourceName)
        if GetCurrentResourceName() ~= resourceName then return end
        for _, blip in pairs(AllBlips) do
            RemoveBlip(blip)
        end
    end)

    Citizen.CreateThread(function()
        SwitchTrainTrack(0, true)
        SwitchTrainTrack(3, true)
        SetTrainTrackSpawnFrequency(0, 120000)
        SetRandomTrains(1)

        AddTextEntry("NEXT_STATION_NOTIFICATION", "Vous êtes sur la ligne ~BLIP_536~ prochaine station ~g~~a~")
    end)

    CreateThread(function()
        while true do
            Wait(3000)

            local player = PlayerPedId()
            local coords = GetEntityCoords(player)

            -- add all known trains to table
            trains = GetTrams(coords)

            -- get closest train
            if #trains >= 1 then
                local train = trains[1][1]

                if train ~= nil then
                    currentNode = GetTrainCurrentTrackNode(train)
                else
                    currentNode = nil
                end
            end

            local wasInTram = inTram
            inTram = IsPedInAnyTrain(player)
            if not wasInTram and inTram then
                CreateThread(function()
                    while inTram and currentNode ~= nil do
                        Wait(0)

                        local nextst = "Unknown"

                        for _, station in ipairs(stations) do
                            -- check if train current node is before next station
                            if currentNode < station.node then
                                nextst = station.name

                                break
                            end
                        end

                        BeginTextCommandDisplayHelp("NEXT_STATION_NOTIFICATION")
                        AddTextComponentSubstringPlayerName(nextst)
                        EndTextCommandDisplayHelp(0, 0, 1, -1)
                    end
                end)
            end
        end
    end)

    function compareCoords(a, b) return a[2] < b[2] end

    function PowEnumerateVehicles()
        return ipairs(GetGamePool('CVehicle'))
    end

    function GetTrams(coords)
        local trams = {}

        for _, vehicle in PowEnumerateVehicles() do
            local distance = #(GetEntityCoords(vehicle) - coords)

            if distance <= 100 and GetEntityModel(vehicle) == `metrotrain` then
                table.insert(trams, {vehicle, distance, GetEntitySpeed(vehicle)})
            end
        end

        table.sort(trams, compareCoords)
        return trams
    end
end