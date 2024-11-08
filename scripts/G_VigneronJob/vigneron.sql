INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_vigneron', 'Vigneron', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_vigneron', 'Vigneron', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_vigneron', 'Vigneron', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('vigneron', 0, 'recrue', 'Recrue', 20, '', ''),
('vigneron', 1, 'member', 'Vigneron', 40, '', ''),
('vigneron', 2, 'leader', 'Chef de Chaï', 60, '', ''),
('vigneron', 3, 'boss', 'Patron', 80, '', '');

INSERT INTO `jobs` (name, label) VALUES
	('vigneron','Vigneron')
;

INSERT INTO `items` (`name`, `label`) VALUES
	('raisin', 'Raisin'),
	('vin', 'Vin')
;