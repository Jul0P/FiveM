INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('police', 0, 'cadet', 'Cadet', 20, '', ''),
('police', 1, 'officer', 'Officier', 40, '', ''),
('police', 2, 'sergent', 'Sergeant', 40, '', ''),
('police', 3, 'lieutenant', 'Lieutenant', 40, '', ''),
('police', 4, 'captain', 'Capitaine', 40, '', ''),
('police', 5, 'boss', 'Commandant', 80, '', '');

INSERT INTO `jobs` (name, label) VALUES
	('police','Police')
;

CREATE TABLE `G_police_casier` (
  `id` int(11) NOT NULL,
  `nomprenom` varchar(255) DEFAULT NULL,
  `montant` double DEFAULT NULL,
  `raison` varchar(255) DEFAULT NULL,
  `ownerfolder` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Ouvert'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `G_police_casier`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `G_police_casier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;