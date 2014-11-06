-- making everything CHAR(36) ascii will make indexes 1/3 the size,
-- so you can do more in memory and comparisons are proportionately faster.

-- first validate all the values will fit into char(36) ascii
DROP TABLE IF EXISTS uuid_validate;
CREATE TABLE uuid_validate (
  id CHAR(36) CHARACTER SET ascii
);

INSERT INTO `uuid_validate` SELECT `user_id` FROM `authz_approvals`; 
INSERT INTO `uuid_validate` SELECT `client_id` FROM `authz_approvals`; 
 
INSERT INTO `uuid_validate` SELECT `client_id` FROM `client_idp`; 
INSERT INTO `uuid_validate` SELECT `identity_provider_id` FROM `client_idp`; 

INSERT INTO `uuid_validate` SELECT `group_id` FROM `external_group_mapping`; 

INSERT INTO `uuid_validate` SELECT `group_id` FROM `group_membership`; 
INSERT INTO `uuid_validate` SELECT `member_id` FROM `group_membership`; 

INSERT INTO `uuid_validate` SELECT `id` FROM `groups`; 

INSERT INTO `uuid_validate` SELECT `id` FROM `identity_provider`; 
INSERT INTO `uuid_validate` SELECT `identity_zone_id` FROM `identity_provider`; 

INSERT INTO `uuid_validate` SELECT `id` FROM `identity_zone`; 
INSERT INTO `uuid_validate` SELECT `service_instance_id` FROM `identity_zone`; 

INSERT INTO `uuid_validate` SELECT `client_id` FROM `oauth_client_details`; 
INSERT INTO `uuid_validate` SELECT `identity_zone_id` FROM `oauth_client_details`; 

INSERT INTO `uuid_validate` SELECT `id` FROM `users`; 
INSERT INTO `uuid_validate` SELECT `identity_provider_id` FROM `users`; 

DROP TABLE uuid_validate;

-- now alter columns
ALTER TABLE `authz_approvals` 
MODIFY COLUMN `user_id` CHAR(36) CHARACTER SET ascii,
MODIFY COLUMN `client_id` CHAR(36) CHARACTER SET ascii;

ALTER TABLE `client_idp` 
MODIFY COLUMN `client_id` CHAR(36) CHARACTER SET ascii,
MODIFY COLUMN `identity_provider_id` CHAR(36) CHARACTER SET ascii;

ALTER TABLE `external_group_mapping` 
MODIFY COLUMN `group_id` CHAR(36) CHARACTER SET ascii;

ALTER TABLE `group_membership` 
MODIFY COLUMN `group_id` CHAR(36) CHARACTER SET ascii,
MODIFY COLUMN `member_id` CHAR(36) CHARACTER SET ascii;

ALTER TABLE `groups` 
MODIFY COLUMN `id` CHAR(36) CHARACTER SET ascii;

ALTER TABLE `identity_provider` 
MODIFY COLUMN `id` CHAR(36) CHARACTER SET ascii,
MODIFY COLUMN `identity_zone_id` CHAR(36) CHARACTER SET ascii;

ALTER TABLE `identity_zone` 
MODIFY COLUMN `id` CHAR(36) CHARACTER SET ascii,
MODIFY COLUMN `service_instance_id` CHAR(36) CHARACTER SET ascii;

ALTER TABLE `oauth_client_details` 
MODIFY COLUMN `client_id` CHAR(36) CHARACTER SET ascii,
MODIFY COLUMN `identity_zone_id` CHAR(36) CHARACTER SET ascii;

ALTER TABLE `users` 
MODIFY COLUMN `id` CHAR(36) CHARACTER SET ascii,
MODIFY COLUMN `identity_provider_id` CHAR(36) CHARACTER SET ascii;

