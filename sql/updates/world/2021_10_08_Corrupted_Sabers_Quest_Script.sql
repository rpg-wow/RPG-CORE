UPDATE `world`.`creature_template` SET `AIName` = 'EventAI' WHERE `entry` = '9937'; 
INSERT INTO `world`.`creature_ai_scripts` VALUES (993701, '9937', '1', '0', '100', '0', '1500', '1500', '0', '0', '3', '9936', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Model Change Small Corrupted'); 
INSERT INTO `world`.`creature_ai_scripts` VALUES (993702, '9937', '1', '0', '100', '0', '3500', '3500', '0', '0', '3', '10042', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Model Change Big Corrupted'); 

-- Insert Gossip /custom made id/
DELETE FROM `gossip_menu_option` WHERE `menu_id`=55002 AND `id`=1;
INSERT INTO `gossip_menu_option` VALUES (55002,1,0,'I want to release the saber to Winna.',1,131,0);

-- Only show gossip if near Winna
DELETE FROM `conditions` WHERE `SourceGroup`=55002 AND `SourceTypeOrReferenceId`=15;
INSERT INTO `conditions` VALUES (15,55002,1,0,29,1,9996,5,0,0,0,'','Only show second gossip Corrupted Saber is near Wina in 5 yards');

INSERT INTO `world`.`gossip_scripts` VALUES ('50002', '0', '7', '4506', '30', '0', '-10291.2', '-4315.28', '-38.382', '4.07'); 
INSERT INTO `world`.`gossip_scripts` VALUES ('50002', '0', '18', '2000', '0', '0', '-10291.2', '-4315.28', '-38.382', '4.07'); 
UPDATE `world`.`gossip_menu_option` SET `action_script_id` = '50002' WHERE `menu_id` = '55002' AND `id` = '1';
