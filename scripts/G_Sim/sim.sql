CREATE TABLE `g_sim` (
  `id` int(11) NOT NULL,
  `identifier` varchar(555) NOT NULL,
  `number` varchar(555) NOT NULL,
  `name` varchar(555) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `g_sim`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `g_sim`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
