### côté client

exports['G_notif']:Alert("title", "message", 4000, 'notif')

### côté server

TriggerClientEvent('G_notif:Alert', source, "title", "message", 4000, 'notif')

### TUTO

Pour changer une notification il suffit de regarder le script, s'il est côté client ou côté server.
Puis remplacer la ligne de notification déjà existante par celle qui convient ci-dessus.
Ensuite vous n'avez plus qu'à changer le "title" et le "message".
Si jamais vous souhaitez changer la notification de couleur vous devez changer 'notif' en :

'notif' = bleu
'notif2' = rouge
'notif3' = vert

À vous de choisir.

### Attention !

Il ne faut surtout pas changer le nom du script !

### Si vous voulez retirer les commands /notif, /notif2 et /notif3 pour x raison

Vous devez ajouter ceci  --[[  à la ligne 15 du client.lua et mettre ceci  ]]--  à la ligne 30 du client.lua et voilà ;)
