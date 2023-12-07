-- auth_group
TRUNCATE TABLE `auth_group`;
INSERT INTO `auth_group` VALUES 
  (1, 'customer_group'),
  (3, 'manager_group'),
  (2, 'staff_group');
 
 
-- auth_user
TRUNCATE TABLE `auth_user`;
INSERT INTO `auth_user` VALUES
  (1, 'pbkdf2_sha256$600000$AdgjEL68ZHDA12IlXpv1xR$PiNQHxwn/25fNc3QqncAnWS3Sbye8sGT9/ouhzqFqKk=', '2023-12-06 20:20:22.000000', 1, 'admin', '', '', 'admin@admin.com', 1, 1, '2023-11-19 15:33:16.000000'),
  (3, 'pbkdf2_sha256$600000$ZTld5skHgRjNITq97JX8GW$dAV3UUml084GyRG4yiacNTdbBxg0wqN6g0CtYFwfq5k=', '2023-12-07 03:40:21.557599', 0, 'testStaff', '', '', 'testStaff@gmail.com', 0, 1, '2023-11-27 02:13:36.000000'),
  (5, 'pbkdf2_sha256$600000$HkTsrr9ewl7X43qY5ekhQ$OCtX7kIQBLJdnq4VQTnScslfygq7+8V4BSQP7U4D89c=', '2023-12-07 01:51:40.736099', 0, 'testCustomer', '', '', 'customer@gmail.com', 0, 1, '2023-12-06 16:17:20.000000'),
  (6, 'pbkdf2_sha256$600000$yF0C4ZT6QH4ici7l9LMjfH$P/TTPG5QA36iLsPmWI9pTJ+j7ADiojTDg2BUGEmNEGU=', '2023-12-07 03:25:06.479063', 0, 'testManager', '', '', 'manager@gmail.com', 0, 1, '2023-12-06 20:17:53.000000');

-- users_profile
TRUNCATE TABLE `users_profile`;
INSERT INTO `users_profile` VALUES 
  (4,'default.jpg',3),
  (6,'profile_pics/business_cover_WIETqpE.jpeg',1),
  (7,'default.jpg',5),
  (8,'default.jpg',6);

-- django_content_type
TRUNCATE TABLE `django_content_type`;
INSERT INTO `django_content_type` VALUES 
  (1,'admin','logentry'),
  (3,'auth','group'),
  (2,'auth','permission'),
  (4,'auth','user'),
  (5,'contenttypes','contenttype'),
  (7,'dashboard','designer'),
  (13,'dashboard','gameitem'),
  (12,'dashboard','gameitemdesigner'),
  (15,'dashboard','gameitemgamemechanic'),
  (11,'dashboard','gameitemgametype'),(14,'dashboard','gameitempublisher'),
  (8,'dashboard','gamemechanic'),
  (9,'dashboard','gametype'),
  (10,'dashboard','publisher'),
  (6,'sessions','session'),
  (16,'users','profile');


-- django_migrations
TRUNCATE TABLE `django_migrations`;
INSERT INTO `django_migrations` VALUES 
  (1,'contenttypes','0001_initial','2023-11-19 15:32:08.225985'),
  (2,'auth','0001_initial','2023-11-19 15:32:08.507959'),
  (3,'admin','0001_initial','2023-11-19 15:32:08.586520'),
  (4,'admin','0002_logentry_remove_auto_add','2023-11-19 15:32:08.602117'),
  (5,'admin','0003_logentry_add_action_flag_choices','2023-11-19 15:32:08.602117'),
  (6,'contenttypes','0002_remove_content_type_name','2023-11-19 15:32:08.665070'),
  (7,'auth','0002_alter_permission_name_max_length','2023-11-19 15:32:08.696330'),
  (8,'auth','0003_alter_user_email_max_length','2023-11-19 15:32:08.721965'),
  (9,'auth','0004_alter_user_username_opts','2023-11-19 15:32:08.727997'),
  (10,'auth','0005_alter_user_last_login_null','2023-11-19 15:32:08.759274'),
  (11,'auth','0006_require_contenttypes_0002','2023-11-19 15:32:08.759274'),
  (12,'auth','0007_alter_validators_add_error_messages','2023-11-19 15:32:08.774944'),
  (13,'auth','0008_alter_user_username_max_length','2023-11-19 15:32:08.822236'),
  (14,'auth','0009_alter_user_last_name_max_length','2023-11-19 15:32:08.884616'),
  (15,'auth','0010_alter_group_name_max_length','2023-11-19 15:32:08.900265'),
  (16,'auth','0011_update_proxy_permissions','2023-11-19 15:32:08.915890'),
  (17,'auth','0012_alter_user_first_name_max_length','2023-11-19 15:32:08.947640'),
  (18,'sessions','0001_initial','2023-11-19 15:32:08.963248'),
  (19,'dashboard','0001_initial','2023-11-24 03:12:38.064168'),
  (20,'users','0001_initial','2023-11-27 06:17:45.453134'),
  (21,'crud','0001_initial','2023-12-06 16:02:18.498484'),
  (22,'crud','0002_alter_gameitem_game_id','2023-12-06 16:02:18.507819'),
  (23,'crud','0003_designer_gamemechanic_gametype_publisher_and_more','2023-12-06 16:02:18.512250'),
  (24,'dashboard','0002_address_creditcard_orderitem_storeorder_and_more','2023-12-06 16:02:18.517238');


