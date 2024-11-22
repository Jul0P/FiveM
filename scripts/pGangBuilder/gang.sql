CREATE TABLE `pgangbuilder` (
    `id` int(11) NOT NULL,
    `name` varchar(100) DEFAULT NULL,
    `label` varchar(100) DEFAULT NULL,
    `society_pos` varchar(100) DEFAULT NULL,
    `society_gestion` varchar(100) DEFAULT NULL,
    `garage_pos` varchar(100) DEFAULT NULL,
    `spawn_pos` varchar(100) DEFAULT NULL,
    `return_pos` varchar(100) DEFAULT NULL,
    `pnj` varchar(100) DEFAULT NULL,
    `garage_data` longtext DEFAULT NULL,
    `coffre_pos` varchar(100) DEFAULT NULL,
    `weight` varchar(100) DEFAULT NULL,
    `coffre_data` longtext DEFAULT NULL,
    `vestiaire_pos` varchar(100) DEFAULT NULL,
    `vestiaire_gestion` varchar(100) DEFAULT NULL,
    `vestiaire_data` longtext DEFAULT NULL,
    `blips` longtext DEFAULT NULL,
    `markers` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `pgangbuilder`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `pgangbuilder`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;