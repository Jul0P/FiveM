INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_barber', 'Barbier', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_barber', 'Barbier', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_barber', 'Barbier', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('barber', 0, 'nettoyeur', 'Nettoyeur', 20, '', ''),
('barber', 1, 'shampouineur', 'Shampouineur', 40, '', ''),
('barber', 2, 'coiffeur', 'Coiffeur', 60, '', ''),
('barber', 3, 'boss', 'Patron', 80, '', '');

INSERT INTO `jobs` (name, label) VALUES
	('barber','Barbier')
;