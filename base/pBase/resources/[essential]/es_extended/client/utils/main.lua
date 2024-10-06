
Citizen.CreateThread(function()
    while true do
        players = {}
        for _,player in ipairs(GetActivePlayers()) do
            table.insert(players, player)
        end

        -- Rich Presence
        SetDiscordAppId()
        SetDiscordRichPresenceAsset('')
        SetDiscordRichPresenceAssetText('discord.gg/')
        SetDiscordRichPresenceAssetSmall('')
        SetDiscordRichPresenceAssetSmallText('pBase')
        SetDiscordRichPresenceAction(0, "🔐 Se Connecter", "https://discord.gg/")
        SetDiscordRichPresenceAction(1, "📲 Rejoindre le Discord", "https://discord.gg/")
        SetRichPresence(GetPlayerName(PlayerId()) .. " - ".. #players .. "/64")

        -- Menu Echap
        local name = GetPlayerName(PlayerId())
        local id = GetPlayerServerId(PlayerId())
        AddTextEntry('PM_SCR_MAP', '~b~Carte de Los Santos')
        AddTextEntry('PM_SCR_GAM', '~r~Prendre l\'avion')
        AddTextEntry('PM_SCR_INF', '~g~Logs')
        AddTextEntry('PM_SCR_SET', '~p~Configuration')
        AddTextEntry('PM_SCR_STA', '~b~Statistiques')
        AddTextEntry('PM_SCR_GAL', '~y~Galerie')
        AddTextEntry('PM_SCR_RPL', '~y~Éditeur ∑')
        AddTextEntry('PM_PANE_CFX', '~y~pBase')
        AddTextEntry('FE_THDR_GTAO', "~s~pBase ~u~| ~s~ID : " .. id .. " ~u~| ~s~Nom : " .. name .. " ~u~| ~s~Joueurs : " .. #players .. "/64")
        AddTextEntry('PM_PANE_LEAVE', '~s~Se déconnecter de pBase');
        AddTextEntry('PM_PANE_QUIT', '~r~Quitter FiveM');

        Citizen.Wait(1000)
    end
end)