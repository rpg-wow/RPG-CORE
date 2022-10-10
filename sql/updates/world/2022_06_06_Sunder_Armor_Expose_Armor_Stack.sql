DELETE FROM `spell_group_stack_rules` WHERE `group_id`=1074;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (1074, 1);

DELETE FROM `spell_group` WHERE `id`=1074 AND `spell_id`=7386;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES (1074, 7386);
DELETE FROM `spell_group` WHERE `id`=1074 AND `spell_id`=8647;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES (1074, 8647);
