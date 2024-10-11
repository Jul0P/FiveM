CREATE TABLE `pascenseurbuilder` (
    `id` int(11) NOT NULL,
    `label` varchar(100) DEFAULT NULL,
    `teleport_data` longtext DEFAULT NULL,
    `job_data` longtext DEFAULT NULL,
    `user_data` longtext DEFAULT NULL,
    `blips_data` longtext DEFAULT NULL,
    `markers_data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `pascenseurbuilder`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `pascenseurbuilder`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;