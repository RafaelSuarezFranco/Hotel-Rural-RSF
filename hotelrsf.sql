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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.entradas: ~20 rows (aproximadamente)
DELETE FROM `entradas`;
/*!40000 ALTER TABLE `entradas` DISABLE KEYS */;
INSERT INTO `entradas` (`id`, `numerohabitacion`, `fecha`, `estado`, `cliente`, `preciofinal`) VALUES
	(2, 1, '2022-02-02', 'ocupada', 'Pepe', 10),
	(3, 34, '2022-02-02', 'reservada', 'Rafael', 50),
	(4, 1, '2022-03-01', 'reservada', 'Rafael', 14),
	(6, 1, '2022-02-27', 'reservada', 'Rafael', 14),
	(7, 1, '2022-02-26', 'reservada', 'Rafael', 14),
	(8, 1, '2022-02-25', 'reservada', 'Rafael', 14),
	(9, 1, '2022-02-24', 'reservada', 'Rafael', 14),
	(10, 1, '2022-02-23', 'reservada', 'Rafael', 14),
	(11, 1, '2022-02-22', 'reservada', 'Rafael', 14),
	(12, 1, '2022-03-21', 'reservada', 'Rafael', 14),
	(13, 1, '2022-03-20', 'reservada', 'Rafael', 14),
	(14, 1, '2022-03-19', 'reservada', 'Rafael', 14),
	(15, 1, '2022-03-18', 'reservada', 'Rafael', 14),
	(16, 1, '2022-02-18', 'reservada', 'pepe', 10),
	(17, 1, '2022-02-19', 'ocupada', 'Manuel', 10),
	(20, 2, '2022-02-12', 'reservada', 'Manuel', 10),
	(23, 1, '2022-04-16', 'reservada', 'Rafael', 30),
	(24, 1, '2022-04-09', 'reservada', 'pepe', 20),
	(25, 9, '2022-02-04', 'ocupada', 'manolo', 20),
	(26, 1, '2022-04-10', 'reservada', 'pascual', 30);
/*!40000 ALTER TABLE `entradas` ENABLE KEYS */;

-- Volcando estructura para tabla hotelrsf.entradasservicios
CREATE TABLE IF NOT EXISTS `entradasservicios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numerohabitacion` int(11) NOT NULL DEFAULT '0',
  `fecha` date NOT NULL,
  `nombreservicio` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.entradasservicios: ~0 rows (aproximadamente)
DELETE FROM `entradasservicios`;
/*!40000 ALTER TABLE `entradasservicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `entradasservicios` ENABLE KEYS */;

-- Volcando estructura para tabla hotelrsf.habitaciones
CREATE TABLE IF NOT EXISTS `habitaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL DEFAULT '0',
  `tipo` varchar(50) NOT NULL DEFAULT '0',
  `preciobase` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.habitaciones: ~11 rows (aproximadamente)
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
	(14, 34, 'suite', 50);
/*!40000 ALTER TABLE `habitaciones` ENABLE KEYS */;

-- Volcando estructura para tabla hotelrsf.servicios
CREATE TABLE IF NOT EXISTS `servicios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombreservicio` varchar(50) NOT NULL DEFAULT '0',
  `precioservicio` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.servicios: ~3 rows (aproximadamente)
DELETE FROM `servicios`;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` (`id`, `nombreservicio`, `precioservicio`) VALUES
	(1, 'Lavandería', 4),
	(2, 'Desayuno', 7),
	(3, 'Limpieza', 5);
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;

-- Volcando estructura para tabla hotelrsf.temporadas
CREATE TABLE IF NOT EXISTS `temporadas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fechainicio` date NOT NULL,
  `fechafin` date NOT NULL,
  `nombretemporada` varchar(50) NOT NULL DEFAULT '0',
  `precioadicional` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.temporadas: ~6 rows (aproximadamente)
DELETE FROM `temporadas`;
/*!40000 ALTER TABLE `temporadas` DISABLE KEYS */;
INSERT INTO `temporadas` (`id`, `fechainicio`, `fechafin`, `nombretemporada`, `precioadicional`) VALUES
	(1, '2022-04-10', '2022-04-17', 'alta', 20),
	(2, '2022-07-01', '2022-08-31', 'alta', 20),
	(4, '2022-04-01', '2022-04-09', 'media', 10),
	(5, '2022-04-18', '2022-04-28', 'media', 10),
	(6, '2022-06-10', '2022-06-30', 'media', 10),
	(7, '2022-09-01', '2022-09-15', 'media', 10);
/*!40000 ALTER TABLE `temporadas` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
