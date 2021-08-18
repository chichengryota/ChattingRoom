-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2021-08-18 23:15:35
-- 服务器版本： 5.6.50-log
-- PHP 版本： 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `user`
--

-- --------------------------------------------------------

--
-- 表的结构 `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL COMMENT '这条子评论的id',
  `message` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `mid` int(11) DEFAULT NULL COMMENT '这条子评论所评论的父评论id',
  `reply_id` int(11) DEFAULT NULL COMMENT '这条子评论所评论的子评论id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `comment`
--

INSERT INTO `comment` (`id`, `message`, `time`, `uid`, `mid`, `reply_id`) VALUES
(1, '一楼说的对', '2021-04-03 09:38:44', 2, 1, NULL),
(2, '上面的你说的也对', '2021-04-03 09:40:49', 3, 1, 1),
(3, '二楼说的没错赞一个', '2021-04-03 09:42:00', 2, 2, NULL),
(4, '你们说的都对', '2021-04-03 18:13:18', 4, 1, NULL),
(5, '你到底是谁', '2021-04-03 19:08:45', 3, 29, NULL),
(6, '我是你爷爷', '2021-04-03 19:09:58', 3, 29, 5),
(7, '说得好', '2021-04-03 19:10:14', 3, 28, NULL),
(8, '可以的小伙子', '2021-04-03 19:10:41', 3, 2, 3),
(9, '谢谢', '2021-04-03 19:35:45', 1, 28, 7),
(10, '不客气', '2021-04-03 19:56:18', 3, 28, 9),
(11, '加油陌生人', '2021-04-03 21:25:36', 1, 27, NULL),
(12, '1', '2021-05-04 20:25:50', 24, 27, 11),
(13, 'qq', '2021-05-04 20:26:05', 24, 27, NULL),
(14, '哈哈', '2021-05-13 10:23:17', 52, 38, NULL),
(15, '确实', '2021-05-15 14:30:07', 29, 38, NULL),
(16, '111', '2021-05-22 08:57:03', 29, 38, 15),
(17, '111', '2021-05-22 08:57:23', 29, 38, 15),
(18, '111', '2021-05-22 08:57:27', 29, 38, 17),
(19, '20', '2021-05-29 20:05:49', 97, 41, NULL),
(20, '12', '2021-05-29 20:06:00', 97, 41, 19),
(21, '..', '2021-05-29 20:06:05', 97, 41, NULL),
(23, '2', '2021-06-05 19:37:22', 121, 41, NULL),
(24, '11111', '2021-06-11 09:49:44', 93, 46, NULL),
(25, '@', '2021-06-11 10:43:24', 141, 47, NULL),
(26, '我是不是很帅', '2021-06-11 14:39:15', 145, 49, NULL),
(27, '是的，超级帅', '2021-06-11 14:39:32', 145, 49, 26),
(29, '3234324', '2021-06-22 16:40:54', 166, 49, 28),
(30, '323', '2021-06-22 16:41:31', 166, 49, 27),
(31, '123', '2021-06-23 09:22:51', 168, 54, NULL),
(32, '大声道', '2021-07-04 00:26:08', 187, 59, NULL),
(33, 'd阿萨德', '2021-07-04 00:26:13', 187, 59, 32),
(34, '1223', '2021-07-05 09:09:12', 175, 54, 31),
(35, '122', '2021-07-09 21:46:10', 193, 52, NULL),
(36, '1212', '2021-07-09 21:46:17', 193, 52, 35),
(37, '234', '2021-07-15 12:09:17', 208, 59, 33),
(38, 'awdwawd', '2021-07-21 14:30:12', 219, 59, 33),
(39, '12312', '2021-07-23 18:42:52', 229, 65, NULL),
(40, '1515', '2021-07-23 18:45:55', 229, 64, NULL),
(41, '13515113136', '2021-07-23 19:01:12', 229, 68, NULL),
(42, '16541651561561661', '2021-07-23 19:01:21', 229, 67, NULL),
(43, '666', '2021-07-23 19:08:44', 229, 70, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `dynamic`
--

CREATE TABLE `dynamic` (
  `mid` int(11) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `uid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `dynamic`
