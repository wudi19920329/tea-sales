/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50544
Source Host           : localhost:3306
Source Database       : tea_sales

Target Server Type    : MYSQL
Target Server Version : 50544
File Encoding         : 65001

Date: 2018-04-01 21:37:00
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_customer
-- ----------------------------
INSERT INTO `t_customer` VALUES ('23', '吴棣', '地瓜', '13213140079', '北京市/北京市/东城区', '450000', '381828438@qq.com', '9db06bcff9248837f86d1a6bcf41c9e7');
INSERT INTO `t_customer` VALUES ('24', '牛占元', '牛牛', '13213140077', '安徽省/合肥市/瑶海区', '450000', 'john@test.com', '9db06bcff9248837f86d1a6bcf41c9e7');
INSERT INTO `t_customer` VALUES ('25', 'a', 'a', '13213140079', '安徽省/芜湖市/镜湖区', '450000', '3818284318@qq.com', '9db06bcff9248837f86d1a6bcf41c9e7');
INSERT INTO `t_customer` VALUES ('26', '牛占元', '占元', '13213140088', '河南省/郑州市/中原区', '450000', '381828433@qq.com', '9db06bcff9248837f86d1a6bcf41c9e7');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('5', 'TEA_ORDER_23_2018-04-01 18:37:12', '23', '1008.30', '1', 'WAIT_FOR_DELIVERY', 'YTO_EXPRESS', 'a', '2018-04-01 18:37:12', '2018-04-01 18:37:12');
INSERT INTO `t_order` VALUES ('6', 'TEA_ORDER_23_2018-04-01 18:39:11', '23', '508.15', '1', 'WAIT_FOR_DELIVERY', 'YTO_EXPRESS', '', '2018-04-01 18:39:11', '2018-04-01 18:39:11');
INSERT INTO `t_order` VALUES ('7', 'TEA_ORDER_23_2018-04-01 21:30:43', '23', '2514.75', '1', 'WAIT_FOR_DELIVERY', 'SF_EXPRESS', '不要发票', '2018-04-01 21:30:43', '2018-04-01 21:30:43');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `image` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '图片地址',
  `category` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '分类',
  `varieties` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '品种',
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
INSERT INTO `t_product` VALUES ('1', 'static/goods_img/YINGSHAN_CLOUD_TEA.jpg', 'GREEN_TEA', 'YINGSHAN_CLOUD_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('2', 'static/goods_img/THE_WEST_LAKE_LONGJING.jpg', 'GREEN_TEA', 'THE_WEST_LAKE_LONGJING', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-04-01 14:53:45', '500.02', '');
INSERT INTO `t_product` VALUES ('3', 'static/goods_img/EMEI_SNOW_BUD.jpg', 'GREEN_TEA', 'EMEI_SNOW_BUD', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('4', 'static/goods_img/MEPHENTERMINE_TEA.jpg', 'GREEN_TEA', 'MEPHENTERMINE_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('5', 'static/goods_img/MAE_TAM_GREEN_BUD.jpg', 'GREEN_TEA', 'MAE_TAM_GREEN_BUD', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('6', 'static/goods_img/LANXIN_SPARROW_TONGUE.jpg', 'GREEN_TEA', 'LANXIN_SPARROW_TONGUE', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('7', 'static/goods_img/BLACK_BRICK.jpg', 'DARK_GREEN_TEA', 'BLACK_BRICK', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('8', 'static/goods_img/EIGHT_BRICK.jpg', 'DARK_GREEN_TEA', 'EIGHT_BRICK', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('9', 'static/goods_img/GREEN_TEA.jpg', 'DARK_GREEN_TEA', 'GREEN_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('10', 'static/goods_img/THREE_POINT.jpg', 'DARK_GREEN_TEA', 'THREE_POINT', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('11', 'static/goods_img/TILE.jpg', 'DARK_GREEN_TEA', 'TILE', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('12', 'static/goods_img/ASSAM_BLACK_TEA.jpg', 'BLACK_TEA', 'ASSAM_BLACK_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('13', 'static/goods_img/DARJEELING_TEA.jpg', 'BLACK_TEA', 'DARJEELING_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('14', 'static/goods_img/QIINEN_BLACK_TEA.jpg', 'BLACK_TEA', 'QIINEN_BLACK_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('15', 'static/goods_img/UZBEKISTAN_SRI_LANKA.jpg', 'BLACK_TEA', 'UZBEKISTAN_SRI_LANKA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('16', 'static/goods_img/HIPPOCAMPAL_PALACE_TEA.jpg', 'YELLOW_TEA', 'HIPPOCAMPAL_PALACE_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('17', 'static/goods_img/HUOSHAN_YELLOW_FLOWER_TEA.jpg', 'YELLOW_TEA', 'HUOSHAN_YELLOW_FLOWER_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('18', 'static/goods_img/JUNSHAN_ISLAND_SILVER_NEEDLE_TEA.jpg', 'YELLOW_TEA', 'JUNSHAN_ISLAND_SILVER_NEEDLE_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('19', 'static/goods_img/LU_DING_TEA.jpg', 'YELLOW_TEA', 'LU_DING_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('20', 'static/goods_img/YUANAN_YELLOW_TEA.jpg', 'YELLOW_TEA', 'YUANAN_YELLOW_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('21', 'static/goods_img/ANXI_TIEGUANYIN.jpg', 'OOLONG_TEA', 'ANXI_TIEGUANYIN', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('22', 'static/goods_img/LOHAN_ALOES.jpg', 'OOLONG_TEA', 'LOHAN_ALOES', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('23', 'static/goods_img/ORIENTAL_BEAUTY.jpg', 'OOLONG_TEA', 'ORIENTAL_BEAUTY', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('24', 'static/goods_img/PHOENIX_NARCISSUS.jpg', 'OOLONG_TEA', 'PHOENIX_NARCISSUS', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('25', 'static/goods_img/RED_WATER_OOLONG.jpg', 'OOLONG_TEA', 'RED_WATER_OOLONG', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');

-- ----------------------------
-- Table structure for `t_shopping_cart`
-- ----------------------------
DROP TABLE IF EXISTS `t_shopping_cart`;
CREATE TABLE `t_shopping_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer_id` int(11) NOT NULL COMMENT '客户id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_shopping_cart
-- ----------------------------
INSERT INTO `t_shopping_cart` VALUES ('1', '23', '2018-03-29 15:48:40', '2018-03-29 15:48:40');
INSERT INTO `t_shopping_cart` VALUES ('2', '24', '2018-03-30 16:26:36', '2018-03-30 16:26:36');
INSERT INTO `t_shopping_cart` VALUES ('3', '25', '2018-04-01 20:39:21', '2018-04-01 20:39:21');
INSERT INTO `t_shopping_cart` VALUES ('4', '26', '2018-04-01 21:27:24', '2018-04-01 21:27:24');

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shopping_cart_item
-- ----------------------------
INSERT INTO `t_shopping_cart_item` VALUES ('19', '2', '1', '2', 'PAYMENT_HAS_BEEN', '2018-04-01 18:37:00', '2018-04-01 21:28:20');
INSERT INTO `t_shopping_cart_item` VALUES ('20', '4', '1', '1', 'PAYMENT_HAS_BEEN', '2018-04-01 18:37:02', '2018-04-01 18:37:12');
INSERT INTO `t_shopping_cart_item` VALUES ('21', '6', '1', '1', 'PAYMENT_HAS_BEEN', '2018-04-01 18:39:03', '2018-04-01 18:39:11');
INSERT INTO `t_shopping_cart_item` VALUES ('22', '1', '1', '3', 'PAYMENT_HAS_BEEN', '2018-04-01 21:28:18', '2018-04-01 21:30:43');
INSERT INTO `t_shopping_cart_item` VALUES ('23', '12', '1', '1', 'PAYMENT_HAS_BEEN', '2018-04-01 21:28:25', '2018-04-01 21:30:43');
INSERT INTO `t_shopping_cart_item` VALUES ('24', '13', '1', '1', 'PAYMENT_HAS_BEEN', '2018-04-01 21:28:26', '2018-04-01 21:30:43');
