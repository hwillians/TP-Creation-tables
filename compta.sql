-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jul 20, 2020 at 04:10 PM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `compta`
--
CREATE DATABASE IF NOT EXISTS `compta` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `compta`;

-- --------------------------------------------------------

--
-- Table structure for table `Article`
--

DROP TABLE IF EXISTS `Article`;
CREATE TABLE IF NOT EXISTS `Article` (
  `id` int(10) NOT NULL,
  `ref` varchar(13) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `prix` decimal(7,2) NOT NULL,
  `id_fou` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_fou_article` (`id_fou`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bon`
--

DROP TABLE IF EXISTS `bon`;
CREATE TABLE IF NOT EXISTS `bon` (
  `id` int(10) NOT NULL,
  `numero` int(10) NOT NULL,
  `date_cmde` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delai` int(10) NOT NULL,
  `id_fou` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_fou_bon` (`id_fou`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `compo`
--

DROP TABLE IF EXISTS `compo`;
CREATE TABLE IF NOT EXISTS `compo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `qte` int(10) NOT NULL,
  `id_bon` int(10) NOT NULL,
  `id_art` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_art_compo` (`id_art`) USING BTREE,
  KEY `FK_bon_compo` (`id_bon`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Fournisseur`
--

DROP TABLE IF EXISTS `Fournisseur`;
CREATE TABLE IF NOT EXISTS `Fournisseur` (
  `id` int(10) NOT NULL,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Article`
--
ALTER TABLE `Article`
  ADD CONSTRAINT `FK_fou_article` FOREIGN KEY (`id_fou`) REFERENCES `Fournisseur` (`id`);

--
-- Constraints for table `bon`
--
ALTER TABLE `bon`
  ADD CONSTRAINT `FK_fou_bon` FOREIGN KEY (`id_fou`) REFERENCES `Fournisseur` (`id`);

--
-- Constraints for table `compo`
--
ALTER TABLE `compo`
  ADD CONSTRAINT `FK_compo_Article` FOREIGN KEY (`id_art`) REFERENCES `Article` (`id`),
  ADD CONSTRAINT `FK_compo_bon` FOREIGN KEY (`id_bon`) REFERENCES `bon` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
