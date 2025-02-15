CREATE TABLE `owned_vehicles` (
	`owner` varchar(22) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext,
	`type` VARCHAR(20) NOT NULL DEFAULT 'car',
	`job` VARCHAR(20) NOT NULL,
	`stored` TINYINT(1) NOT NULL DEFAULT '0',
	`zone` longtext DEFAULT NULL,

	PRIMARY KEY (`plate`)
);

-- Si vous avez déjà la table owned_vehicles

ALTER TABLE `owned_vehicles` ADD `name` longtext NOT NULL DEFAULT 'Central' AFTER `stored`;
