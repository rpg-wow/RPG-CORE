-- The Botanica and The Mecanar exit areatriggers
DELETE FROM `areatrigger_teleport` WHERE `id` IN (4612,4614);
INSERT INTO `areatrigger_teleport` (`id`,`name`,`access_id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(4612,'The Botanica',0,530,3407.110107,1488.479980,182.837753,2.501119),
(4614,'The Mechanar',0,530,2869.885742,1552.755249,252.158997,0.733993);