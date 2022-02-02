-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.5.60 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para hotelrsf
CREATE DATABASE IF NOT EXISTS `hotelrsf` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `hotelrsf`;

-- Volcando estructura para tabla hotelrsf.entradas
CREATE TABLE IF NOT EXISTS `entradas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numerohabitacion` int(11) DEFAULT '0',
  `fecha` date DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `cliente` varchar(50) DEFAULT NULL,
  `preciofinal` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.entradas: ~0 rows (aproximadamente)
DELETE FROM `entradas`;
/*!40000 ALTER TABLE `entradas` DISABLE KEYS */;
INSERT INTO `entradas` (`id`, `numerohabitacion`, `fecha`, `estado`, `cliente`, `preciofinal`) VALUES
	(1, 1, '2022-02-26', 'reservada', 'Rafael', 10),
	(2, 1, '2022-02-02', 'ocupada', 'Pepe', 10),
	(3, 34, '2022-02-02', 'reservada', 'Rafael', 50),
	(4, 1, '2022-03-01', 'reservada', 'Rafael', 10);
/*!40000 ALTER TABLE `entradas` ENABLE KEYS */;

-- Volcando estructura para tabla hotelrsf.habitaciones
CREATE TABLE IF NOT EXISTS `habitaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL DEFAULT '0',
  `tipo` varchar(50) NOT NULL DEFAULT '0',
  `preciobase` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.habitaciones: ~10 rows (aproximadamente)
DELETE FROM `habitaciones`;
/*!40000 ALTER TABLE `habitaciones` DISABLE KEYS */;
INSERT INTO `habitaciones` (`id`, `numero`, `tipo`, `preciobase`) VALUES
	(1, 1, 'simple', 10),
	(2, 2, 'simple', 10),
	(3, 3, 'simple', 10),
	(4, 4, 'doble', 20),
	(5, 5, 'doble', 20),
	(6, 6, 'doble', 20),
	(7, 7, 'doble', 20),
	(8, 8, 'doble', 20),
	(9, 9, 'doble', 20),
	(10, 10, 'suite', 50),
	(14, 34, 'suite', 0);
/*!40000 ALTER TABLE `habitaciones` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
