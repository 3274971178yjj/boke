/*
Navicat MySQL Data Transfer

Source Server         : 123
Source Server Version : 80026
Source Host           : localhost:3306
Source Database       : library

Target Server Type    : MYSQL
Target Server Version : 80026
File Encoding         : 65001

Date: 2024-01-07 09:15:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `books`
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `书号` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `书名` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `作者` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `类型` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `价格` float DEFAULT NULL,
  `出版社` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `摘要` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `馆藏册数` int DEFAULT NULL,
  `在馆册数` int DEFAULT NULL,
  `书架号` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `被借次数` int DEFAULT NULL,
  PRIMARY KEY (`书号`) USING BTREE,
  KEY `书架号_idx` (`书架号`) USING BTREE,
  CONSTRAINT `书架号` FOREIGN KEY (`书架号`) REFERENCES `bookshelfs` (`书架号`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES ('001', 'python编程', 'bhml', '计算机技术', '66', '清华大学出版社', 'python、编程', '20', '19', 'C01', '1');
INSERT INTO `books` VALUES ('002', '数据库', '王珊', '计算机技术', '100', '人民出版社', '计算机', '20', '20', 'C01', '0');
INSERT INTO `books` VALUES ('003', '毛泽东选集', '毛泽东', '小说', '0.1', '人民出版社', '战无不胜的毛泽东思想', '20', '19', 'C01', '2');
INSERT INTO `books` VALUES ('004', '操作系统', '谷建华', '计算机技术', '100', '西北工业大学出版社', '计算机', '11', '10', 'C01', '1');

-- ----------------------------
-- Table structure for `bookshelfs`
-- ----------------------------
DROP TABLE IF EXISTS `bookshelfs`;
CREATE TABLE `bookshelfs` (
  `书架号` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `书籍类型` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`书架号`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of bookshelfs
-- ----------------------------
INSERT INTO `bookshelfs` VALUES ('C01', '计算机技术');

-- ----------------------------
-- Table structure for `borrow`
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow` (
  `ID` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `书号` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `借书时间` date NOT NULL,
  PRIMARY KEY (`ID`,`书号`,`借书时间`) USING BTREE,
  KEY `书号_idx` (`书号`) USING BTREE,
  CONSTRAINT `ID` FOREIGN KEY (`ID`) REFERENCES `readers` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `书号` FOREIGN KEY (`书号`) REFERENCES `books` (`书号`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='		';

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES ('2021001', '001', '2023-12-25');
INSERT INTO `borrow` VALUES ('20211002', '001', '2023-12-24');
INSERT INTO `borrow` VALUES ('2021001', '002', '2023-12-24');
INSERT INTO `borrow` VALUES ('2021002', '002', '2023-12-24');
INSERT INTO `borrow` VALUES ('2021001', '003', '2023-12-25');
INSERT INTO `borrow` VALUES ('2021001', '004', '2023-12-25');

-- ----------------------------
-- Table structure for `item`
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `bookid` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ID` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `time` date NOT NULL,
  `type` enum('borrow','return') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`bookid`,`ID`,`time`,`type`) USING BTREE,
  KEY `readerid_idx` (`ID`) USING BTREE,
  CONSTRAINT `bookid` FOREIGN KEY (`bookid`) REFERENCES `books` (`书号`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `readerid` FOREIGN KEY (`ID`) REFERENCES `readers` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of item
-- ----------------------------

-- ----------------------------
-- Table structure for `loginrecord`
-- ----------------------------
DROP TABLE IF EXISTS `loginrecord`;
CREATE TABLE `loginrecord` (
  `ID` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `time` date NOT NULL,
  `number` int NOT NULL,
  PRIMARY KEY (`time`,`number`) USING BTREE,
  KEY `readerid_idx` (`ID`) USING BTREE,
  CONSTRAINT `readerid2` FOREIGN KEY (`ID`) REFERENCES `readers` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of loginrecord
-- ----------------------------
INSERT INTO `loginrecord` VALUES ('2021001', '2022-11-18', '1');
INSERT INTO `loginrecord` VALUES ('2021001', '2022-11-18', '2');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-24', '1');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-24', '2');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-24', '3');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-24', '7');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-24', '8');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-24', '10');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-24', '12');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-24', '16');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-25', '1');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-25', '2');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-25', '3');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-25', '4');
INSERT INTO `loginrecord` VALUES ('2021001', '2023-12-25', '5');
INSERT INTO `loginrecord` VALUES ('2021001', '2024-01-07', '1');
INSERT INTO `loginrecord` VALUES ('2021002', '2023-12-24', '5');
INSERT INTO `loginrecord` VALUES ('2021002', '2023-12-24', '6');
INSERT INTO `loginrecord` VALUES ('2021002', '2023-12-24', '9');
INSERT INTO `loginrecord` VALUES ('2021002', '2023-12-24', '11');
INSERT INTO `loginrecord` VALUES ('2021002', '2023-12-24', '13');
INSERT INTO `loginrecord` VALUES ('2021002', '2023-12-24', '14');
INSERT INTO `loginrecord` VALUES ('2021002', '2023-12-24', '15');
INSERT INTO `loginrecord` VALUES ('20211002', '2023-12-24', '4');

-- ----------------------------
-- Table structure for `readers`
-- ----------------------------
DROP TABLE IF EXISTS `readers`;
CREATE TABLE `readers` (
  `ID` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `姓名` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `性别` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `单位` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `读者类型` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `可借册数` int DEFAULT NULL,
  `在借册数` int DEFAULT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '123456',
  `欠款` float DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='				';

-- ----------------------------
-- Records of readers
-- ----------------------------
INSERT INTO `readers` VALUES ('2021001', '李仁强', '男', '建筑系', '本科生', '15', '5', '123', '0');
INSERT INTO `readers` VALUES ('2021002', '冯恩光', '女', '环境工程系', '本科生', '9', '11', '123456', '0');
INSERT INTO `readers` VALUES ('20211002', '王建哲', '女', '工程力学系', '本科生', '9', '1', '123456', '0');

-- ----------------------------
-- Table structure for `readertype`
-- ----------------------------
DROP TABLE IF EXISTS `readertype`;
CREATE TABLE `readertype` (
  `读者类型` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `借书时间` int DEFAULT NULL,
  `最多在借册数` int DEFAULT NULL,
  PRIMARY KEY (`读者类型`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of readertype
-- ----------------------------
INSERT INTO `readertype` VALUES ('教师', '3', '30');
INSERT INTO `readertype` VALUES ('本科生', '1', '10');
INSERT INTO `readertype` VALUES ('研究生', '2', '20');

-- ----------------------------
-- Table structure for `workers`
-- ----------------------------
DROP TABLE IF EXISTS `workers`;
CREATE TABLE `workers` (
  `ID` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `姓名` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` enum('图书管理员','系统管理员') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '123456',
  PRIMARY KEY (`ID`,`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of workers
-- ----------------------------
INSERT INTO `workers` VALUES ('01', 'boss', '系统管理员', '123');
INSERT INTO `workers` VALUES ('10001', 'manager', '图书管理员', '123');
