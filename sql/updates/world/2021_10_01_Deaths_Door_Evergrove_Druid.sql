SET @ENTRY := 22423;
UPDATE `world`.`creature` SET `position_z` = '200.561', `spawndist` = '0' , `MovementType` = '0' WHERE `id` = @ENTRY;
UPDATE `world`.`creature_template` SET `modelid1` = '11686', `modelid3` = '11686', `npcflag` = '2', `speed_walk` = '2', `speed_run` = '2', `MovementType` = '0', `inhabittype`='5', `AIName`= 'SmartAI', `flags_extra` = '2' WHERE `entry` = @ENTRY;
UPDATE `creature_template_addon` SET `bytes1`='0',`bytes2`='4097',`mount`='0',`emote`='0',`auras`=NULL WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`='0' AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,1,38782,0,0,0,11,38776,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - On hit by signal - transform to crow'),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,19,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - On hit by signal - Remove field flag'),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,69,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Evergrove Druid - On hit by signal - Follow player invoker'),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,80,2242300,2,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - Call Actionlist'),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,41,180000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - After 3 min - despawn'),
(@ENTRY,0,4,5,64,0,100,1,0,0,0,0,11,39158,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - On gossip hello - transform to druid, since end point for follow can"t be player'),
(@ENTRY,0,5,6,61,0,100,1,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - On gossip hello - stay'),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,41,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - After 60 sec - despawn'),
(@ENTRY,0,7,0,19,0,100,0,10904,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - On target accepted next quest - despawn'),
(@ENTRY,0,8,0,19,0,100,0,10911,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - On target accepted next quest - despawn'),
(@ENTRY,0,9,0,19,0,100,0,10912,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - On target accepted next quest - despawn'),
(@ENTRY,0,11,0,25,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - On Spawn - Remove quest flag');

-- Actionlist SAI
SET @ENTRY1 := 2242300;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY1 AND `source_type`='9';
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY1,9,0,0,1,0,100,0,10000,10000,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Evergrove Druid - Set npcflag = 2');