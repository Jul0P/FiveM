-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 27 oct. 2023 à 04:07
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `pbase`
--

-- --------------------------------------------------------

--
-- Structure de la table `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `billing`
--

CREATE TABLE `billing` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `sender` varchar(60) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(60) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `datastore`
--

CREATE TABLE `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_app_chat`
--

CREATE TABLE `gksphone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_bank_transfer`
--

CREATE TABLE `gksphone_bank_transfer` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `identifier` longtext DEFAULT NULL,
  `price` longtext NOT NULL,
  `name` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_blockednumber`
--

CREATE TABLE `gksphone_blockednumber` (
  `id` int(11) NOT NULL,
  `identifier` longtext NOT NULL,
  `hex` longtext NOT NULL,
  `number` longtext NOT NULL,
  `numberto` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_calls`
--

CREATE TABLE `gksphone_calls` (
  `id` int(11) NOT NULL,
  `owner` longtext NOT NULL COMMENT 'Num tel proprio',
  `num` longtext NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_gallery`
--

CREATE TABLE `gksphone_gallery` (
  `id` int(11) NOT NULL,
  `hex` longtext NOT NULL,
  `image` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_gotur`
--

CREATE TABLE `gksphone_gotur` (
  `id` int(11) NOT NULL,
  `label` longtext NOT NULL,
  `price` int(11) DEFAULT 0,
  `count` int(11) NOT NULL,
  `item` longtext NOT NULL,
  `kapat` varchar(50) DEFAULT 'false',
  `adet` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_gps`
--

CREATE TABLE `gksphone_gps` (
  `id` int(11) NOT NULL,
  `hex` longtext NOT NULL,
  `nott` longtext DEFAULT NULL,
  `gps` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_group_message`
--

CREATE TABLE `gksphone_group_message` (
  `id` int(11) NOT NULL,
  `groupid` int(11) NOT NULL,
  `owner` longtext NOT NULL,
  `ownerphone` varchar(50) NOT NULL,
  `groupname` varchar(255) NOT NULL,
  `messages` longtext NOT NULL,
  `contacts` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_insto_accounts`
--

CREATE TABLE `gksphone_insto_accounts` (
  `id` int(11) NOT NULL,
  `forename` longtext NOT NULL,
  `surname` longtext NOT NULL,
  `username` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` longtext NOT NULL,
  `avatar_url` longtext DEFAULT NULL,
  `takip` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_insto_instas`
--

CREATE TABLE `gksphone_insto_instas` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` longtext DEFAULT NULL,
  `message` longtext NOT NULL,
  `image` longtext NOT NULL,
  `filters` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_insto_likes`
--

CREATE TABLE `gksphone_insto_likes` (
  `id` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `inapId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_insto_story`
--

CREATE TABLE `gksphone_insto_story` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` longtext DEFAULT NULL,
  `stories` longtext NOT NULL,
  `isRead` varchar(256) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_job_message`
--

CREATE TABLE `gksphone_job_message` (
  `id` int(11) NOT NULL,
  `name` longtext NOT NULL,
  `number` varchar(50) NOT NULL,
  `message` longtext NOT NULL,
  `photo` longtext DEFAULT NULL,
  `gps` varchar(255) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT 0,
  `jobm` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_mails`
--

CREATE TABLE `gksphone_mails` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL DEFAULT '0',
  `sender` varchar(255) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '0',
  `image` text NOT NULL,
  `message` text NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_messages`
--

CREATE TABLE `gksphone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(50) NOT NULL,
  `receiver` varchar(50) NOT NULL,
  `message` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_messages_group`
--

CREATE TABLE `gksphone_messages_group` (
  `id` int(11) NOT NULL,
  `owner` longtext NOT NULL,
  `ownerphone` varchar(50) NOT NULL,
  `groupname` varchar(255) NOT NULL,
  `gimage` longtext NOT NULL,
  `contacts` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_news`
--

CREATE TABLE `gksphone_news` (
  `id` int(11) NOT NULL,
  `hex` longtext DEFAULT NULL,
  `haber` longtext DEFAULT NULL,
  `baslik` longtext DEFAULT NULL,
  `resim` longtext DEFAULT NULL,
  `video` longtext DEFAULT NULL,
  `zaman` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_settings`
--

CREATE TABLE `gksphone_settings` (
  `id` int(11) NOT NULL,
  `identifier` longtext NOT NULL,
  `crypto` longtext NOT NULL DEFAULT '{}',
  `phone_number` varchar(50) DEFAULT NULL,
  `avatar_url` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_tinderacc`
--

CREATE TABLE `gksphone_tinderacc` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `passaword` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_tindermatch`
--

CREATE TABLE `gksphone_tindermatch` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `friend_id` int(11) NOT NULL DEFAULT 0,
  `is_match` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_tindermessage`
--

CREATE TABLE `gksphone_tindermessage` (
  `id` int(11) NOT NULL,
  `message` text NOT NULL,
  `tinderes` text NOT NULL,
  `owner` int(11) NOT NULL DEFAULT 0,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_twitter_accounts`
--

CREATE TABLE `gksphone_twitter_accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `password` varchar(64) NOT NULL DEFAULT '0',
  `avatar_url` longtext DEFAULT NULL,
  `profilavatar` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_twitter_likes`
--

CREATE TABLE `gksphone_twitter_likes` (
  `id` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_twitter_tweets`
--

CREATE TABLE `gksphone_twitter_tweets` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) DEFAULT NULL,
  `message` varchar(256) NOT NULL,
  `image` longtext DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_users_contacts`
--

CREATE TABLE `gksphone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `display` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '-1',
  `avatar` longtext NOT NULL DEFAULT 'https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png',
  `numberto` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_vehicle_sales`
--

CREATE TABLE `gksphone_vehicle_sales` (
  `id` int(11) NOT NULL,
  `owner` longtext NOT NULL,
  `ownerphone` varchar(255) NOT NULL,
  `plate` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `image` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gksphone_yellow`
--

CREATE TABLE `gksphone_yellow` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `firstname` varchar(256) DEFAULT NULL,
  `lastname` varchar(256) DEFAULT NULL,
  `message` longtext NOT NULL,
  `image` longtext DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('12_ammo', 'Munitions Calibre 12', 0, 0, 1),
('45acp_ammo', '45acp', 0, 0, 1),
('762mm_ammo', '7.62mm', 0, 0, 1),
('9mm_ammo', '9mm', 0, 0, 1),
('biere', 'Bière', 1, 0, 1),
('eau', 'Eau', 1, 0, 1),
('pain', 'Pain', 1, 0, 1),
('phone', 'Téléphone', 1, 0, 1),
('WEAPON_ADVANCEDRIFLE', 'Fusil avancé', 5, 0, 1),
('WEAPON_APPISTOL', 'Pistolet Perforant', 3, 0, 1),
('WEAPON_ASSAULTRIFLE', 'AK-47 MK2', 5, 0, 1),
('WEAPON_ASSAULTSHOTGUN', 'UTAS UTS-15', 5, 0, 1),
('WEAPON_ASSAULTSMG', 'SMG', 5, 0, 1),
('WEAPON_AUTOSHOTGUN', 'AA-12', 5, 0, 1),
('WEAPON_BALL', 'Ball', 1, 0, 1),
('WEAPON_BAT', 'Batte de Baseball', 1, 0, 1),
('WEAPON_BATTLEAXE', 'Hache de combat', 1, 0, 1),
('WEAPON_BOTTLE', 'Bouteille cassé', 1, 0, 1),
('WEAPON_BRIEFCASE', 'Malette', 1, 0, 1),
('WEAPON_BRIEFCASE_02', 'Malette', 1, 0, 1),
('WEAPON_BULLPUPRIFLE', 'Fusil Bullpup MK2', 5, 0, 1),
('WEAPON_BULLPUPSHOTGUN', 'Kel-Tec KSG', 5, 0, 1),
('WEAPON_BZGAS', 'BZ Gas', 1, 0, 1),
('WEAPON_CARBINERIFLE', 'Carabine', 5, 0, 1),
('WEAPON_CERAMICPISTOL', 'Ceramic Pistol', 1, 0, 1),
('WEAPON_COMBATMG', 'Mitrailleuse de Combat', 7, 0, 1),
('WEAPON_COMBATPDW', 'Combat PDW', 5, 0, 1),
('WEAPON_COMBATPISTOL', 'Glock', 2, 0, 1),
('WEAPON_COMBATSHOTGUN', 'SPAS 12', 5, 0, 1),
('WEAPON_COMPACTLAUNCHER', 'Compact Launcher', 5, 0, 1),
('WEAPON_COMPACTRIFLE', 'Fusil compact\r\n', 5, 0, 1),
('WEAPON_CROWBAR', 'Pied de biche', 1, 0, 1),
('WEAPON_DAGGER', 'Dague', 1, 0, 1),
('WEAPON_DBSHOTGUN', 'Fusil a double Canon', 5, 0, 1),
('WEAPON_DIGISCANNER', 'Digiscanner', 1, 0, 1),
('WEAPON_DOUBLEACTION', 'Double-Action Revolver', 3, 0, 1),
('WEAPON_FIREEXTINGUISHER', 'Extincteur', 3, 0, 1),
('WEAPON_FIREWORK', 'Firework Launcher', 5, 0, 1),
('WEAPON_FLARE', 'Fumigène', 1, 0, 1),
('WEAPON_FLAREGUN', 'Pistolet Fumigène', 1, 0, 1),
('WEAPON_FLASHLIGHT', 'Lampe torche', 1, 0, 1),
('WEAPON_GADGETPISTOL', ' Perico Pistol', 1, 0, 1),
('WEAPON_GARBAGEBAG', 'Garbage Bag', 1, 0, 1),
('WEAPON_GOLFCLUB', 'Club de Golf', 1, 0, 1),
('WEAPON_GRENADE', 'Grenade', 1, 0, 1),
('WEAPON_GRENADELAUNCHER', 'Gernade Launcher', 5, 0, 1),
('WEAPON_GUSENBERG', 'Mitrailleuse Gusenberg', 7, 0, 1),
('WEAPON_HAMMER', 'Marteau', 1, 0, 1),
('WEAPON_HANDCUFFS', 'Handcuffs', 1, 0, 1),
('WEAPON_HATCHET', 'Hachette', 1, 0, 1),
('WEAPON_HEAVYPISTOL', 'Pistolet Lourd', 2, 0, 1),
('WEAPON_HEAVYRIFLE', 'Assault rifle', 1, 0, 1),
('WEAPON_HEAVYSHOTGUN', 'Saiga-12K', 5, 0, 1),
('WEAPON_HEAVYSNIPER', 'Heavy Sniper', 10, 0, 1),
('WEAPON_HOMINGLAUNCHER', 'Homing Launcher', 10, 0, 1),
('WEAPON_KNIFE', 'Couteau', 1, 0, 1),
('WEAPON_KNUCKLE', 'Poing américain', 1, 0, 1),
('WEAPON_MACHETE', 'Machete', 1, 0, 1),
('WEAPON_MACHINEPISTOL', 'TEC-9', 3, 0, 1),
('WEAPON_MARKSMANPISTOL', 'Pistolet Marksman', 3, 0, 1),
('WEAPON_MARKSMANRIFLE', 'M39 EMR', 10, 0, 1),
('WEAPON_MG', 'Mitrailleuse', 7, 0, 1),
('WEAPON_MICROSMG', 'Micro SMG', 5, 0, 1),
('WEAPON_MILITARYRIFLE', 'Assault rifle', 5, 0, 1),
('WEAPON_MINIGUN', 'Minigun', 15, 0, 1),
('WEAPON_MINISMG', 'Skorpion Vz. 61', 3, 0, 1),
('WEAPON_MOLOTOV', 'Cocktail Molotov', 1, 0, 1),
('WEAPON_MUSKET', 'Musket', 10, 0, 1),
('WEAPON_NAVYREVOLVER', 'Navy Revolver', 1, 0, 1),
('WEAPON_NIGHTSTICK', 'Matraque', 1, 0, 1),
('WEAPON_PELLE', 'Pelle', 1, 0, 1),
('WEAPON_PETROLCAN', 'Jerycan', 5, 0, 1),
('WEAPON_PIPEBOMB', 'Pipe Bomb', 1, 0, 1),
('WEAPON_PISTOL', 'Beretta', 2, 0, 1),
('WEAPON_PISTOL50', 'Pistolet Calibre 50', 3, 0, 1),
('WEAPON_POOLCUE', 'Queue de billard', 1, 0, 1),
('WEAPON_PROXMINE', 'Proximity Mine', 1, 0, 1),
('WEAPON_PUMPSHOTGUN', 'Fusil à pompe', 5, 0, 1),
('WEAPON_RAILGUN', 'Rail Gun', 7, 0, 1),
('WEAPON_REVOLVER', 'Revolver', 3, 0, 1),
('WEAPON_RPG', 'RPG', 15, 0, 1),
('WEAPON_SAWNOFFSHOTGUN', 'Mossberg 500', 5, 0, 1),
('WEAPON_SMG', 'SMG', 5, 0, 1),
('WEAPON_SMOKEGRENADE', 'Grenade lacrymogène', 1, 0, 1),
('WEAPON_SNIPERRIFLE', 'Sniper Rifle', 10, 0, 1),
('WEAPON_SNOWBALL', 'Boule de neige', 1, 0, 1),
('WEAPON_SNSPISTOL', 'Pétoire', 2, 0, 1),
('WEAPON_SPECIALCARBINE', 'H&K G36C', 5, 0, 1),
('WEAPON_STICKYBOMB', 'Sticky Bombs', 1, 0, 1),
('WEAPON_STINGER', 'Stinger', 5, 0, 1),
('WEAPON_STUNGUN', 'X26 Taser', 2, 0, 1),
('WEAPON_SWITCHBLADE', 'Couteau à cran arrêt', 1, 0, 1),
('WEAPON_VINTAGEPISTOL', 'Pistolet Vintage', 2, 0, 1),
('WEAPON_WRENCH', 'Clés a molette', 2, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`) VALUES
('unemployed', 'Unemployed'),
('unemployed2', 'Unemployed 2');

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Unemployed', 200, '{}', '{}'),
(2, 'unemployed2', 0, 'unemployed2', 'Unemployed 2', 200, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('dmv', 'Code de la route'),
('drive', 'Permis de conduire'),
('drive_bike', 'Permis moto'),
('drive_truck', 'Permis camion'),
('weapon', 'PPA');

-- --------------------------------------------------------

--
-- Structure de la table `multicharacter_slots`
--

CREATE TABLE `multicharacter_slots` (
  `identifier` varchar(46) NOT NULL,
  `slots` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ox_doorlock`
--

CREATE TABLE `ox_doorlock` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ox_doorlock`
--

INSERT INTO `ox_doorlock` (`id`, `name`, `data`) VALUES
(3, 'police', '{\"autolock\":2,\"doorRate\":2,\"coords\":{\"x\":434.74786376953127,\"y\":-981.916748046875,\"z\":30.83926391601562},\"doors\":[{\"coords\":{\"x\":434.74786376953127,\"y\":-983.215087890625,\"z\":30.83926391601562},\"heading\":270,\"model\":320433149},{\"coords\":{\"x\":434.74786376953127,\"y\":-980.618408203125,\"z\":30.83926391601562},\"heading\":270,\"model\":-1215222675}],\"auto\":true,\"groups\":{\"unemployed\":0},\"state\":1,\"maxDistance\":2}');

-- --------------------------------------------------------

--
-- Structure de la table `pascenseurbuilder`
--

CREATE TABLE `pascenseurbuilder` (
  `id` int(11) NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `teleport_data` longtext DEFAULT NULL,
  `job_data` longtext DEFAULT NULL,
  `user_data` longtext DEFAULT NULL,
  `blips_data` longtext DEFAULT NULL,
  `markers_data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `pascenseurbuilder`
--

INSERT INTO `pascenseurbuilder` (`id`, `label`, `teleport_data`, `job_data`, `user_data`, `blips_data`, `markers_data`) VALUES
(1, 'ems', '[{\"label\":\"1\",\"coords\":{\"y\":-530.5380859375,\"x\":564.0006713867188,\"w\":344.8427429199219,\"z\":35.89483642578125}},{\"label\":\"2\",\"coords\":{\"y\":-524.5611572265625,\"x\":566.2867431640625,\"w\":158.321533203125,\"z\":35.99055862426758}},{\"label\":\"3\",\"coords\":{\"y\":-520.46728515625,\"x\":567.5347900390625,\"w\":68.64507293701172,\"z\":35.99352264404297}}]', '[{\"label\":\"Unemployed 2\",\"name\":\"unemployed2\"}]', '[]', '{\"color\":4,\"sprite\":7,\"scale\":1.3,\"name\":\"dasda\"}', '{\"colorV\":0,\"colorO\":200,\"rotZ\":0.0,\"colorB\":0,\"rotX\":-90.0,\"colorR\":255,\"scaleX\":0.5,\"types\":6,\"scaleY\":0.5,\"scaleZ\":0.5,\"rotY\":0.0}');

-- --------------------------------------------------------

--
-- Structure de la table `pemote`
--

CREATE TABLE `pemote` (
  `id` int(11) NOT NULL,
  `licence` varchar(80) NOT NULL,
  `name` text NOT NULL,
  `originalname` text NOT NULL,
  `data` longtext NOT NULL,
  `type` text NOT NULL,
  `keybind` text DEFAULT NULL,
  `favorite` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `pemote`
--

INSERT INTO `pemote` (`id`, `licence`, `name`, `originalname`, `data`, `type`, `keybind`, `favorite`) VALUES
(67, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Tape-là', 'Tape-là', '{\"Requester\":{\"Type\":\"animation\",\"Dict\":\"mp_ped_interaction\",\"Flags\":0,\"Anim\":\"highfive_guy_a\"},\"RequesterLabel\":\"do a high five with\",\"Accepter\":{\"Attach\":{\"zR\":180.0,\"xP\":-0.5,\"Bone\":9816,\"yR\":0.3,\"xR\":0.9,\"yP\":1.25,\"zP\":0.0},\"Anim\":\"highfive_guy_b\",\"Dict\":\"mp_ped_interaction\",\"Flags\":0,\"Type\":\"animation\"},\"Label\":\"Tape-là\"}', 'Emote Partagées', NULL, '1'),
(68, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Backpack', 'Backpack', '{\"1\":\"move_p_m_zero_rucksack\",\"2\":\"nill\",\"3\":\"Backpack\",\"4\":\"Props\",\"AnimationOptions\":{\"Prop\":\"p_michael_backpack_s\",\"EmoteDuration\":-1,\"PropBone\":24818,\"PropPlacement\":[0.07,-0.11,-0.05,0.0,90.0,175.0],\"EmoteMoving\":true,\"EmoteLoop\":true}}', 'Emote', NULL, '1'),
(69, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Assis', 'Assis', '{\"1\":\"anim@amb@business@bgen@bgen_no_work@\",\"2\":\"sit_phone_phoneputdown_idle_nowork\",\"3\":\"Assis\",\"4\":\"Position\",\"AnimationOptions\":{\"EmoteDuration\":-1,\"EmoteLoop\":true}}', 'Emote', NULL, '1'),
(70, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Assis 9', 'Assis 9', '{\"1\":\"amb@world_human_stupor@male@idle_a\",\"2\":\"idle_a\",\"3\":\"Assis 9\",\"4\":\"Position\",\"AnimationOptions\":{\"EmoteLoop\":true}}', 'Emote', NULL, '1'),
(71, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Assis peur 3', 'Assis peur 3', '{\"1\":\"anim@heists@ornate_bank@hostages@ped_e@\",\"2\":\"flinch_loop\",\"3\":\"Assis peur 3\",\"4\":\"Position\",\"AnimationOptions\":{\"EmoteLoop\":true}}', 'Emote', NULL, '1'),
(72, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Assis sur une chaise (Femme)', 'Assis sur une chaise (Femme)', '{\"1\":\"timetable@reunited@ig_10\",\"2\":\"base_amanda\",\"3\":\"Assis sur une chaise (Femme)\",\"4\":\"Position\",\"AnimationOptions\":{\"EmoteLoop\":true}}', 'Emote', NULL, '1'),
(73, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Attendre', 'Attendre', '{\"1\":\"anim@heists@heist_corona@team_idles@female_a\",\"2\":\"idle\",\"3\":\"Attendre\",\"4\":\"Position\",\"AnimationOptions\":{\"EmoteLoop\":true}}', 'Emote', NULL, '1'),
(74, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Attendre (femme)', 'Attendre (femme)', '{\"1\":\"friends@fra@ig_1\",\"2\":\"base_idle\",\"3\":\"Attendre (femme)\",\"4\":\"Position\",\"AnimationOptions\":{\"EmoteLoop\":true}}', 'Emote', NULL, '1'),
(75, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Attendre 11', 'Attendre 11', '{\"1\":\"random@countrysiderobbery\",\"2\":\"idle_a\",\"3\":\"Attendre 11\",\"4\":\"Position\",\"AnimationOptions\":{\"EmoteLoop\":true}}', 'Emote', NULL, '1'),
(76, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Attendre 5', 'Attendre 5', '{\"1\":\"anim@mp_corona_idles@female_b@idle_a\",\"2\":\"idle_a\",\"3\":\"Attendre 5\",\"4\":\"Position\",\"AnimationOptions\":{\"EmoteLoop\":true}}', 'Emote', 'NUMPAD2', '1'),
(77, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Attendre (petite dance)', 'Attendre (petite dance)', '{\"1\":\"anim@heists@humane_labs@finale@strip_club\",\"2\":\"ped_b_celebrate_loop\",\"3\":\"Attendre (petite dance)\",\"4\":\"Position\",\"AnimationOptions\":{\"EmoteLoop\":true}}', 'Emote', 'NUMPAD1', NULL),
(78, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Beer', 'Beer', '{\"1\":\"amb@world_human_drinking@beer@male@idle_a\",\"2\":\"idle_c\",\"3\":\"Beer\",\"4\":\"Props\",\"AnimationOptions\":{\"Prop\":\"prop_amb_beer_bottle\",\"EmoteDuration\":-1,\"PropBone\":28422,\"PropPlacement\":[0.0,0.0,0.06,0.0,15.0,0.0],\"EmoteMoving\":true,\"EmoteLoop\":true}}', 'Emote', 'NUMPAD3', NULL),
(79, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Happy', 'Happy', '[\"Expression\",\"mood_happy_1\",\"Happy\",\"Expression\"]', 'Emote', 'NUMPAD4', NULL),
(80, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Grumpy', 'Grumpy', '[\"Expression\",\"effort_1\",\"Grumpy\",\"Expression\"]', 'Emote', 'NUMPAD5', NULL),
(81, 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'DJ 6', 'DJ 6', '{\"1\":\"anim@amb@nightclub@djs@dixon@\",\"2\":\"dixn_idle_cntr_b_dix\",\"3\":\"DJ 6\",\"4\":\"Dance\",\"AnimationOptions\":{\"EmoteMoving\":false,\"EmoteLoop\":true}}', 'Emote', 'NUMPAD6', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `society_moneywash`
--

CREATE TABLE `society_moneywash` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `trunk_inventory`
--

CREATE TABLE `trunk_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(46) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `job2` varchar(20) DEFAULT 'unemployed2',
  `job2_grade` int(11) DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `position` longtext DEFAULT NULL,
  `firstname` varchar(16) DEFAULT NULL,
  `lastname` varchar(16) DEFAULT NULL,
  `dateofbirth` varchar(10) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT 0,
  `skin` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `tattoos` longtext DEFAULT NULL,
  `pcoin` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`identifier`, `accounts`, `group`, `inventory`, `job`, `job_grade`, `job2`, `job2_grade`, `loadout`, `metadata`, `position`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `disabled`, `skin`, `status`, `tattoos`, `pcoin`) VALUES
('e9c44aea10b49565df2dfc060ab34febe7508fa7', '{\"money\":9307,\"bank\":85200,\"black_money\":0}', 'admin', '[]', 'unemployed', 0, 'unemployed2', 0, '[]', '[]', '{\"y\":-1351.4637451171876,\"x\":46.15385055541992,\"z\":29.2799072265625}', 'Jason', 'Smith', '10/10/1995', 'm', 180, 0, '{\"torso_2\":0,\"sun_1\":0,\"makeup_3\":0,\"lipstick_2\":0,\"ears_1\":-1,\"eyebrows_2\":7.7,\"eye_squint\":0,\"glasses_1\":0,\"face\":0,\"hair_1\":10,\"lipstick_1\":0,\"lip_thickness\":0,\"chain_2\":0,\"decals_2\":0,\"nose_6\":0,\"nose_5\":0,\"arms_2\":0,\"blemishes_2\":0,\"beard_2\":10.0,\"cheeks_1\":0,\"eyebrows_5\":0.0,\"makeup_4\":0,\"blush_2\":0,\"blemishes_1\":0,\"decals_1\":0,\"complexion_2\":0,\"age_1\":0,\"watches_2\":0,\"makeup_2\":0,\"moles_2\":0,\"nose_1\":2.1,\"hair_color_1\":0,\"mask_1\":0,\"mask_2\":0,\"glasses_2\":0,\"complexion_1\":0,\"bproof_2\":0,\"bproof_1\":0,\"pants_1\":14,\"cheeks_3\":0,\"tshirt_2\":0,\"beard_3\":0,\"blush_3\":0,\"neck_thickness\":0,\"chest_1\":0,\"helmet_1\":-1,\"beard_1\":5,\"chain_1\":0,\"chin_1\":0,\"eyebrows_3\":0,\"blush_1\":0,\"watches_1\":-1,\"moles_1\":0,\"chin_4\":0,\"tshirt_1\":15,\"lipstick_3\":0,\"hair_color_2\":43,\"age_2\":0,\"torso_1\":15,\"makeup_1\":0,\"skin\":4,\"cheeks_2\":0,\"bodyb_4\":0,\"sex\":0,\"helmet_2\":0,\"shoes_1\":34,\"jaw_1\":0,\"sun_2\":0,\"shoes_2\":0,\"bags_2\":0,\"pants_2\":1,\"lipstick_4\":0,\"chin_3\":0,\"chin_2\":0,\"hair_2\":0,\"jaw_2\":0,\"nose_2\":8.1,\"eye_color\":0,\"chest_3\":0,\"nose_4\":0,\"bodyb_2\":0,\"bodyb_1\":-1,\"beard_4\":0,\"bracelets_2\":0,\"ears_2\":0,\"eyebrows_4\":1,\"nose_3\":0,\"eyebrows_1\":0,\"bags_1\":0,\"bracelets_1\":-1,\"eyebrows_6\":4.69999999999999,\"chest_2\":0,\"arms\":15,\"bodyb_3\":-1}', '[{\"val\":494400,\"name\":\"hunger\",\"percent\":49.44},{\"val\":991975,\"name\":\"thirst\",\"percent\":99.1975},{\"val\":0,\"name\":\"drunk\",\"percent\":0.0}]', '[]', '500');

-- --------------------------------------------------------

--
-- Structure de la table `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `owner` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_licenses`
--

INSERT INTO `user_licenses` (`id`, `type`, `owner`) VALUES
(1, 'weapon', 'e9c44aea10b49565df2dfc060ab34febe7508fa7');

-- --------------------------------------------------------

--
-- Structure de la table `vetement`
--

CREATE TABLE `vetement` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `identifier` varchar(40) DEFAULT NULL,
  `nom` longtext DEFAULT NULL,
  `clothe` longtext DEFAULT NULL,
  `vie` int(11) NOT NULL DEFAULT 100,
  `onPickup` tinyint(1) NOT NULL DEFAULT 0,
  `vehchest` varchar(255) DEFAULT NULL,
  `propchest` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vetement`
--

INSERT INTO `vetement` (`id`, `type`, `identifier`, `nom`, `clothe`, `vie`, `onPickup`, `vehchest`, `propchest`) VALUES
(6, 'pantalon', 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Pantalon ', '{\"pants_1\":1,\"pants_2\":3}', 100, 0, NULL, NULL),
(7, 'lunettes', 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Lunettes ', '{\"glasses_2\":0,\"glasses_1\":5}', 100, 0, NULL, NULL),
(8, 'chaussures', 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Chaussures ', '{\"shoes_1\":7,\"shoes_2\":0}', 100, 0, NULL, NULL),
(9, 'haut', 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Haut 3', '{\"arms_2\":0,\"tshirt_1\":0,\"arms\":15,\"torso_1\":3,\"torso_2\":2,\"tshirt_2\":0}', 100, 0, NULL, NULL),
(10, 'masque', 'e9c44aea10b49565df2dfc060ab34febe7508fa7', 'Masque 214', '{\"mask_2\":1,\"mask_1\":214}', 100, 0, NULL, NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  ADD KEY `index_addon_account_data_account_name` (`account_name`);

--
-- Index pour la table `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  ADD KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  ADD KEY `index_addon_inventory_inventory_name` (`inventory_name`);

--
-- Index pour la table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  ADD KEY `index_datastore_data_name` (`name`);

--
-- Index pour la table `gksphone_app_chat`
--
ALTER TABLE `gksphone_app_chat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `gksphone_bank_transfer`
--
ALTER TABLE `gksphone_bank_transfer`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_blockednumber`
--
ALTER TABLE `gksphone_blockednumber`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_calls`
--
ALTER TABLE `gksphone_calls`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `gksphone_gallery`
--
ALTER TABLE `gksphone_gallery`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_gotur`
--
ALTER TABLE `gksphone_gotur`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_gps`
--
ALTER TABLE `gksphone_gps`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_group_message`
--
ALTER TABLE `gksphone_group_message`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `groupid` (`groupid`) USING BTREE;

--
-- Index pour la table `gksphone_insto_accounts`
--
ALTER TABLE `gksphone_insto_accounts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`) USING BTREE;

--
-- Index pour la table `gksphone_insto_instas`
--
ALTER TABLE `gksphone_insto_instas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gksphone_insto_instas_gksphone_insto_accounts` (`authorId`);

--
-- Index pour la table `gksphone_insto_likes`
--
ALTER TABLE `gksphone_insto_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gksphone_insto_likes_gksphone_insto_accounts` (`authorId`),
  ADD KEY `FK_gksphone_insto_likes_gksphone_insto_instas` (`inapId`);

--
-- Index pour la table `gksphone_insto_story`
--
ALTER TABLE `gksphone_insto_story`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `FK_gksphone_insto_story_gksphone_insto_accounts` (`authorId`) USING BTREE;

--
-- Index pour la table `gksphone_job_message`
--
ALTER TABLE `gksphone_job_message`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_mails`
--
ALTER TABLE `gksphone_mails`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_messages`
--
ALTER TABLE `gksphone_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `gksphone_messages_group`
--
ALTER TABLE `gksphone_messages_group`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_news`
--
ALTER TABLE `gksphone_news`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_settings`
--
ALTER TABLE `gksphone_settings`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_tinderacc`
--
ALTER TABLE `gksphone_tinderacc`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_tindermatch`
--
ALTER TABLE `gksphone_tindermatch`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_tindermessage`
--
ALTER TABLE `gksphone_tindermessage`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_twitter_accounts`
--
ALTER TABLE `gksphone_twitter_accounts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`) USING BTREE;

--
-- Index pour la table `gksphone_twitter_likes`
--
ALTER TABLE `gksphone_twitter_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gksphone_twitter_likes_gksphone_twitter_accounts` (`authorId`),
  ADD KEY `FK_gksphone_twitter_likes_gksphone_twitter_tweets` (`tweetId`);

--
-- Index pour la table `gksphone_twitter_tweets`
--
ALTER TABLE `gksphone_twitter_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gksphone_twitter_tweets_gksphone_twitter_accounts` (`authorId`);

--
-- Index pour la table `gksphone_users_contacts`
--
ALTER TABLE `gksphone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `gksphone_vehicle_sales`
--
ALTER TABLE `gksphone_vehicle_sales`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `gksphone_yellow`
--
ALTER TABLE `gksphone_yellow`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`type`);

--
-- Index pour la table `multicharacter_slots`
--
ALTER TABLE `multicharacter_slots`
  ADD PRIMARY KEY (`identifier`) USING BTREE,
  ADD KEY `slots` (`slots`) USING BTREE;

--
-- Index pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `ox_doorlock`
--
ALTER TABLE `ox_doorlock`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pascenseurbuilder`
--
ALTER TABLE `pascenseurbuilder`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pemote`
--
ALTER TABLE `pemote`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `society_moneywash`
--
ALTER TABLE `society_moneywash`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate` (`plate`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `vetement`
--
ALTER TABLE `vetement`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `billing`
--
ALTER TABLE `billing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_app_chat`
--
ALTER TABLE `gksphone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_bank_transfer`
--
ALTER TABLE `gksphone_bank_transfer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_blockednumber`
--
ALTER TABLE `gksphone_blockednumber`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_calls`
--
ALTER TABLE `gksphone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_gallery`
--
ALTER TABLE `gksphone_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_gotur`
--
ALTER TABLE `gksphone_gotur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_gps`
--
ALTER TABLE `gksphone_gps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_group_message`
--
ALTER TABLE `gksphone_group_message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_insto_accounts`
--
ALTER TABLE `gksphone_insto_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_insto_instas`
--
ALTER TABLE `gksphone_insto_instas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_insto_likes`
--
ALTER TABLE `gksphone_insto_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_insto_story`
--
ALTER TABLE `gksphone_insto_story`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_job_message`
--
ALTER TABLE `gksphone_job_message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_mails`
--
ALTER TABLE `gksphone_mails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_messages`
--
ALTER TABLE `gksphone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_messages_group`
--
ALTER TABLE `gksphone_messages_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_news`
--
ALTER TABLE `gksphone_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_settings`
--
ALTER TABLE `gksphone_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_tinderacc`
--
ALTER TABLE `gksphone_tinderacc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_tindermatch`
--
ALTER TABLE `gksphone_tindermatch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_tindermessage`
--
ALTER TABLE `gksphone_tindermessage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_twitter_accounts`
--
ALTER TABLE `gksphone_twitter_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_twitter_likes`
--
ALTER TABLE `gksphone_twitter_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_twitter_tweets`
--
ALTER TABLE `gksphone_twitter_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_users_contacts`
--
ALTER TABLE `gksphone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_vehicle_sales`
--
ALTER TABLE `gksphone_vehicle_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gksphone_yellow`
--
ALTER TABLE `gksphone_yellow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `ox_doorlock`
--
ALTER TABLE `ox_doorlock`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `pascenseurbuilder`
--
ALTER TABLE `pascenseurbuilder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `pemote`
--
ALTER TABLE `pemote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT pour la table `society_moneywash`
--
ALTER TABLE `society_moneywash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `vetement`
--
ALTER TABLE `vetement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `gksphone_group_message`
--
ALTER TABLE `gksphone_group_message`
  ADD CONSTRAINT `FK_phonegroupmessage` FOREIGN KEY (`groupid`) REFERENCES `gksphone_messages_group` (`id`);

--
-- Contraintes pour la table `gksphone_insto_instas`
--
ALTER TABLE `gksphone_insto_instas`
  ADD CONSTRAINT `FK_gksphone_insto_instas_gksphone_insto_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_insto_accounts` (`id`);

--
-- Contraintes pour la table `gksphone_insto_likes`
--
ALTER TABLE `gksphone_insto_likes`
  ADD CONSTRAINT `FK_gksphone_insto_likes_gksphone_insto_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_insto_accounts` (`id`),
  ADD CONSTRAINT `FK_gksphone_insto_likes_gksphone_insto_instas` FOREIGN KEY (`inapId`) REFERENCES `gksphone_insto_instas` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `gksphone_insto_story`
--
ALTER TABLE `gksphone_insto_story`
  ADD CONSTRAINT `FK_gksphone_insto_story_gksphone_insto_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_insto_accounts` (`id`);

--
-- Contraintes pour la table `gksphone_twitter_likes`
--
ALTER TABLE `gksphone_twitter_likes`
  ADD CONSTRAINT `FK_gksphone_twitter_likes_gksphone_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_twitter_accounts` (`id`),
  ADD CONSTRAINT `FK_gksphone_twitter_likes_gksphone_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `gksphone_twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `gksphone_twitter_tweets`
--
ALTER TABLE `gksphone_twitter_tweets`
  ADD CONSTRAINT `FK_gksphone_twitter_tweets_gksphone_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_twitter_accounts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
