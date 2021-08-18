/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : user

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 18/08/2021 23:13:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '这条子评论的id',
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `mid` int(11) DEFAULT NULL COMMENT '这条子评论所评论的父评论id',
  `reply_id` int(11) DEFAULT NULL COMMENT '这条子评论所评论的子评论id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `commentwj`(`uid`) USING BTREE,
  CONSTRAINT `commentwj` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '一楼说的对', '2021-04-03 09:38:44', 2, 1, NULL);
INSERT INTO `comment` VALUES (2, '上面的你说的也对', '2021-04-03 09:40:49', 3, 1, 1);
INSERT INTO `comment` VALUES (3, '二楼说的没错赞一个', '2021-04-03 09:42:00', 2, 2, NULL);
INSERT INTO `comment` VALUES (4, '你们说的都对', '2021-04-03 18:13:18', 4, 1, NULL);
INSERT INTO `comment` VALUES (5, '你到底是谁', '2021-04-03 19:08:45', 3, 29, NULL);
INSERT INTO `comment` VALUES (6, '我是你爷爷', '2021-04-03 19:09:58', 3, 29, 5);
INSERT INTO `comment` VALUES (7, '说得好', '2021-04-03 19:10:14', 3, 28, NULL);
INSERT INTO `comment` VALUES (8, '可以的小伙子', '2021-04-03 19:10:41', 3, 2, 3);
INSERT INTO `comment` VALUES (9, '谢谢', '2021-04-03 19:35:45', 1, 28, 7);
INSERT INTO `comment` VALUES (10, '不客气', '2021-04-03 19:56:18', 3, 28, 9);
INSERT INTO `comment` VALUES (11, '加油陌生人', '2021-04-03 21:25:36', 1, 27, NULL);
INSERT INTO `comment` VALUES (12, '1234', '2021-05-16 14:07:08', 11, 28, 9);
INSERT INTO `comment` VALUES (13, '666666', '2021-05-19 16:24:05', 1, 30, NULL);

