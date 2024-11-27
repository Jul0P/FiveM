INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_drivingdealer', 'Instructeur Auto-École', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_drivingdealer', 'Instructeur Auto-École', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_drivingdealer', 'Instructeur Auto-École', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
    ('drivingdealer', 0, 'recruit', 'Stagiaire', 20, '', ''),
    ('drivingdealer', 1, 'instructor', 'Moniteur', 40, '', ''),
    ('drivingdealer', 2, 'leader', 'Moniteur Gérant', 60, '', ''),
    ('drivingdealer', 3, 'boss', 'Patron', 80, '', '')
;

INSERT INTO `jobs` (name, label) VALUES
	('drivingdealer', 'Instructeur Auto-École')
;

-- au cas où

CREATE TABLE `licenses` (
	`type` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`type`)
);

CREATE TABLE `user_licenses` (
	`id` int NOT NULL AUTO_INCREMENT,
	`type` varchar(60) NOT NULL,
	`owner` varchar(40) NOT NULL,

	PRIMARY KEY (`id`)
);

-- pour les permis

INSERT INTO `licenses` (`type`, `label`) VALUES
	('dmv', 'Code'),
	('drive', 'Permis voiture'),
	('drive_bike', 'Permis moto'),
	('drive_truck', 'Permis camion'),
    ('drive_plane', 'Permis avion'),
    ('drive_boat', 'Permis bateau'),
    ('drive_helico', 'Permis hélicoptère')
;