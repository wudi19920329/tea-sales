/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50625
Source Host           : localhost:3306
Source Database       : tea_sales

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2018-03-28 18:35:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `collect`
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `user_id` int(11) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of collect
-- ----------------------------

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `mess_from_id` int(11) NOT NULL,
  `mess_to_id` int(11) NOT NULL,
  `mess_text` varchar(255) COLLATE utf8_bin NOT NULL,
  `send_time` datetime NOT NULL,
  `mess_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mess_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`mess_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '1', '你的商品 <a target=\'_blank\' href=\'goods/info.jsp?goodsid=20\'>铁观音</a>已经审核通过', '2018-03-21 17:48:49', '31', null);

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `message` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for `shoppingcart`
-- ----------------------------
DROP TABLE IF EXISTS `shoppingcart`;
CREATE TABLE `shoppingcart` (
  `id` int(11) NOT NULL,
  `goodsId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of shoppingcart
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
  `create_date` datetime NOT NULL,
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
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `real_name` varchar(20) COLLATE utf8_bin NOT NULL,
  `nick_name` varchar(20) COLLATE utf8_bin NOT NULL,
  `phone` varchar(20) COLLATE utf8_bin NOT NULL,
  `address` varchar(255) COLLATE utf8_bin NOT NULL,
  `email` varchar(30) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('22', '吴棣', '大地', '13213140079', '安徽省/芜湖市/镜湖区', '381828438@qq.com', '9db06bcff9248837f86d1a6bcf41c9e7');
DROP TRIGGER IF EXISTS `change_user_mess_num`;
DELIMITER ;;
CREATE TRIGGER `change_user_mess_num` AFTER INSERT ON `message` FOR EACH ROW update user set mess_num=mess_num+1 where id=new.mess_to_id
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `update_goods_status`;
DELIMITER ;;
CREATE TRIGGER `update_goods_status` AFTER INSERT ON `order` FOR EACH ROW begin
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