-- ----------------------------
-- Table structure for dynamic
-- ----------------------------
DROP TABLE IF EXISTS `dynamic`;
CREATE TABLE `dynamic`  (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `likeid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`mid`) USING BTREE,
  INDEX `wj`(`uid`) USING BTREE,
  CONSTRAINT `wj` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dynamic
-- ----------------------------
INSERT INTO `dynamic` VALUES (1, '牛啊牛啊', '2020-10-20 09:32:09', 1, NULL, '2,3');
INSERT INTO `dynamic` VALUES (2, '再来一条', '2020-10-21 09:45:45', 2, NULL, '1');
INSERT INTO `dynamic` VALUES (3, '多发几条', '2020-10-21 09:47:55', 2, NULL, NULL);
INSERT INTO `dynamic` VALUES (4, '666666', '2020-10-21 09:52:06', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (5, '再来一条', '2020-10-21 09:52:42', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (6, '再来一条', '2020-10-21 09:54:03', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (7, '122', '2020-10-21 09:58:56', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (8, '哈哈哈', '2020-10-21 10:01:00', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (9, '你好', '2020-10-21 10:19:59', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (10, '我来了', '2020-10-21 10:24:06', 3, NULL, NULL);
INSERT INTO `dynamic` VALUES (11, '瓦大喜哇卡密哒！', '2020-10-21 10:39:49', 3, NULL, NULL);
INSERT INTO `dynamic` VALUES (12, '大家好我是新檀黎斗', '2020-10-21 10:41:17', 3, NULL, NULL);
INSERT INTO `dynamic` VALUES (13, '今天开始我叫檀黎斗神', '2020-10-21 10:41:31', 3, NULL, NULL);
INSERT INTO `dynamic` VALUES (14, '有时候拖拖拉拉的原因真的不是因为「懒」，而是「这破事儿我实在他妈的不想做」。', '2020-10-21 11:03:30', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (15, '语言的真正作用与其说是表达我们的需求，不如说是掩饰我们的需求', '2020-10-21 11:05:04', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (16, '我适应了有光的世界，却仍然想追随你散发的光芒活得熠熠生辉。', '2020-10-21 11:05:20', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (17, '读书翻页时感觉朋友很多，等到细品一个段落时朋友突然变少，等到细读一句话时朋友已经寥寥无几，等到我想用着重符号标出几个重点字词时却发现没有了。', '2020-10-21 11:05:39', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (18, '“你我皆为星辰之子，每一个细胞都书写着整个宇宙的历史，当你凝视自己，也望见了宇宙的轮廓。”', '2020-10-21 11:06:17', 2, NULL, NULL);
INSERT INTO `dynamic` VALUES (19, '即使组成我的粒子终将归还宇宙，但那时变成星辰的我一定更美丽', '2020-10-21 11:06:26', 2, NULL, NULL);
INSERT INTO `dynamic` VALUES (20, '不好意思 我错到我对你的世界到一种讨厌的地步了', '2020-10-21 11:11:43', 4, NULL, NULL);
INSERT INTO `dynamic` VALUES (21, '请祝我快乐', '2020-10-21 11:13:09', 4, NULL, NULL);
INSERT INTO `dynamic` VALUES (22, '如果结果并非所愿，那就在尘埃落定前奋力一搏。', '2020-10-21 11:18:57', 5, NULL, NULL);
INSERT INTO `dynamic` VALUES (23, '对我就是基拉，我会创造一个没有罪犯的世界，我会是新世界的神', '2020-10-21 14:41:07', 7, NULL, NULL);
INSERT INTO `dynamic` VALUES (24, '一生才有一次的死亡，那便是我的追求。', '2020-10-21 14:50:37', 8, NULL, NULL);
INSERT INTO `dynamic` VALUES (25, '我仍然认为向人诉苦不过是徒劳，与其如此，不如默默承受。', '2020-10-21 14:51:39', 8, NULL, NULL);
INSERT INTO `dynamic` VALUES (26, '“所谓见一个爱一个，\n其实就是谁也不爱吧。”', '2020-10-21 14:52:34', 8, NULL, NULL);
INSERT INTO `dynamic` VALUES (27, '生而为人，我很抱歉', '2020-10-21 14:52:53', 8, NULL, NULL);
INSERT INTO `dynamic` VALUES (28, '妙啊真是妙蛙种子吃着妙脆角进了米奇妙妙屋妙到家了', '2020-10-25 15:54:39', 1, NULL, NULL);
INSERT INTO `dynamic` VALUES (29, '我又回来了，你们好啊', '2021-04-03 18:58:12', 3, NULL, NULL);
INSERT INTO `dynamic` VALUES (30, '1234556', '2021-05-16 14:06:59', 11, NULL, NULL);
INSERT INTO `dynamic` VALUES (31, '很怀念的感觉。。。', '2021-05-19 16:23:45', 1, NULL, NULL);

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follow` int(11) DEFAULT NULL,
  `befollow` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of follow
-- ----------------------------
INSERT INTO `follow` VALUES (1, 1, 2);
INSERT INTO `follow` VALUES (2, 2, 1);
INSERT INTO `follow` VALUES (3, 1, 3);
INSERT INTO `follow` VALUES (4, 1, 5);
INSERT INTO `follow` VALUES (5, 5, 1);

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apply` int(11) DEFAULT NULL,
  `beapply` int(11) DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `isadd` tinyint(1) DEFAULT NULL,
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friend
-- ----------------------------
INSERT INTO `friend` VALUES (1, 1, 2, '你好啊', 1, '2021-05-01 23:04:29');
INSERT INTO `friend` VALUES (2, 3, 1, '哈哈哈哈', 1, '2021-05-04 15:46:57');
INSERT INTO `friend` VALUES (5, 4, 1, '我是admin', 1, '2021-05-04 15:39:08');
INSERT INTO `friend` VALUES (7, 8, 1, '6666666', 0, '2021-05-04 19:20:38');
INSERT INTO `friend` VALUES (8, 5, 1, '我是夏目贵志', 1, '2021-05-08 11:43:47');
INSERT INTO `friend` VALUES (9, 1, 7, '我是夜神月', 0, '2021-04-27 15:05:07');
INSERT INTO `friend` VALUES (10, 1, 9, NULL, 1, NULL);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `fid` int(11) DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 1, 2, '时间简史', NULL, '2021-05-08 11:33:28');
INSERT INTO `message` VALUES (2, 2, 1, '是不好意思说', NULL, NULL);
INSERT INTO `message` VALUES (3, 1, 2, '挖得唔得方法', NULL, NULL);
INSERT INTO `message` VALUES (4, 1, 3, '对对方水电费', NULL, NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', 'admin@qq.com', '加油加油加油', 2, '2020-09-30', '/public/images/avatar/16203527895041620352789458.png');
INSERT INTO `users` VALUES (2, 'ryota', 'chicheng', '2367650895@qq.com', '今天也要加油啊', 1, '2019-10-30T16:00:00.000Z', '/public/images/avatar/1603249719512e7ce86382fa47c58d7f89334538b235a.jpg');
INSERT INTO `users` VALUES (3, 'root', '654321', 'root@qq.com', '最强的GAMEMASTER', 1, '2013-09-02T16:00:00.000Z', '/public/images/avatar/1617424043992u=2409086564,4092922119&fm=26&gp=0.jpg');
INSERT INTO `users` VALUES (4, '赤橙Ryota', 'chicheng', 'ryota1@qq.com', '什么也无法舍弃的人什么也无法得到', 1, '2008-09-30T16:00:00.000Z', '/public/images/avatar/161742393186929c52b526855b04b3b85282a89134631.jpg');
INSERT INTO `users` VALUES (5, '夏目贵志', '123456', 'xiamu@qq.com', '此生无悔遇夏目，来世愿做帐中妖。', 1, '2018-09-30T16:00:00.000Z', '/public/images/avatar/1603250241278892e5b55170b2aad76ea9cb1a4c42551.jpg');
INSERT INTO `users` VALUES (7, '夜神月', '123456', 'yeshengyue@qq.com', '111', 1, '2020-10-19T16:00:00.000Z', '/public/images/avatar/160326210741046849996dc773d969f561b42ac4fce6e.jpg');
INSERT INTO `users` VALUES (8, '太宰治', '123456', 'taizaizhi@qq.com', '222', 1, '2020-10-14T16:00:00.000Z', '/public/images/avatar/1603262878798a2e7ff7ee3e011229f3f503925d824b9.jpg');
INSERT INTO `users` VALUES (9, '玛卡巴卡', 'makabaka', 'makabaka@qq.com', NULL, 2, '2021-04-02T16:00:00.000Z', '/public/images/avatar/default_avatar.jpg');
INSERT INTO `users` VALUES (10, '卡面来打', '123456', 'kamianlaida@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg');
INSERT INTO `users` VALUES (11, 'admin2', '123456', 'admiin@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg');

SET FOREIGN_KEY_CHECKS = 1;