-- auth_permission
TRUNCATE TABLE `auth_permission`;
INSERT INTO `auth_permission` VALUES
  (1, 'Can add log entry', 1, 'add_logentry'),
  (2, 'Can change log entry', 1, 'change_logentry'),
  (3, 'Can delete log entry', 1, 'delete_logentry'),
  (4, 'Can view log entry', 1, 'view_logentry'),
  (5, 'Can add permission', 2, 'add_permission'),
  (6, 'Can change permission', 2, 'change_permission'),
  (7, 'Can delete permission', 2, 'delete_permission'),
  (8, 'Can view permission', 2, 'view_permission'),
  (9, 'Can add group', 3, 'add_group'),
  (10, 'Can change group', 3, 'change_group'),
  (11, 'Can delete group', 3, 'delete_group'),
  (12, 'Can view group', 3, 'view_group'),
  (13, 'Can add user', 4, 'add_user'),
  (14, 'Can change user', 4, 'change_user'),
  (15, 'Can delete user', 4, 'delete_user'),
  (16, 'Can view user', 4, 'view_user'),
  (17, 'Can add content type', 5, 'add_contenttype'),
  (18, 'Can change content type', 5, 'change_contenttype'),
  (19, 'Can delete content type', 5, 'delete_contenttype'),
  (20, 'Can view content type', 5, 'view_contenttype'),
  (21, 'Can add session', 6, 'add_session'),
  (22, 'Can change session', 6, 'change_session'),
  (23, 'Can delete session', 6, 'delete_session'),
  (24, 'Can view session', 6, 'view_session'),
  (25, 'Can add designer', 7, 'add_designer'),
  (26, 'Can change designer', 7, 'change_designer'),
  (27, 'Can delete designer', 7, 'delete_designer'),
  (28, 'Can view designer', 7, 'view_designer'),
  (29, 'Can add game mechanic', 8, 'add_gamemechanic'),
  (30, 'Can change game mechanic', 8, 'change_gamemechanic'),
  (31, 'Can delete game mechanic', 8, 'delete_gamemechanic'),
  (32, 'Can view game mechanic', 8, 'view_gamemechanic'),
  (33, 'Can add game type', 9, 'add_gametype'),
  (34, 'Can change game type', 9, 'change_gametype'),
  (35, 'Can delete game type', 9, 'delete_gametype'),
  (36, 'Can view game type', 9, 'view_gametype'),
  (37, 'Can add publisher', 10, 'add_publisher'),
  (38, 'Can change publisher', 10, 'change_publisher'),
  (39, 'Can delete publisher', 10, 'delete_publisher'),
  (40, 'Can view publisher', 10, 'view_publisher'),
  (41, 'Can add game item game type', 11, 'add_gameitemgametype'),
  (42, 'Can change game item game type', 11, 'change_gameitemgametype'),
  (43, 'Can delete game item game type', 11, 'delete_gameitemgametype'),
  (44, 'Can view game item game type', 11, 'view_gameitemgametype'),
  (45, 'Can add game item designer', 12, 'add_gameitemdesigner'),
  (46, 'Can change game item designer', 12, 'change_gameitemdesigner'),
  (47, 'Can delete game item designer', 12, 'delete_gameitemdesigner'),
  (48, 'Can view game item designer', 12, 'view_gameitemdesigner'),
  (49, 'Can add game item', 13, 'add_gameitem'),
  (50, 'Can change game item', 13, 'change_gameitem'),
  (51, 'Can delete game item', 13, 'delete_gameitem'),
  (52, 'Can view game item', 13, 'view_gameitem'),
  (53, 'Can add game item publisher', 14, 'add_gameitempublisher'),
  (54, 'Can change game item publisher', 14, 'change_gameitempublisher'),
  (55, 'Can delete game item publisher', 14, 'delete_gameitempublisher'),
  (56, 'Can view game item publisher', 14, 'view_gameitempublisher'),
  (57, 'Can add game item game mechanic', 15, 'add_gameitemgamemechanic'),
  (58, 'Can change game item game mechanic', 15, 'change_gameitemgamemechanic'),
  (59, 'Can delete game item game mechanic', 15, 'delete_gameitemgamemechanic'),
  (60, 'Can view game item game mechanic', 15, 'view_gameitemgamemechanic'),
  (61, 'Can add profile', 16, 'add_profile'),
  (62, 'Can change profile', 16, 'change_profile'),
  (63, 'Can delete profile', 16, 'delete_profile'),
  (64, 'Can view profile', 16, 'view_profile');
  
 
