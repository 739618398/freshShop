/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50520
 Source Host           : localhost:3306
 Source Schema         : market

 Target Server Type    : MySQL
 Target Server Version : 50520
 File Encoding         : 65001

 Date: 10/08/2020 19:18:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `loginPass` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userName` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `gender` varchar(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '1234', '张三', '男', '19850025698', '江苏南通');
INSERT INTO `admin` VALUES (2, '739618398', '1234', '老王', '女', '13048746816', '湖北武汉');
INSERT INTO `admin` VALUES (3, '2811391145', '1234', '老周', '男', '18798869213', '贵州遵义');

-- ----------------------------
-- Table structure for commentinfo
-- ----------------------------
DROP TABLE IF EXISTS `commentinfo`;
CREATE TABLE `commentinfo`  (
  `com_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '留言ID',
  `foodID` int(20) UNSIGNED NOT NULL COMMENT '生鲜编号',
  `orderID` int(10) UNSIGNED NOT NULL COMMENT '订单ID',
  `userName` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `com_context` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '评价内容',
  `com_data` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '评价日期',
  `com_fooaQua` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '商品质量',
  `com_delivery` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '配送服务',
  `com_serveQua` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '卖家服务',
  `admin_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '管理员姓名',
  `admin_Reply` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '管理员回复',
  PRIMARY KEY (`com_id`) USING BTREE,
  INDEX `userName`(`userName`) USING BTREE,
  INDEX `foodID`(`foodID`) USING BTREE,
  INDEX `commentinfo_ibfk_4`(`orderID`) USING BTREE,
  CONSTRAINT `commentinfo_ibfk_3` FOREIGN KEY (`foodID`) REFERENCES `foodinfo` (`foodID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commentinfo_ibfk_4` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '生鲜编号' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of commentinfo
-- ----------------------------
INSERT INTO `commentinfo` VALUES (10, 2, 1, '张三', '还不错，就是物流太垃圾。', '2020-06-20 18:18:50', '非常满意', '很不满意', '非常满意', NULL, NULL);
INSERT INTO `commentinfo` VALUES (11, 5, 2, '张三', '太好吃了！', '2020-06-20 18:53:47', '非常满意', '非常满意', '非常满意', NULL, NULL);

-- ----------------------------
-- Table structure for foodcart
-- ----------------------------
DROP TABLE IF EXISTS `foodcart`;
CREATE TABLE `foodcart`  (
  `foodID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '购物车商品ID',
  `foodImage` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生鲜图片',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生鲜描述',
  `foodPrice` double(18, 1) NULL DEFAULT NULL COMMENT '生鲜价格',
  `foodCarNum` int(10) NOT NULL COMMENT '添加数量',
  `foodCount` int(50) NULL DEFAULT NULL COMMENT '库存数量',
  PRIMARY KEY (`foodID`) USING BTREE,
  INDEX `description`(`description`) USING BTREE,
  INDEX `foodPrice`(`foodPrice`) USING BTREE,
  INDEX `foodCount`(`foodCount`) USING BTREE,
  INDEX `foodImage`(`foodImage`) USING BTREE,
  CONSTRAINT `foodcart_ibfk_1` FOREIGN KEY (`foodID`) REFERENCES `foodinfo` (`foodID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `foodcart_ibfk_2` FOREIGN KEY (`foodImage`) REFERENCES `foodinfo` (`foodImage`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `foodcart_ibfk_3` FOREIGN KEY (`description`) REFERENCES `foodinfo` (`description`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `foodcart_ibfk_4` FOREIGN KEY (`foodPrice`) REFERENCES `foodinfo` (`foodPrice`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `foodcart_ibfk_5` FOREIGN KEY (`foodCount`) REFERENCES `foodinfo` (`foodCount`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of foodcart
-- ----------------------------
INSERT INTO `foodcart` VALUES (23, 'foodimg/023.png', '暖男厨房澳洲进口原肉 整切牛排生鲜 眼肉儿童牛排组合10片套装1300g（送刀叉+黄油+黑椒酱）', 139.0, 1, 560);

-- ----------------------------
-- Table structure for foodinfo
-- ----------------------------
DROP TABLE IF EXISTS `foodinfo`;
CREATE TABLE `foodinfo`  (
  `foodID` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '生鲜编号',
  `foodName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生鲜名称',
  `sortId` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '生鲜种类ID',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生鲜简介',
  `foodAddr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发货地',
  `foodPrice` double(18, 2) NOT NULL COMMENT '生鲜价格',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生鲜描述',
  `foodImage` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生鲜图片',
  `foodCount` int(50) NOT NULL COMMENT '库存',
  PRIMARY KEY (`foodID`) USING BTREE,
  INDEX `description`(`description`) USING BTREE,
  INDEX `foodPrice`(`foodPrice`) USING BTREE,
  INDEX `foodCount`(`foodCount`) USING BTREE,
  INDEX `foodImage`(`foodImage`) USING BTREE,
  INDEX `foodName`(`foodName`) USING BTREE,
  INDEX `foodinfo_ibfk_1`(`sortId`) USING BTREE,
  CONSTRAINT `foodinfo_ibfk_1` FOREIGN KEY (`sortId`) REFERENCES `foodssort` (`sortId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of foodinfo
-- ----------------------------
INSERT INTO `foodinfo` VALUES (1, '泰国金枕榴莲', 2, '香甜软糯，营养丰富，榴莲控的福音', '佛山市', 99.80, '泰国金枕榴莲新鲜水果热带水果香甜软糯3-4斤装', 'foodimg/001.jpg', 99);
INSERT INTO `foodinfo` VALUES (2, '大希地整切牛排', 4, '肉质醇厚 全家爱吃 正规检疫 安全放心', '绍兴市', 199.40, '大希地 整切家庭牛排套餐 120g*10片 （西冷*5片+眼肉*5片）赠刀叉+酱包+小煎锅 原肉整切 手工轻腌', 'foodimg/002.jpg', 232);
INSERT INTO `foodinfo` VALUES (3, '5斤装春见耙耙柑', 2, '产地直发 汁多饱满', '成都市', 41.00, '鲜菓篮 新鲜现摘春见耙耙柑 5斤装精选果 果园直发 现摘现发 生鲜水果', 'foodimg/004.png', 1313);
INSERT INTO `foodinfo` VALUES (4, '大希地黑椒牛排', 4, '开心就好黑椒牛排', '绍兴市', 153.50, '大希地 开心就好黑椒牛排130g*12袋 精致调理牛排 赠便携小煎锅刀叉酱包', 'foodimg/003.jpg', 330);
INSERT INTO `foodinfo` VALUES (5, '陕西绿心猕猴桃', 2, '酸甜多汁 果肉肥厚', '南通市', 29.90, '鲜菓篮 陕西绿心奇异果 精选特大果24枚装单果110-150g 绿心猕猴桃 新鲜水果', 'foodimg/005.jpg', 340);
INSERT INTO `foodinfo` VALUES (6, '10斤装春见耙耙柑', 2, '果粒饱满多汁 甜蜜爆炸', '遵义市', 60.00, '鲜菓篮 新鲜现摘春见耙耙柑 带箱10斤装大果 果园直发 现摘现发 生鲜水果', 'foodimg/006.jpg', 130);
INSERT INTO `foodinfo` VALUES (7, '现摘水果丑柑', 2, '果味浓郁 肉质细腻饱满', '广州市', 46.80, '鲜菓篮 新鲜现摘水果丑柑不知火 带箱10斤装大果 橘子 自营水果生鲜', 'foodimg/007.png', 230);
INSERT INTO `foodinfo` VALUES (8, '越南芒果', 2, '鲜果直发', '成都市', 38.80, '鲜菓篮 芒果新鲜水果 进口玉芒带箱10斤装优选精品果 鲜果直发 热带水果 新鲜青芒 苏宁生鲜', 'foodimg/008.png', 440);
INSERT INTO `foodinfo` VALUES (9, '泰国龙眼4斤', 2, '鲜嫩甘甜', '郑州市', 32.80, '悠乐果 泰国龙眼4斤 果径20mm左右 新鲜桂圆应季热带水果 甘甜多汁', 'foodimg/009.png', 110);
INSERT INTO `foodinfo` VALUES (10, '越南红心火龙果', 2, '越南进口红心火龙果', '聊城市', 29.90, '越南红心火龙果红心新鲜水果4个装单果300-450克 果肉细腻，清甜可口，富含花青素等多种营养元素', 'foodimg/010.jpg', 330);
INSERT INTO `foodinfo` VALUES (11, '福建新鲜圣女果', 2, '产地直发', '上海市', 29.00, '福建新鲜圣女果 小番茄 小西红柿 新鲜水果 2.5斤装 2单合发1件5斤装 偶数件发货 奥奇健', 'foodimg/011.jpg', 130);
INSERT INTO `foodinfo` VALUES (12, '海南菠萝蜜', 2, '收到后先进行生熟判断，千万不要生切！不熟需要催熟的哦', '成都市', 86.90, '海南菠萝蜜 新鲜水果 香甜可口 1个 净重18-22斤装', 'foodimg/012.png', 440);
INSERT INTO `foodinfo` VALUES (13, '烟台红富士', 2, '烟台原产地，品质保证，个大皮薄，脆甜多汁', '济南市', 32.90, '烟台栖霞红富士苹果 精品大果 净重5斤装 果径80-85mm 个大皮薄 脆甜多汁 不打蜡 新鲜水果 淘四季生鲜', 'foodimg/013.png', 140);
INSERT INTO `foodinfo` VALUES (14, '澳洲星利金鲳鱼', 3, '肉厚刺少 肉质鲜嫩', '连云港市', 49.80, '【买2条送1条】澳洲星利（SUNNY ESTATE）金鲳鱼300g/400g 条装苏宁海鲜水产黄金海鲜出口鱼\r\n肉厚刺少 肉质鲜嫩 【上新尝鲜】【买2条送1条】 深海金鲳鱼 超半斤一条 ', 'foodimg/014.png', 520);
INSERT INTO `foodinfo` VALUES (15, '澳洲星利汉虾', 3, '满满虾青素和蛋白 低温活冻 虾肉光泽亮眼', '连云港市', 39.80, '澳洲星利（SUNNY ESTATE）星利汉虾 火锅虾海鲜新鲜冷冻水煮汉虾开背蝴蝶开背凤尾汉虾200g盒装 海鲜水产 虾仁', 'foodimg/015.png', 0);
INSERT INTO `foodinfo` VALUES (16, '冻巴沙鱼片', 3, '肉厚刺少 肉质鲜嫩', '绍兴市', 129.00, '大希地 冻巴沙鱼片2.5kg/包（肉净重2kg） 原产越南 去骨去刺 厚切鱼柳 整块海鱼酸菜鱼水煮鱼', 'foodimg/016.png', 560);
INSERT INTO `foodinfo` VALUES (17, '澳洲星利活剥虾仁', 3, '鲜活捕捞 零下55°C急冻 锁住鲜嫩滋味 虾肉光泽亮眼', '连云港市', 48.80, '澳洲星利（SUNNY ESTATE）星利活剥南美虾仁冷冻新鲜水晶大虾仁批发生虾仁南美白对虾800g', 'foodimg/017.png', 0);
INSERT INTO `foodinfo` VALUES (18, '乌拉圭牛尾', 4, '乌拉圭带骨牛尾肉', '佛山市', 47.90, '品珍鲜活 乌拉圭牛尾 500g/盒 乌拉圭原切牛尾肉丰富胶原蛋白肥瘦均匀牛尾巴煲汤牛尾骨', 'foodimg/018.jpg', 230);
INSERT INTO `foodinfo` VALUES (19, '5斤装进口冰虾', 4, '纯野生原装进口北极虾', '大连市', 79.90, '【5斤装高品质北极熊北极虾】 进口冰虾 300-400只 原装海鲜冰虾水产北极腹籽野生甜虾生鲜(净重2000g)', 'foodimg/019.jpg', 500);
INSERT INTO `foodinfo` VALUES (20, '澳洲谷饲牛腱子粒', 4, '澳大利亚谷饲牛肉', '佛山市', 125.00, '【第2件19.8元】【0差评牛腱子粒】品珍鲜活 澳洲谷饲100天牛腱子粒300g 澳大利亚牛肉粒牛腱子肉谷饲牛肉', 'foodimg/020.jpg', 900);
INSERT INTO `foodinfo` VALUES (21, '活冻厄瓜多尔白虾', 3, '壳薄肉厚，紧致鲜美，活虾急冻', '湛江市', 128.80, '千渔旺 活冻厄瓜多尔白虾 1.4kg/盒 80-90只 盒装 原装进口 海鲜水产', 'foodimg/021.jpg', 500);
INSERT INTO `foodinfo` VALUES (22, '牛肉生鲜肥牛片', 4, '精选肉源，原切肥牛', '广州市', 89.00, '暖男厨房新鲜肥牛片火锅食材原切牛肉片肥牛卷 烧烤肥牛片牛肉生鲜4包装 200g/包 冷冻食品礼盒原切肥牛片200g*4', 'foodimg/022.jpg', 300);
INSERT INTO `foodinfo` VALUES (23, ' 澳洲进口原肉整切牛排', 4, '10片整切眼肉，精选肉源，澳洲进口', '广州市 ', 139.00, '暖男厨房澳洲进口原肉 整切牛排生鲜 眼肉儿童牛排组合10片套装1300g（送刀叉+黄油+黑椒酱）', 'foodimg/023.png', 560);
INSERT INTO `foodinfo` VALUES (24, '潮汕手打肉类丸', 4, '手工制作，精选肉源，肉含量92%以上', ' 广州市', 79.00, '暖男厨房 潮汕潮州牛肉丸牛筋丸火锅食材套餐火锅丸子牛肉丸潮汕手打肉类丸火锅丸料 生鲜 6包装丸子套餐750g', 'foodimg/024.png', 265);
INSERT INTO `foodinfo` VALUES (25, '牛腱子牛展肉', 4, '澳洲进口 原切牛肉', '连云港市 ', 219.00, '澳洲星利（SUNNY ESTATE）牛腱子牛展1000g*2袋 袋装 澳洲进口 生鲜食品4斤', 'foodimg/025.jpg', 650);

-- ----------------------------
-- Table structure for foodssort
-- ----------------------------
DROP TABLE IF EXISTS `foodssort`;
CREATE TABLE `foodssort`  (
  `sortId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sortName` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`sortId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of foodssort
-- ----------------------------
INSERT INTO `foodssort` VALUES (1, '冷饮冻食');
INSERT INTO `foodssort` VALUES (2, '新鲜水果');
INSERT INTO `foodssort` VALUES (3, '海鲜水产');
INSERT INTO `foodssort` VALUES (4, '精选肉类');
INSERT INTO `foodssort` VALUES (5, '蔬菜蛋品');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `newsId` int(11) NOT NULL,
  `newsTitle` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `newsContent` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `newsDate` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`newsId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, '注意事项', '请登录后再购物!', '2020-05-07 13:19:27');
INSERT INTO `news` VALUES (2, '公告', '6.18年中大促，即将来袭!', '2020-05-07 13:20:25');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `orderID` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `orderNumber` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '订单号',
  `userID` int(10) NOT NULL COMMENT '用户ID',
  `shipStatus` int(10) NOT NULL DEFAULT 0 COMMENT '发货状态',
  `addressID` int(10) NOT NULL COMMENT '地址ID',
  `orderDate` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '订单日期',
  `foodID` int(10) NOT NULL COMMENT '商品ID',
  `foodImage` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '商品图片',
  `foodsName` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '商品名称',
  `foodsPrice` double(10, 2) NOT NULL COMMENT '商品价格',
  `foodsCount` int(10) NOT NULL COMMENT '商品数量',
  `consignee` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '收货人',
  `orderStatus` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '订单状态',
  `comment` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否评论',
  PRIMARY KEY (`orderID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '2020614153842490', 1, 0, 2, '2020-06-14 15:39:56', 2, 'foodimg/002.jpg', '大希地整切牛排', 199.40, 1, '谭大哥', '交易成功', 1);
INSERT INTO `orders` VALUES (2, '2020614153842490', 1, 0, 2, '2020-06-14 15:39:56', 5, 'foodimg/005.jpg', '陕西绿心猕猴桃', 29.90, 1, '谭大哥', '交易成功', 1);
INSERT INTO `orders` VALUES (36, '2020617185912422', 1, 0, 2, '2020-06-17 18:59:43', 3, 'foodimg/004.png', '5斤装春见耙耙柑', 41.00, 1, '谭大哥', '交易成功', 0);
INSERT INTO `orders` VALUES (37, '2020617185912422', 1, 0, 2, '2020-06-17 18:59:43', 13, 'foodimg/013.png', '烟台红富士', 32.90, 1, '谭大哥', '交易成功', 0);

-- ----------------------------
-- Table structure for receive
-- ----------------------------
DROP TABLE IF EXISTS `receive`;
CREATE TABLE `receive`  (
  `address_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '姓名',
  `address` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '地址',
  `postalcode` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '邮编',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '电话',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱',
  `addralias` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '地址类别',
  `status` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否默认地址',
  PRIMARY KEY (`address_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of receive
-- ----------------------------
INSERT INTO `receive` VALUES (1, 1, '张三', '江苏省南通市港闸区南通理工学院', '000000', '19850025698', '739618398@qq.com', '家里', 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `userName` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户姓名',
  `gender` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `userEmail` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `userZt` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户状态',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `userName`(`userName`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '739618398', '123456', '张三', '男', '739618398@qq.com', '19850025698', '贵州遵义', 0);
INSERT INTO `user` VALUES (2, '267848838', '15674', '王振', '男', '123456@qq.com', '13678905438', '湖北武汉', 1);
INSERT INTO `user` VALUES (3, '123456789', '17657', '周景', '女', '456789@qq.com', '13704117656', '江苏南通', 0);
INSERT INTO `user` VALUES (9, '2678488383', '123456', '张三', '男', '2678488383@gmail.com', '19850021790', '通州', 0);

SET FOREIGN_KEY_CHECKS = 1;
