CREATE TABLE `g_clothes_item` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `item` longtext COLLATE utf8mb4_bin NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `label` varchar(40) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

ALTER TABLE `g_clothes_item`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `g_clothes_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

CREATE TABLE `g_clothes_outfit` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(20) COLLATE utf8mb4_bin DEFAULT 'Inconnu'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

ALTER TABLE `g_clothes_outfit`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `g_clothes_outfit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