-- auth_group_permissions
TRUNCATE TABLE `auth_group_permissions`;
INSERT INTO `auth_group_permissions` VALUES
  (2, 1, 61),
  (3, 1, 62),
  (4, 1, 63),
  (1, 1, 64);


-- auth_user_group
TRUNCATE TABLE `auth_user_groups`;
INSERT INTO `auth_user_groups` VALUES 
  (7,1,1),
  (8,1,2),
  (9,1,3),
  (3,3,2),
  (2,5,1),
  (4,6,1),
  (5,6,2),
  (6,6,3);


-- django_admin_log
TRUNCATE TABLE `django_admin_log`;
INSERT INTO `django_admin_log` VALUES 
  (1,'2023-11-27 06:20:30.246706','1','testRishabh Profile',1,'[{\"added\": {}}]',16,1),
  (2,'2023-11-27 06:20:53.217300','2','testStaff Profile',1,'[{\"added\": {}}]',16,1),
  (3,'2023-11-27 06:30:08.666549','2','testStaff Profile',3,'',16,1),
  (4,'2023-11-27 06:30:08.668543','1','testRishabh Profile',3,'',16,1),
  (5,'2023-11-27 06:30:16.181076','3','testRishabh Profile',1,'[{\"added\": {}}]',16,1),
  (6,'2023-11-27 06:30:25.242568','4','testStaff Profile',1,'[{\"added\": {}}]',16,1),
  (7,'2023-11-27 07:09:54.726649','6','admin Profile',1,'[{\"added\": {}}]',16,1),
  (8,'2023-12-06 15:42:35.508044','1','customer_group',1,'[{\"added\": {}}]',3,1),
  (9,'2023-12-06 15:43:02.770693','1','customer_group',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),
  (10,'2023-12-06 15:54:58.099568','2','testRishabh',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),
  (11,'2023-12-06 16:10:50.253463','2','staff_group',1,'[{\"added\": {}}]',3,1),
  (12,'2023-12-06 16:10:58.468512','3','manager_group',1,'[{\"added\": {}}]',3,1),(13,'2023-12-06 16:15:38.391727','4','newUser4',3,'',4,1),
  (14,'2023-12-06 16:15:38.409506','2','testRishabh',3,'',4,1),
  (15,'2023-12-06 18:04:37.047526','3','testStaff',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),
  (16,'2023-12-06 18:05:27.360383','3','testStaff',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),
  (17,'2023-12-06 18:05:32.394980','5','testCustomer',2,'[]',4,1),
  (18,'2023-12-06 20:20:39.444130','6','testManager',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),
  (19,'2023-12-06 20:20:47.558960','1','admin',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1);