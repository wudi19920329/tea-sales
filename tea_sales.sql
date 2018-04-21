/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : tea_sales

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2018-04-21 20:51:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_customer`
-- ----------------------------
DROP TABLE IF EXISTS `t_customer`;
CREATE TABLE `t_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `real_name` varchar(20) COLLATE utf8_bin NOT NULL,
  `nick_name` varchar(20) COLLATE utf8_bin NOT NULL,
  `phone` varchar(20) COLLATE utf8_bin NOT NULL,
  `address` varchar(255) COLLATE utf8_bin NOT NULL,
  `postcode` int(11) NOT NULL,
  `email` varchar(30) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_customer
-- ----------------------------
INSERT INTO `t_customer` VALUES ('27', '大地', '地瓜', '13213140079', '安徽省/合肥市/瑶海区', '450000', '381828438@qq.com', '9db06bcff9248837f86d1a6bcf41c9e7');

-- ----------------------------
-- Table structure for `t_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(100) COLLATE utf8_bin NOT NULL,
  `customer_id` int(11) NOT NULL,
  `payable_amount` decimal(20,2) NOT NULL,
  `shopping_cart_id` int(11) NOT NULL,
  `order_status` varchar(50) COLLATE utf8_bin NOT NULL,
  `express_delivery_mode` varchar(20) COLLATE utf8_bin NOT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('21', 'TEA_ORDER_27_2018-04-21 20:31:55', '27', '1008.04', '16', 'DELIVERED', 'YTO_EXPRESS', '213123', '2018-04-21 20:31:56', '2018-04-21 20:41:25');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `image` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '图片地址',
  `category` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '分类',
  `inventory` bigint(11) NOT NULL COMMENT '数量',
  `specification` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '规格',
  `price` decimal(20,2) NOT NULL COMMENT '原始价格',
  `content` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `status` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '商品状态',
  `create_time` datetime NOT NULL,
  `discount_price` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '折后价格',
  `discounted` bit(1) NOT NULL COMMENT '是否打折',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '英山云雾茶', '/upload/product_images/YINGSHAN_CLOUD_TEA.jpg', 'GREEN_TEA', '999999', 'SMALL', '500.15', '213213', 'FAYE_FLY', '2018-03-28 17:08:48', '0.00', '');
INSERT INTO `t_product` VALUES ('2', '西湖龙井', '/upload/product_images/THE_WEST_LAKE_LONGJING.jpg', 'GREEN_TEA', '999999', 'SMALL', '500.15', '好喝！！！', 'FAYE_FLY', '2018-04-01 14:53:45', '0.00', '');
INSERT INTO `t_product` VALUES ('3', '峨眉雪芽', '/upload/product_images/EMEI_SNOW_BUD.jpg', 'GREEN_TEA', '999999', 'SMALL', '500.15', '213213', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('4', '惠明茶', '/upload/product_images/MEPHENTERMINE_TEA.jpg', 'GREEN_TEA', '999999', 'SMALL', '500.15', '213213', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('5', '湄潭翠芽', '/upload/product_images/MAE_TAM_GREEN_BUD.jpg', 'GREEN_TEA', '999999', 'SMALL', '500.15', '213213', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('6', '兰馨雀舌', '/upload/product_images/LANXIN_SPARROW_TONGUE.jpg', 'GREEN_TEA', '999999', 'SMALL', '500.15', '213213', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('7', '黑砖', '/upload/product_images/BLACK_BRICK.jpg', 'DARK_GREEN_TEA', '999999', 'SMALL', '500.15', '213213', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('8', '茯砖', '/upload/product_images/EIGHT_BRICK.jpg', 'DARK_GREEN_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('9', '青砖茶', '/upload/product_images/GREEN_TEA.jpg', 'DARK_GREEN_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('10', '三尖', '/upload/product_images/THREE_POINT.jpg', 'DARK_GREEN_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('11', '花砖', '/upload/product_images/TILE.jpg', 'DARK_GREEN_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('12', '阿萨姆红茶', '/upload/product_images/ASSAM_BLACK_TEA.jpg', 'BLACK_TEA', '999999', 'SMALL', '500.15', '123123213', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('13', '大吉岭红茶', '/upload/product_images/DARJEELING_TEA.jpg', 'BLACK_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('14', '祁门红茶', '/upload/product_images/QIINEN_BLACK_TEA.jpg', 'BLACK_TEA', '999999', 'SMALL', '500.15', '213213', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('15', '乌巴-斯里兰卡', '/upload/product_images/UZBEKISTAN_SRI_LANKA.jpg', 'BLACK_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('16', '海马宫茶', '/upload/product_images/HIPPOCAMPAL_PALACE_TEA.jpg', 'YELLOW_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('17', '霍山黄芽茶', '/upload/product_images/HUOSHAN_YELLOW_FLOWER_TEA.jpg', 'YELLOW_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('18', '君山银针茶', '/upload/product_images/JUNSHAN_ISLAND_SILVER_NEEDLE_TEA.jpg', 'YELLOW_TEA', '999999', 'SMALL', '500.15', '213213', 'TO_SELL', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('19', '路丁茶', '/upload/product_images/LU_DING_TEA.jpg', 'YELLOW_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('20', '远安黄茶', '/upload/product_images/YUANAN_YELLOW_TEA.jpg', 'YELLOW_TEA', '999999', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('21', '安溪铁观音', '/upload/product_images/ANXI_TIEGUANYIN.jpg', 'OOLONG_TEA', '999999', 'SMALL', '500.15', '213213', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('22', '罗汉沉香', '/upload/product_images/LOHAN_ALOES.jpg', 'OOLONG_TEA', '999999', 'SMALL', '500.15', null, 'TO_SELL', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('23', '东方美人', '/upload/product_images/ORIENTAL_BEAUTY.jpg', 'OOLONG_TEA', '999999', 'SMALL', '500.15', null, 'TO_SELL', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('24', '凤凰水仙', '/upload/product_images/PHOENIX_NARCISSUS.jpg', 'OOLONG_TEA', '999999', 'SMALL', '500.15', null, 'TO_SELL', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('25', '红水乌龙', '/upload/product_images/RED_WATER_OOLONG.jpg', 'OOLONG_TEA', '999999', 'SMALL', '500.15', null, 'TO_SELL', '2018-03-28 17:08:48', '500.03', '');

-- ----------------------------
-- Table structure for `t_shopping_cart`
-- ----------------------------
DROP TABLE IF EXISTS `t_shopping_cart`;
CREATE TABLE `t_shopping_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer_id` int(11) NOT NULL COMMENT '客户id',
  `status` varchar(40) COLLATE utf8_bin NOT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_shopping_cart
-- ----------------------------
INSERT INTO `t_shopping_cart` VALUES ('16', '27', 'HAVE_ALREADY_SETTLED', '2018-04-21 00:00:00', '2018-04-21 00:00:00');
INSERT INTO `t_shopping_cart` VALUES ('17', '27', 'NO_SETTLEMENT', '2018-04-21 20:42:36', '2018-04-21 20:42:36');

-- ----------------------------
-- Table structure for `t_shopping_cart_item`
-- ----------------------------
DROP TABLE IF EXISTS `t_shopping_cart_item`;
CREATE TABLE `t_shopping_cart_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `product_id` int(11) NOT NULL COMMENT '商品id',
  `shopping_cart_id` int(11) NOT NULL COMMENT '购物车id',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `status` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shopping_cart_item
-- ----------------------------
INSERT INTO `t_shopping_cart_item` VALUES ('62', '2', '16', '2', 'PAYMENT_HAS_BEEN', '2018-04-21 20:31:36', '2018-04-21 20:31:56');
INSERT INTO `t_shopping_cart_item` VALUES ('63', '2', '17', '1', 'FOR_THE_PAYMENT', '2018-04-21 20:42:36', '2018-04-21 20:42:36');
INSERT INTO `t_shopping_cart_item` VALUES ('64', '3', '17', '1', 'FOR_THE_PAYMENT', '2018-04-21 20:42:41', '2018-04-21 20:42:41');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', 'c3284d0f94606de1fd2af172aba15bf3', 'SUPER_ADMIN', '2018-04-21 12:57:24', '2018-04-21 12:57:28');
