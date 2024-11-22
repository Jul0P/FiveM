# à mettre dans le es_extended\server\common.lua (tous en bas sauter 2 lignes)


# si vous N'ÊTES PAS sur la derrière version d'es_extended :

RegisterNetEvent('esx:refreshJobs')
AddEventHandler('esx:refreshJobs', function()
    MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
        for k,v in ipairs(jobs) do
            ESX.Jobs[v.name] = v
            ESX.Jobs[v.name].grades = {}
        end

        MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
            for k,v in ipairs(jobGrades) do
                if ESX.Jobs[v.job_name] then
                    ESX.Jobs[v.job_name].grades[tostring(v.grade)] = v
                else
                    print(('[es_extended] [^3WARNING^7] Ignoring job grades for "%s" due to missing job'):format(v.job_name))
                end
            end

            for k2,v2 in pairs(ESX.Jobs) do
                if ESX.Table.SizeOf(v2.grades) == 0 then
                    ESX.Jobs[v2.name] = nil
                    print(('[es_extended] [^3WARNING^7] Ignoring job "%s" due to no job grades found'):format(v2.name))
                end
            end
        end)
    end)
end)


# si vous ÊTES sur la derrière version d'es_extended :

RegisterNetEvent('esx:refreshJobs')
AddEventHandler('esx:refreshJobs', function()
    ESX.RefreshJobs()
end)