--

INSERT INTO `dynamic` (`mid`, `message`, `time`, `uid`) VALUES
(1, '牛啊牛啊', '2020-10-20 09:32:09', 1),
(2, '再来一条', '2020-10-21 09:45:45', 2),
(3, '多发几条', '2020-10-21 09:47:55', 2),
(4, '666666', '2020-10-21 09:52:06', 1),
(5, '再来一条', '2020-10-21 09:52:42', 1),
(6, '再来一条', '2020-10-21 09:54:03', 1),
(7, '122', '2020-10-21 09:58:56', 1),
(8, '哈哈哈', '2020-10-21 10:01:00', 1),
(9, '你好', '2020-10-21 10:19:59', 1),
(10, '我来了', '2020-10-21 10:24:06', 3),
(11, '瓦大喜哇卡密哒！', '2020-10-21 10:39:49', 3),
(12, '大家好我是新檀黎斗', '2020-10-21 10:41:17', 3),
(13, '今天开始我叫檀黎斗神', '2020-10-21 10:41:31', 3),
(14, '有时候拖拖拉拉的原因真的不是因为「懒」，而是「这破事儿我实在他妈的不想做」。', '2020-10-21 11:03:30', 1),
(15, '语言的真正作用与其说是表达我们的需求，不如说是掩饰我们的需求', '2020-10-21 11:05:04', 1),
(16, '我适应了有光的世界，却仍然想追随你散发的光芒活得熠熠生辉。', '2020-10-21 11:05:20', 1),
(17, '读书翻页时感觉朋友很多，等到细品一个段落时朋友突然变少，等到细读一句话时朋友已经寥寥无几，等到我想用着重符号标出几个重点字词时却发现没有了。', '2020-10-21 11:05:39', 1),
(18, '“你我皆为星辰之子，每一个细胞都书写着整个宇宙的历史，当你凝视自己，也望见了宇宙的轮廓。”', '2020-10-21 11:06:17', 2),
(19, '即使组成我的粒子终将归还宇宙，但那时变成星辰的我一定更美丽', '2020-10-21 11:06:26', 2),
(20, '不好意思 我错到我对你的世界到一种讨厌的地步了', '2020-10-21 11:11:43', 4),
(21, '请祝我快乐', '2020-10-21 11:13:09', 4),
(22, '如果结果并非所愿，那就在尘埃落定前奋力一搏。', '2020-10-21 11:18:57', 5),
(23, '对我就是基拉，我会创造一个没有罪犯的世界，我会是新世界的神', '2020-10-21 14:41:07', 7),
(24, '一生才有一次的死亡，那便是我的追求。', '2020-10-21 14:50:37', 8),
(25, '我仍然认为向人诉苦不过是徒劳，与其如此，不如默默承受。', '2020-10-21 14:51:39', 8),
(26, '“所谓见一个爱一个，\n其实就是谁也不爱吧。”', '2020-10-21 14:52:34', 8),
(27, '生而为人，我很抱歉', '2020-10-21 14:52:53', 8),
(28, '妙啊真是妙蛙种子吃着妙脆角进了米奇妙妙屋妙到家了', '2020-10-25 15:54:39', 1),
(29, '我又回来了，你们好啊', '2021-04-03 18:58:12', 3),
(30, '你们好，我是玛卡巴卡', '2021-04-04 20:04:03', 9),
(31, '试试', '2021-04-27 13:29:11', 19),
(32, '啥玩意啊', '2021-05-05 21:59:05', 28),
(33, '牛皮，这界面也太好看了', '2021-05-06 16:06:50', 29),
(34, '厉害厉害', '2021-05-06 21:15:01', 30),
(35, '非常不错了，能做单对单聊天吗', '2021-05-08 17:56:14', 39),
(36, '高级', '2021-05-08 22:16:49', 40),
(37, '123123', '2021-05-10 17:19:48', 48),
(38, '好棒', '2021-05-13 10:23:08', 52),
(39, 'taiqiangl', '2021-05-19 21:11:54', 58),
(40, '111', '2021-05-22 16:10:40', 78),
(41, '10', '2021-05-29 20:05:45', 97),
(43, '66666', '2021-06-03 21:31:50', 1),
(44, '可以教教我吗？', '2021-06-08 16:26:16', 125),
(45, 'aa', '2021-06-08 17:49:13', 58),
(46, '1111', '2021-06-10 17:09:38', 93),
(47, '膜拜大佬', '2021-06-11 10:43:11', 141),
(48, '牛皮', '2021-06-11 14:23:52', 144),
(49, '你好好哦', '2021-06-11 14:38:51', 145),
(50, '哈哈哈', '2021-06-11 14:39:50', 145),
(51, '膜拜膜拜\n', '2021-06-15 14:43:30', 152),
(52, '666666\n', '2021-06-17 14:53:41', 154),
(53, '这个有点厉害', '2021-06-20 22:26:00', 162),
(54, '牛牛牛', '2021-06-23 09:22:39', 168),
(55, '牛马牛马 抗打', '2021-06-24 10:25:51', 170),
(56, '勇敢牛牛！', '2021-06-24 12:52:36', 173),
(57, '勇敢牛牛 不怕困难', '2021-06-24 17:25:36', 174),
(58, '今天早点休息，明天考试，考完试就轻松一点了。是啊，该来的总会来，生活还要继续呀。陌生人，你好', '2021-06-24 21:08:32', 175),
(59, '下雨是因为彩虹要出发', '2021-06-24 22:03:14', 141),
(60, '111', '2021-07-09 21:46:02', 193),
(61, '1111111111', '2021-07-09 21:48:13', 193),
(62, '1212', '2021-07-09 21:48:25', 193),
(63, 'test', '2021-07-18 10:11:10', 215),
(64, 'awdwad', '2021-07-21 14:30:34', 219),
(65, 'wadawawd', '2021-07-21 14:30:39', 219),
(66, '你哦们', '2021-07-23 18:46:09', 229),
(67, '烟花来了,大家别出去', '2021-07-23 18:58:46', 229),
(68, '1212121', '2021-07-23 19:00:40', 230),
(69, '烟花到了,张凯丽开孤单\n', '2021-07-23 19:04:20', 230),
(70, '中凯越沙雕\n', '2021-07-23 19:08:23', 230),
(71, '总有一天，该有的总会有，该来的总会来', '2021-08-03 14:14:27', 245),
(72, '总有一天，该有的总会有，该来的总会来', '2021-08-03 14:14:08', 245),
(73, '111111', '2021-08-04 19:52:40', 250),
(74, '好厉害', '2021-08-04 19:53:20', 250),
(75, '优秀', '2021-08-10 10:10:37', 258),
(76, 'lihai', '2021-08-18 18:09:12', 274);

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `birthday` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `signature`, `sex`, `birthday`, `avatar`) VALUES
(1, 'admin', '123456', 'admin@qq.com', '加油加油加油', 2, '2016-10-23T16:00:00.000Z', '/public/images/avatar/160283218164589c2961f4a63cb6156b7af1c2cc372bf.jpg'),
(2, 'ryota', 'chicheng', '2367650895@qq.com', '今天也要加油啊', 1, '2019-10-30T16:00:00.000Z', '/public/images/avatar/1603249719512e7ce86382fa47c58d7f89334538b235a.jpg'),
(3, 'root', '654321', 'root@qq.com', '最强的GAMEMASTER', 1, '2013-09-02T16:00:00.000Z', '/public/images/avatar/1617424043992u=2409086564,4092922119&fm=26&gp=0.jpg'),
(4, '赤橙Ryota', 'chicheng', 'ryota1@qq.com', '什么也无法舍弃的人什么也无法得到', 1, '2008-09-30T16:00:00.000Z', '/public/images/avatar/161742393186929c52b526855b04b3b85282a89134631.jpg'),
(5, '夏目贵志', '123456', 'xiamu@qq.com', '此生无悔遇夏目，来世愿做帐中妖。', 1, '2018-09-30T16:00:00.000Z', '/public/images/avatar/1603250241278892e5b55170b2aad76ea9cb1a4c42551.jpg'),
(7, '夜神月', '123456', 'yeshengyue@qq.com', '111', 1, '2020-10-19T16:00:00.000Z', '/public/images/avatar/160326210741046849996dc773d969f561b42ac4fce6e.jpg'),
(8, '太宰治', '123456', 'taizaizhi@qq.com', '222', 1, '2020-10-14T16:00:00.000Z', '/public/images/avatar/1603262878798a2e7ff7ee3e011229f3f503925d824b9.jpg'),
(9, '玛卡巴卡', 'makabaka', 'makabaka@qq.com', NULL, 2, '2021-04-02T16:00:00.000Z', '/public/images/avatar/default_avatar.jpg'),
(10, '卡面来打', '123456', 'kamianlaida@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(11, '1738093828', 'zww123456', '1738093828@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(12, 'hello', 'hello123', '3267853367@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(13, 'pyw', 'panyingwen', '1348154618@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(14, '123', '123456', '1348154617@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(15, 'testtest', 'testtest', 'aaa@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(16, '111', '111111', '1111111@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(17, '222', '222222', '2222222@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(18, 'qtfy0407', '123456', '123@qq.com', NULL, NULL, NULL, '/public/images/avatar/1619437374413电脑录屏快捷键_百度搜索 - Google Chrome 2021_4_20 20_51_51.png'),
(19, '123456', '123456', '3371943488@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(20, '1q2w3e', '123123', '1@1.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(21, 'sadasdasd', '123456', '1365@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(22, '261788', '123456', '2811932734@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(23, 'fallen', '123123', '4757129@12.ocm', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(24, 'Hizo', '123456', '97684540@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(25, 'cnfox', 'qweasd123', 'Alibaba16@88.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(26, 'chen', '123456', '1234567895@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(27, 'webchang', '123456', 'ssss@qq.com', NULL, NULL, NULL, '/public/images/avatar/1620208997985huitailang.jpg'),
(28, 'hanlin', '123456', '1105880123@qq.com', NULL, NULL, NULL, '/public/images/avatar/1620223207527黑客.jpg'),
(29, 'wqm', '123456', '2604448465@qq.com', NULL, NULL, NULL, '/public/images/avatar/1621060351206bx1.png'),
(30, '111aa', 'aaaaaa', '12@dd.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(31, 'zzz', '123456', '10@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(32, '1223223dd3', '123123', '23@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(33, '213说大声的', '123123', 'sda@QQ.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(34, 'wjdxixi', '123123', 'asd@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(35, '111222', '123123', '5038382819@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(36, 'aaaaaaaaa', 'zzzzzz', '849728710@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(37, 'qqqqqq', 'zzzzzz', '1262626@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(38, 'abcdefg', 'abcdefg', '1341775846@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(39, '李四sdsad', '123456', '1207748322@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(40, 'aoao', 'aoaoao', '180280382@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(41, 'aaa', 'aaaaaa', 'aa1a@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(42, 'asdddasdd', 'wylmzj8023123', '1623818110@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(43, '321', '123456', '1@1.1', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(44, 'adminadmin', 'adminadmin', 'adminadmin@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(45, 'jun233', '123456', '1227491415@qq.com', NULL, NULL, NULL, '/public/images/avatar/16205597906404K29Q[W{C[U74USJ1U)Z4XD.jpg'),
(46, 'wsx', '123456', '980686046@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(47, 'wjn', 'wjn2580.', '304840656@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(48, '123123123', '123123', '123123123@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(49, '南知意', '090022fyt', '3133736912@qq.com', NULL, NULL, NULL, '/public/images/avatar/1621416138303B7LL0PL)2T5BT(TCB{~7435.png'),
(50, '啊啊啊', 'dddddd', 'asd@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(51, '6666', '666666', '666@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(52, 'dfsdfasdf', '123456', '1045845375@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(53, '123123', '123123123', '123456789@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(54, '小柴敏', 'chaimin0101', 'chaimin419@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(55, '我日你马', '123456', '2050949288@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(56, '4213187', '123456', '4213187@qq.con', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(57, 'wyw', '123456', '1252652751@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(58, '20210515', 'abcdef123', '1060160205@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(59, '可可丿', '123456', 'iaiyouxi555@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(60, '122', '888888', '418178107@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(61, '哈哈哈哈', '123456xx', '1571968024@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(62, '268', '123123', '2682114191@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(63, '852', '123456', '2682114181@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(64, '269558', '123456', '2695581085@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(65, 'lfzxmw', '123456', '2587279072@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(66, '1091207443', 'zz990419', '1091207443@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(67, 'zhang', '123456', '804899508@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(68, '1wq', '123456', '1@q.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(69, '123456xx', '123456', '2285096803@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(70, '辜十四', 'Qx16673282865', '3192523455@qq.com', NULL, NULL, NULL, '/public/images/avatar/1621565767360wallhaven-1kjy7v.jpg'),
(71, '2k325', 'S3113.com', 'sunbanghao@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(72, 'jkd123', '20001114', '23125@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(73, '12345ppo', '20001114', '123987@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(74, 'oooo', 'wwwwww', 's0854015@gm.ncue.edu.tw', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(75, 'test', '123456', 'test@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(76, 'abcd', 'Avaya123', 'abcd@sohu.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(77, '111才开刚看过', '111111', '242424@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(78, '副驾驶的咖啡农', 'qqqqqq', 'sdfdsf@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(79, '123654', '123321', '123321@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(80, '1234561', '1231@qq.com', '1231@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(81, '666666', '666666', '666666@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(82, '111111', '111111', '150606194@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(83, 'admin1', '123456', 'admin1@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(84, 'chenf', 'yy10086', '406854954@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(85, 'dddd', '123456', '424326689@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(86, '嘿嘿子', '123456', '111111@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(87, 'liuweibaba', '111111', 'sdfsdfsd@qq.com', NULL, NULL, NULL, '/public/images/avatar/1621831510437Cache_3e620a99c912313a..jpg'),
(88, 'liuwei', '222222', 'sdfsdffsd@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(89, 'feihu', 'Aa123456', '442117354@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(91, 'wabghao', '123123', '2364021875@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(92, 'wanghao', '123123', '2364021876@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(93, 'qwe', '031203yzt', '2395952040@qq.com', NULL, NULL, '2021-06-15T16:00:00.000Z', '/public/images/avatar/1623148660675得得得.jpg'),
(94, 'pur', 'qwerqwer', '1808138595@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(95, 'zjm_123', '123456789', '1085891282@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(96, '12112', '112233', '1222@11.co', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(97, '12345678', '12345678', '12345678@qq.com', NULL, 2, '2001-05-16T16:00:00.000Z', '/public/images/avatar/default_avatar.jpg'),
(98, 'adm', 'admadm', 'adm@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(99, 'Guosity', 'a123456789', '1365158177@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(100, 'www', '123456', 'qwe@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(101, 'qwes', '123123123', '5555555@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(102, 'qwe2', '123123', '55555@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(103, '999999', '123123', '15155131@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(104, 'WH123', 'wanghui123', '28707760401@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(105, 'huagege', 'asd123', '651024151@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(106, 'admin111', '111111', '129677@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(107, 'dawdaw', '123456', 'dwadawd@dawdaw.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(108, 'usernamedu', '123456', 'dwadaw@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(110, '1231231', '123123', '21321@ww.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(111, 'asdfg', '123456', '277@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(112, 'qwer', '123456789', '2237005933@qq.com', 'Love cannot be moved alone', 2, '2021-08-27T16:00:00.000Z', '/public/images/avatar/1622711208347u=1090792880,2736549823&fm=26&gp=0.jpg'),
(113, 'yydszhang', '123456', '932334967@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(114, '1243546', '32435465', '971798746@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(115, '123454321', '32435465', '9717987461@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(116, '12345', '21435123', '12345465@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(117, 'test1', '123456', '3245667@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(118, 'qwerasd', '123456', '18088595@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(119, 'aaaa', '1234567890', 'aaa@126.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(120, 'dudu', '123456', '123456@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(121, 'coder', 'coder123', '141243@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(122, 'jeff', '123123123', '123999@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(123, 'guchen147', '031218qq', '914781743@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(124, '123456qwe', '123456', '115551115@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(125, 'xiaoyueyue', 'xiaoyueyue', '337698104@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(126, '931957632', '1018450487', '1018450487@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(127, 'fuzi', '123456', '943403444@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(128, 'fuzi1', '123456', '11@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(129, '22HOH', '1234567', '2066620076@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(130, 'tttttt', '1234567', '1306248551@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(131, '121', '123456', '1442896226@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(132, 'zhousuotao', 'asd120946.', '1209469306@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(133, 'asd120946', 'asd120946.', '2047778370@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(134, 'qweqwe', 'qweqwe', '2280852020@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(135, '苏先森', '123456789', '414726204@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(136, '小vue', '000000', '2236224962@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(137, '小vv', '000000', '2236224963@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(138, 'yolo', 'yangqipa', 'YANGQIXIANG2001@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(139, '1934494414', '123456789', '1934494414@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(140, '罗伊1', '123456', '1025476896@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(141, 'YDLongLong', '123456', '1871718291@qq.com', NULL, NULL, NULL, '/public/images/avatar/1623379490149background1.jpg'),
(142, '陈奕迅', '123456', '845655611@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(143, 'mnder-he', '123456', '2424681270@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(144, 'mander-he', '123456', '858368316@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(145, 'abc', 'abcabc', 'abc@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(146, '66668', '666666', '6666@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(147, '正在输入中', 'hello123@', '2959874032@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(148, '1234567', '1234567', '1234567@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(149, 'yuyiqun', '123456', 'sa0a4s@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(150, 'czj', 'czjzs1127', '13821459072@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(151, 'thicker', '062830asd', '2759511803@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(152, '11111', '123456789', '1234567890@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(153, 'FFF', '464546', '13062551@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(154, 'ssss', '123456', 'ssssssss@qq.com', '123456789', 1, '2021-06-07T16:00:00.000Z', '/public/images/avatar/1623912985529timg2.jpg'),
(155, 'lwl', '123456', 'ssss@cq.com', NULL, NULL, NULL, '/public/images/avatar/1623804106000wallhaven-0pkqrm.jpg'),
(156, 'qew', '123123', 'qweeq@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(157, '你爸爸', '123456', '1012822111@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(158, '你妈妈', '123456', '1230320@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(159, 'ssssss', 'ssssss', 'sss3s@cq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(160, 'ember', '123456', '112233@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(161, 'qifei', '123456', '111222@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(162, '361736093', '123456', 'songshuang@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(163, 'kun', '160016qq', '3238247327@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(164, '啊啊啊a ', '15174605704', '1526639778@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(166, '小老温', 'Denghuian2191', '2191424759@qq.com', NULL, NULL, NULL, '/public/images/avatar/1624351272201QQ浏览器截图20210414154430.png'),
(167, '小老3温', 'Denghuian2191', '2191424753@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(168, '123ppp', '123123', '123ppp@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(169, 'yq123456', '123456', '1234@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(170, '圣灿Ker', 'zhang123.', '1879729166@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(171, 'niuma', 'wlb9246566426', '2764735011@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(172, '李晓勇的好大儿刘这亲', 'lxy200201229338', '2267313169@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(173, 'zmy', '1837860314', '1837860314@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(174, '小明哥哥', '123456', '7777777@qq.com', NULL, 1, NULL, '/public/images/avatar/default_avatar.jpg'),
(175, '吃螃蟹的羊', '1398.com', '528881398@qq.com', NULL, 1, NULL, '/public/images/avatar/1624540194688126019ED855F2345F77A99A6D5379F9E.jpg'),
(176, 'zhangsan', '123456', '2433521288@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(177, 'lisi', '123456', 'lisi@qq.com', NULL, NULL, NULL, '/public/images/avatar/162455323204171B004368A69F195FCA12021E5E1F5D3.jpg'),
(178, 'wangwu', '123456', '123@q.cd', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(179, 'testtt', '123456', 'testtt@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(180, 'trs', '111111', '2210312801@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(181, 'Ren', 'Drea.chong', '15290118724@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(182, '112233', '123123', '212067466@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(183, 'admin-ad', '123456', '44444444@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(184, '123abc', '123456', '123abc@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(185, 'aaaabb', 'aaaaaa', '14789632@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(186, 'hhhhh', '123456', '1937148616@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(187, 'mgy1232013', '123456mgy', '24@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(188, 'zhouhua', '123456', '2651105998@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(189, 'admina', 'admina', 'admin@admin.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(190, 'caosw', '111111', '1543192061@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(191, 'admin112', '123456', '555@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(192, 'micah', '123321', '1569124799@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(193, 'test710', '123456', '', NULL, NULL, NULL, '/public/images/avatar/16258385848912.jpg'),
(194, 'zdd', '123456', '2373622669@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(195, 'zxx', '123456', '11111111111@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(196, 'qz001', '123456', '922168578@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(197, 'gjwfdsa', '123456', '1223696279@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(198, 'mzx', '123456', '1037775363@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(199, '1234', '123456', '111111111@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(200, 'yeqian', '123456', '798737426@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(201, '胖不拉几', '123456', '695168217@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(202, '51421', '123123', '1232133123@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(203, '446677', '123123', '1323213124123@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(204, '张皓智', '123456', '623920249@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(205, '1021166288', '123456', '1021166288@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(206, '1157568175', 'cw78951230', '1157568175@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(207, '达咩~', '123456', '1571925296@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(208, 'a123', '123456', '1234567778@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(209, '小脚嗷', '123123', '27359@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(210, '小骄傲', '123123', '273259@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(211, '银灵魂酱', 'jkfanling060923', '1581647952@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(212, '123ggggggg', '123123', '826427115@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(213, '张霸霸', 'ZAMTYR1314', '1736446220@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(214, 'aex123', '123456', '1379459028@qq.com', NULL, NULL, NULL, '/public/images/avatar/16264264886461.png'),
(215, 'kiki', '123456', '158477165@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(216, '1234512345', '123123123', '1233323@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(217, 'hhh', '123456', '2878846667@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(218, 'yuwbxz', '111111', '3309565@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(219, 'ajk@qq.com', 'ajk@qq.com', 'ajk@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(220, 'linshisan', '123456', '245013672@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(221, 'Doris', '123123', '1147022664@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(222, 'Doris1', '123123', '1146@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(223, '456', '456456456', '2897781091@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(224, 'aa\'a', '111111', '1234567@123.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(225, '12312138', '123456', '12312138@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(226, 'kimi', '3052257019', '3052257019@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(227, 'bbb', '123456', 'bbb@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(228, 'ccc', '123456', 'ccc@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(229, '张三三', '123456', '11111111@qq.com', NULL, NULL, NULL, '/public/images/avatar/16270390860862030183.jpg'),
(230, 'admin123', '123456', '1478562456@qq.com', NULL, 1, NULL, '/public/images/avatar/1627038085653QQ图片20191014225307.jpg'),
(231, '琚美丽', '123123', '123456222@qq.com', NULL, NULL, NULL, '/public/images/avatar/1627039418079ae8e097bbe5debdcdc216f835bd0e0b4.jpg'),
(232, '147258369', '147258369', '1234560@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(233, '147258369.', '147258369.', '0072207@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(234, 'ddd', '111111', '111@df.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(235, '哈哈哈', '123456', 'balabala@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(236, '123aaa', '123456', '123111@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(237, '主打一个讲究', '546879213', '1443278253@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(238, 'haruhi', 'lf123456', '1527188922@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(239, 'haruhi01', 'lf123456', '1527188923@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(240, 'djskskk', '666666', '17764676776@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(241, 'abcdf', '666666', '1776467776@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(242, 'sekgua', '20136021', '15671600255@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(243, '201050', '123456', '11111@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(244, 'huhao', '20136021', '1567@3.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(245, '2664357178', '123456', '2664357178@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(246, 'qiqi', '123456', '222222@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(247, 'testaa', '123456', '123@123.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(248, 'adminbb', '123456', '11fff@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(249, 'uiiuguiu', '123456', 'jjkjkkj@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(250, '2625758976', 'shen123456', '2625758973@qq.com', NULL, 1, NULL, '/public/images/avatar/default_avatar.jpg'),
(251, 'werew', '11111111', '673730903@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(252, 'wwweee', '11111111', '6737303@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(253, 'zyy', '123456', '123332211@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(254, 'zqq', '123456', '112231@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(255, 'djaknfkals', '123456', '123412412@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(256, 'daijiazuo', '123456', '1666412919@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(257, 'antus', '123456..', '1812509333@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(258, 'gmm', 'gmm328991', 'mm15824930874@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(259, 'ggboy', 'liyuan', '1980303503@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(260, 'xyz', '123456', 'a@a.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(261, 'jechew', '123456', 'dddd@qqq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(262, 'wsadwsad', 'wsadwsad', '1486003303@qq.com', NULL, 1, NULL, '/public/images/avatar/default_avatar.jpg'),
(263, 'a398983914', '521652z', '398983914@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(264, 'test8544', '123456', '710938705@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(265, 'yanjh', '111111', '13213@qq.cc', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(267, '1286089919', '123456', '1286089919@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(268, 'dhj', '123123', '956968770@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(269, '123hhh', '123456', '123@icloud.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(270, 'zhao', '371312', '2629039199@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(271, 'adssd', '123456', '1443824033@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(272, '自由美利坚枪战每一天', '123456', 'yangyuxinaa@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(273, 'nono', '991007', '2375168048@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(274, 'madao', 'nw1231', 'nwjump@163.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(275, '1112', '111111', '116966261@qq.com', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg'),
(276, 'OhtoAi', '512906409', 'ohtoai@thatboy.info', NULL, NULL, NULL, '/public/images/avatar/default_avatar.jpg');

--
-- 转储表的索引
--

--
-- 表的索引 `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `commentwj` (`uid`) USING BTREE;

--
-- 表的索引 `dynamic`
--
ALTER TABLE `dynamic`
  ADD PRIMARY KEY (`mid`) USING BTREE,
  ADD KEY `wj` (`uid`) USING BTREE;

--
-- 表的索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '这条子评论的id', AUTO_INCREMENT=44;

--
-- 使用表AUTO_INCREMENT `dynamic`
--
ALTER TABLE `dynamic`
  MODIFY `mid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- 使用表AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=277;

--
-- 限制导出的表
--

--
-- 限制表 `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `commentwj` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `dynamic`
--
ALTER TABLE `dynamic`
  ADD CONSTRAINT `wj` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
