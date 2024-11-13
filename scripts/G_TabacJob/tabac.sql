INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_tabac', 'Tabac', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_tabac', 'Tabac', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_tabac', 'Tabac', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('tabac', 0, 'recrue', 'Recrue', 20, '', ''),
('tabac', 1, 'member', 'Tabac', 40, '', ''),
('tabac', 2, 'leader', 'Chef de Ligne', 60, '', ''),
('tabac', 3, 'boss', 'Patron', 80, '', '');

INSERT INTO `jobs` (name, label) VALUES
	('tabac','Tabac')
;

INSERT INTO `items` (`name`, `label`) VALUES
	('tabac', 'Tabac'),
	('malboro', 'Malboro')
;