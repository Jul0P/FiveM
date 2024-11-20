INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_ammunation', 'Ammunation', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_ammunation', 'Ammunation', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ammunation', 'Ammunation', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('ammunation', 0, 'recrue', 'Recrue', 20, '', ''),
('ammunation', 1, 'member', 'Ammunation', 40, '', ''),
('ammunation', 2, 'leader', 'Chef de Chaine', 60, '', ''),
('ammunation', 3, 'boss', 'Patron', 80, '', '');

INSERT INTO `jobs` (name, label) VALUES
	('ammunation','Ammunation')
;