-- credit_card
TRUNCATE TABLE credit_card;
INSERT INTO `credit_card` VALUES 
  (1,5,'1111111111111111',11,1111,'111'),
  (2,5,'2222222222222222',11,1111,'111'),
  (3,6,'1111111111111112',11,1111,'111'),
  (4,7,'1111111111111112',11,1111,'111');

-- address
TRUNCATE TABLE address;
INSERT INTO `address` VALUES 
  (1,5,'469','Cambridge St','MA',''),
  (4,7,'469','Cambridge St','MA','02141');
  

-- publisher
TRUNCATE TABLE publisher;
INSERT INTO `publisher` VALUES 
  (1,'Fantasy Flight Games'),
  (2,'Stonemaier Games'),
  (3,'Cephalofair Games'),
  (4,'Blue Orange Games'),
  (5,'Garphill Games'),
  (6,'Eagle-Gryphon Games'),
  (7,'Days of Wonder'),
  (8,'Queen Games'),
  (9,'Plan B Games'),
  (10,'Rio Grande Games');
  
  
-- game_mechanic
TRUNCATE TABLE game_mechanic;
INSERT INTO `game_mechanic` VALUES (3,'Area Control'),
  (8,'Card Drafting'),
  (5,'Cooperative Play'),
  (1,'Deck Building'),
  (7,'Dice Rolling'),
  (9,'Hidden Role'),
  (43,'Miniature'),
  (10,'Pattern Building'),
  (6,'Set Collection'),
  (4,'Tile Placement'),
  (2,'Worker Placement');


-- designer
TRUNCATE TABLE designer;
INSERT INTO `designer` VALUES (1,'Eric Lang'),
  (2,'Jamey Stegmaier'),
  (3,'Isaac Childres'),
  (4,'Elaine Reese'),
  (5,'Shem Phillips'),
  (6,'Vital Lacerda'),
  (7,'Bruno Cathala'),
  (8,'Reiner Knizia'),
  (9,'Elizabeth Hargrave'),
  (10,'Uwe Rosenberg');


-- game_type
TRUNCATE TABLE game_type;
INSERT INTO `game_type` VALUES 
  (6,'Adventure Game'),
  (8,'Cooperative Campaign Game'),
  (4,'Deck Builder'),
  (5,'Eurogame'),
  (2,'Family Game'),
  (3,'Party Game'),
  (10,'Role-Playing Game'),
  (7,'Social Deduction'),
  (1,'Strategy Board Game'),
  (9,'Tile-Laying Game');


-- gameitem
TRUNCATE TABLE gameitem;
INSERT INTO `gameitem` VALUES 
  (1,'Twilight Imperium',1997,3,6,14,240,480,0,0,0,0,0,0,2,1,1,1,100),
  (2,'Scythe',2016,1,7,14,90,115,0,1,8,0,3.5,4,2,2,2,2,80),
  (3,'Gloomhaven',2017,1,4,12,60,120,1,2,7,1,9,9,3,3,3,3,140),
  (4,'Carcassonne',2000,2,5,7,30,45,0,0,0,0,0,0,4,4,4,4,30),
  (5,'Ticket to Ride',2004,2,5,8,30,60,0,0,0,0,0,0,5,5,5,5,45),
  (6,'Pandemic',2008,2,4,10,45,60,1,0,0,0,0,0,6,6,6,6,35),
  (7,'7 Wonders',2010,2,7,10,30,45,0,0,0,0,0,0,7,7,7,7,40),
  (8,'Codenames',2015,4,8,12,15,30,0,0,0,0,0,0,8,8,8,8,25),
  (9,'Wingspan',2019,1,5,10,40,70,1,2,5.5,3.20156,4,2.5,9,9,9,9,60),
  (10,'Terraforming Mars',2016,1,5,12,120,180,0,1,10,0,10,10,10,10,10,10,55);
  
  
-- store_order
TRUNCATE TABLE store_order;
INSERT INTO `store_order` VALUES (1,'Placed','2023-12-05',5,1,1),
  (2,'Placed','2023-12-06',5,1,1),
  (3,'Placed','2023-12-06',5,1,1),
  (4,'Placed','2023-12-06',5,1,2),
  (5,'In Progress','2023-12-06',5,1,2),
  (10,'Placed','2023-12-07',7,4,4);


-- order_item
TRUNCATE TABLE order_item;
INSERT INTO `order_item` VALUES (1,1,3,3),
  (2,2,3,1),
  (3,3,3,1),
  (4,4,3,2),
  (5,5,3,1),
  (10,10,8,2);


-- review
TRUNCATE TABLE review;
INSERT INTO `review` VALUES (1,5,2,8,'',7,8),
  (2,5,3,8,'Great!',8,8),
  (3,5,9,1,'Good!',1,1),
  (4,5,3,6,'Enjoyed playing this!',6,6),
  (5,5,10,10,'Good Game',10,10),
  (7,6,9,6,'Amazing game!!!',7,4);
