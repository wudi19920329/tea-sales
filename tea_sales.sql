/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50625
Source Host           : localhost:3306
Source Database       : tea_sales

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2018-03-30 18:03:36
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
  `email` varchar(30) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_customer
-- ----------------------------
INSERT INTO `t_customer` VALUES ('23', '吴棣', '地瓜', '13213140079', '北京市/北京市/东城区', '381828438@qq.com', '9db06bcff9248837f86d1a6bcf41c9e7');
INSERT INTO `t_customer` VALUES ('24', '牛占元', '牛牛', '13213140077', '安徽省/合肥市/瑶海区', 'john@test.com', '9db06bcff9248837f86d1a6bcf41c9e7');

-- ----------------------------
-- Table structure for `t_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `payableAmount` decimal(20,2) NOT NULL,
  `shopping_cart_id` int(11) NOT NULL,
  `order_status` varchar(20) COLLATE utf8_bin NOT NULL,
  `express_delivery_mode` varchar(20) COLLATE utf8_bin NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_order
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', 'static/goods_img/1.jpg', 'GREEN_TEA', 'YINGSHAN_CLOUD_TEA', '10000', 'SMALL', '500.15', null, 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('21', 'static/goods_img/1.jpg', 'BLACK_TEA', 'QIINEN_BLACK_TEA', '10000', 'SMALL', '500.15', '', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('22', 'static/goods_img/1.jpg', 'DARK_GREEN_TEA', 'THREE_POINT', '10000', 'SMALL', '500.15', '', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('23', 'static/goods_img/1.jpg', 'OOLONG_TEA', 'ANXI_TIEGUANYIN', '10000', 'SMALL', '500.15', '', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');
INSERT INTO `t_product` VALUES ('24', 'static/goods_img/1.jpg', 'YELLOW_TEA', 'HIPPOCAMPAL_PALACE_TEA', '10000', 'SMALL', '500.15', '', 'FAYE_FLY', '2018-03-28 17:08:48', '500.03', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_shopping_cart
-- ----------------------------
INSERT INTO `t_shopping_cart` VALUES ('1', '23', '2018-03-29 15:48:40', '2018-03-29 15:48:40');
INSERT INTO `t_shopping_cart` VALUES ('2', '24', '2018-03-30 16:26:36', '2018-03-30 16:26:36');

-- ----------------------------
-- Table structure for `t_shopping_cart_item`
-- ----------------------------
DROP TABLE IF EXISTS `t_shopping_cart_item`;
CREATE TABLE `t_shopping_cart_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `product_id` int(11) NOT NULL COMMENT '商品id',
  `shopping_cart_id` int(11) NOT NULL COMMENT '购物车id',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shopping_cart_item
-- ----------------------------
INSERT INTO `t_shopping_cart_item` VALUES ('11', '1', '1', '2', '2018-03-30 17:42:52', '2018-03-30 17:43:43');
INSERT INTO `t_shopping_cart_item` VALUES ('12', '21', '1', '2', '2018-03-30 17:42:57', '2018-03-30 17:43:43');
DROP TRIGGER IF EXISTS `update_goods_status`;
DELIMITER ;;
CREATE TRIGGER `update_goods_status` AFTER INSERT ON `t_order` FOR EACH ROW begin
set @buyerid=new.user_id;
set @buyername=(select name from user where id=@buyerid);
set @sellerid = (select producter_id from goods where id=new.goods_id);
set @goodsid = (select id from goods where id=new.goods_id);
set @goodsname = (select name from goods where id=new.goods_id);
set @sellername = (select name from `user` where id=@sellerid);
INSERT INTO `message`(mess_from_id,mess_to_id,mess_text,send_time) VALUES (1,@sellerid,CONCAT("你的商品","<a target='_blank' href='goods/info.jsp?goodsid=",@goodsid,"'>",@goodsname,"</a>","被购买，请尽快联系买家","<a target='_blank' href='user/personal.jsp?tab=info&userid=",@buyerid,"'>",@buyername,"</a>","，以下为买家的附加信息（可能为空）
==============
",new.message),new.date);
update goods set status=4 where id=new.goods_id;
end
;;
DELIMITER ;
