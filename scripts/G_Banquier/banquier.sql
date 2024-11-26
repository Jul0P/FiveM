INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_banquier','Banquier',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_banquier', 'Banquier', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_banquier','Banquier',1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('banquier', 'Banquier', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('banquier', 0, 'recrue','Stagiaire', 250, '{}', '{}'),
('banquier', 1, 'banker','Banquier', 500, '{}', '{}'),
('banquier', 2, 'boss', 'Patron', 1000, '{}', '{}');
