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

-- Volcando estructura para tabla hotelrsf.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identificador` varchar(50) NOT NULL DEFAULT '0',
  `nombre` varchar(100) NOT NULL DEFAULT '0',
  `apellidos` varchar(150) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.clientes: ~0 rows (aproximadamente)
DELETE FROM `clientes`;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`id`, `identificador`, `nombre`, `apellidos`) VALUES
	(1, '12345678A', 'Rafael', 'Suárez Franco'),
	(2, '12345678B', 'Pepe', 'Pepero Pepaso'),
	(3, '12345678C', 'Alfonso', 'Alonso Adolfo');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para tabla hotelrsf.entradas
CREATE TABLE IF NOT EXISTS `entradas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numerohabitacion` int(11) DEFAULT '0',
  `fecha` date DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `cliente` varchar(50) DEFAULT NULL,
  `preciofinal` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1657 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.entradas: ~23 rows (aproximadamente)
DELETE FROM `entradas`;
/*!40000 ALTER TABLE `entradas` DISABLE KEYS */;
INSERT INTO `entradas` (`id`, `numerohabitacion`, `fecha`, `estado`, `cliente`, `preciofinal`) VALUES
	(3, 34, '2022-02-02', 'reservada', 'Rafael', 50),
	(4, 1, '2022-03-01', 'reservada', 'Rafael', 14),
	(12, 1, '2022-03-21', 'reservada', 'Rafael', 14),
	(13, 1, '2022-03-20', 'reservada', 'Rafael', 14),
	(14, 1, '2022-03-19', 'reservada', 'Rafael', 14),
	(15, 1, '2022-03-18', 'reservada', 'Rafael', 14),
	(20, 2, '2022-02-12', 'reservada', 'Manuel', 5),
	(23, 1, '2022-04-16', 'reservada', 'Rafael', 30),
	(24, 1, '2022-04-09', 'reservada', 'pepe', 20),
	(25, 9, '2022-02-04', 'ocupada', 'manolo', 20),
	(26, 1, '2022-04-10', 'reservada', 'pascual', 30),
	(33, 2, '2022-02-04', 'reservada', 'aa', 14),
	(36, 2, '2022-02-05', 'reservada', 'Rafael', 10),
	(37, 2, '2022-02-06', 'reservada', 'qwewq', 21),
	(38, 2, '2022-02-07', 'reservada', 'qwer', 10),
	(1540, 2, '2022-02-10', 'reservada', 'sadfa', 0),
	(1541, 3, '2022-02-10', 'reservada', 'Manolete', 10),
	(1542, 3, '2022-02-11', 'reservada', 'Manolete', 10),
	(1543, 3, '2022-02-12', 'reservada', 'Manolete', 10),
	(1544, 3, '2022-04-09', 'reservada', 'gaaaaaa', 20),
	(1545, 3, '2022-04-10', 'reservada', 'gaaaaaa', 30),
	(1588, 1, '2022-02-14', 'reservada', 'aaaaaaaaa', 21),
	(1589, 1, '2022-02-11', 'reservada', 'dsfs', 10);
/*!40000 ALTER TABLE `entradas` ENABLE KEYS */;

-- Volcando estructura para tabla hotelrsf.entradasservicios
CREATE TABLE IF NOT EXISTS `entradasservicios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numerohabitacion` int(11) NOT NULL DEFAULT '0',
  `fecha` date NOT NULL,
  `nombreservicio` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.entradasservicios: ~13 rows (aproximadamente)
DELETE FROM `entradasservicios`;
/*!40000 ALTER TABLE `entradasservicios` DISABLE KEYS */;
INSERT INTO `entradasservicios` (`id`, `numerohabitacion`, `fecha`, `nombreservicio`) VALUES
	(2, 1, '2022-04-16', 'Desayuno'),
	(3, 1, '2022-04-16', 'Lavandería'),
	(16, 2, '2022-02-04', 'Lavandería'),
	(17, 2, '2022-02-04', 'Desayuno'),
	(20, 1, '2022-02-09', 'Lavandería'),
	(21, 1, '2022-02-09', 'Desayuno'),
	(22, 2, '2022-02-05', 'Lavandería'),
	(23, 2, '2022-02-05', 'Desayuno'),
	(24, 2, '2022-02-05', 'Limpieza'),
	(25, 2, '2022-02-06', 'Lavandería'),
	(26, 2, '2022-02-06', 'Desayuno'),
	(60, 1, '2022-02-14', 'Lavandería'),
	(61, 1, '2022-02-14', 'Desayuno');
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

-- Volcando estructura para tabla hotelrsf.historicoentradas
CREATE TABLE IF NOT EXISTS `historicoentradas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numerohabitacion` int(11) DEFAULT '0',
  `fecha` date DEFAULT NULL,
  `cliente` varchar(50) DEFAULT NULL,
  `preciofinal` float DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla hotelrsf.historicoentradas: ~119 rows (aproximadamente)
DELETE FROM `historicoentradas`;
/*!40000 ALTER TABLE `historicoentradas` DISABLE KEYS */;
INSERT INTO `historicoentradas` (`id`, `numerohabitacion`, `fecha`, `cliente`, `preciofinal`, `estado`) VALUES
	(1, 2, '2022-02-09', 'asdf', 10, 'reservada'),
	(2, 1, '2022-02-10', 'Pepito', 0, 'reservada'),
	(3, 1, '2022-02-11', 'Pepito', 0, 'reservada'),
	(4, 1, '2022-02-10', 'pepe', 0, 'reservada'),
	(5, 1, '2022-02-11', 'pepe', 0, 'reservada'),
	(6, 1, '2022-02-12', 'pepe', 0, 'reservada'),
	(7, 1, '2022-02-02', 'Pepe', 10, 'ocupada'),
	(8, 1, '2022-02-27', 'Rafael', 14, 'reservada'),
	(9, 1, '2022-02-26', 'Rafael', 14, 'reservada'),
	(10, 1, '2022-02-25', 'Rafael', 14, 'reservada'),
	(11, 1, '2022-02-24', 'Rafael', 14, 'reservada'),
	(12, 1, '2022-02-23', 'Rafael', 14, 'reservada'),
	(13, 1, '2022-02-22', 'Rafael', 14, 'reservada'),
	(14, 1, '2022-02-18', 'pepe', 10, 'reservada'),
	(15, 1, '2022-02-19', 'Manuel', 10, 'ocupada'),
	(16, 1, '2022-02-09', 'sdfg', 244, 'reservada'),
	(17, 1, '2022-02-10', '111', 0, 'reservada'),
	(18, 1, '2022-02-11', '123', 0, 'reservada'),
	(19, 1, '2022-02-12', '123', 0, 'reservada'),
	(20, 1, '2022-02-13', '123', 0, 'reservada'),
	(21, 1, '2022-02-11', 'Pepe', 20, 'ocupada'),
	(22, 1, '2022-02-11', 'Pepe', 20, 'ocupada'),
	(23, 1, '2022-02-11', 'Pepe', 14, 'reservada'),
	(24, 1, '2022-02-11', 'Pepe', 14, 'ocupada'),
	(25, 1, '2022-02-11', 'Pepe', 14, 'ocupada'),
	(26, 1, '2022-02-12', 'rafael', 14, 'reservada'),
	(27, 1, '2022-02-12', 'rafael', 14, 'ocupada'),
	(28, 1, '2022-02-11', 'asdfasdf', 10, 'ocupada'),
	(29, 1, '2022-02-11', 'aaaaaaaaa', 10, 'reservada'),
	(30, 1, '2022-02-11', 'aaaaaaaaa', 10, 'ocupada'),
	(31, 1, '2022-02-13', 'bbbbbbb', 10, 'reservada'),
	(32, 1, '2022-02-13', 'bbbbbbb', 10, 'ocupada'),
	(33, 1, '2022-02-16', 'adsfdsaf', 10, 'ocupada'),
	(34, 1, '2022-02-14', 'asdf', 10, 'reservada'),
	(35, 1, '2022-02-11', 'pepe', 10, 'reservada'),
	(36, 1, '2022-02-12', 'pepe', 10, 'reservada'),
	(37, 1, '2022-02-11', 'asdasd', 10, 'reservada'),
	(38, 1, '2022-02-12', 'asdasd', 10, 'reservada'),
	(39, 1, '2022-02-13', 'asdasd', 10, 'reservada'),
	(40, 1, '2022-02-11', 'asdf', 10, 'reservada'),
	(41, 1, '2022-02-12', 'asdf', 10, 'reservada'),
	(42, 1, '2022-02-11', 'asdf', 19, 'reservada'),
	(43, 1, '2022-02-12', 'asdf', 19, 'reservada'),
	(44, 1, '2022-02-13', 'asdf', 19, 'reservada'),
	(45, 1, '2022-02-14', 'asdf', 19, 'reservada'),
	(46, 1, '2022-02-11', 'Manolo', 22, 'reservada'),
	(47, 1, '2022-02-12', 'Manolo', 22, 'reservada'),
	(48, 1, '2022-02-13', 'Manolo', 22, 'reservada'),
	(49, 1, '2022-02-14', 'Manolo', 22, 'reservada'),
	(50, 1, '2022-02-11', 'aaaaaaaaa', 21, 'reservada'),
	(51, 1, '2022-02-12', 'aaaaaaaaa', 21, 'reservada'),
	(52, 1, '2022-02-13', 'aaaaaaaaa', 21, 'reservada'),
	(53, 1, '2022-08-14', 'prueba semana santa', 20, 'reservada'),
	(54, 1, '2022-08-15', 'prueba semana santa', 42, 'reservada'),
	(55, 1, '2022-08-16', 'prueba semana santa', 42, 'reservada'),
	(56, 1, '2022-08-17', 'prueba semana santa', 42, 'reservada'),
	(57, 1, '2022-08-18', 'prueba semana santa', 42, 'reservada'),
	(58, 1, '2022-08-19', 'prueba semana santa', 42, 'reservada'),
	(59, 1, '2022-08-20', 'prueba semana santa', 42, 'reservada'),
	(60, 1, '2022-08-21', 'prueba semana santa', 42, 'reservada'),
	(61, 1, '2022-08-22', 'prueba semana santa', 42, 'reservada'),
	(62, 1, '2022-08-23', 'prueba semana santa', 42, 'reservada'),
	(63, 1, '2022-08-24', 'prueba semana santa', 42, 'reservada'),
	(64, 1, '2022-08-25', 'prueba semana santa', 42, 'reservada'),
	(65, 1, '2022-08-26', 'prueba semana santa', 42, 'reservada'),
	(66, 1, '2022-08-27', 'prueba semana santa', 42, 'reservada'),
	(67, 1, '2022-08-28', 'prueba semana santa', 42, 'reservada'),
	(68, 1, '2022-08-29', 'prueba semana santa', 42, 'reservada'),
	(69, 1, '2022-08-30', 'prueba semana santa', 42, 'reservada'),
	(70, 1, '2022-08-31', 'prueba semana santa', 42, 'reservada'),
	(71, 1, '2022-09-01', 'prueba semana santa', 32, 'reservada'),
	(72, 1, '2022-09-02', 'prueba semana santa', 32, 'reservada'),
	(73, 1, '2022-09-03', 'prueba semana santa', 32, 'reservada'),
	(74, 1, '2022-09-04', 'prueba semana santa', 32, 'reservada'),
	(75, 1, '2022-09-05', 'prueba semana santa', 32, 'reservada'),
	(76, 1, '2022-09-06', 'prueba semana santa', 32, 'reservada'),
	(77, 1, '2022-09-07', 'prueba semana santa', 32, 'reservada'),
	(78, 1, '2022-09-08', 'prueba semana santa', 32, 'reservada'),
	(79, 1, '2022-09-09', 'prueba semana santa', 32, 'reservada'),
	(80, 1, '2022-09-10', 'prueba semana santa', 32, 'reservada'),
	(81, 1, '2022-09-11', 'prueba semana santa', 32, 'reservada'),
	(82, 1, '2022-09-12', 'prueba semana santa', 32, 'reservada'),
	(83, 1, '2022-09-13', 'prueba semana santa', 32, 'reservada'),
	(84, 1, '2022-09-14', 'prueba semana santa', 32, 'reservada'),
	(85, 1, '2022-09-15', 'prueba semana santa', 32, 'reservada'),
	(86, 1, '2022-09-16', 'prueba semana santa', 22, 'reservada'),
	(87, 1, '2022-09-17', 'prueba semana santa', 22, 'reservada'),
	(88, 1, '2022-09-18', 'prueba semana santa', 22, 'reservada'),
	(89, 1, '2022-09-19', 'prueba semana santa', 22, 'reservada'),
	(90, 1, '2022-09-20', 'prueba semana santa', 22, 'reservada'),
	(91, 1, '2022-09-21', 'prueba semana santa', 22, 'reservada'),
	(92, 1, '2022-09-22', 'prueba semana santa', 22, 'reservada'),
	(93, 1, '2022-09-23', 'prueba semana santa', 22, 'reservada'),
	(94, 1, '2022-09-24', 'prueba semana santa', 22, 'reservada'),
	(95, 1, '2022-09-25', 'prueba semana santa', 22, 'reservada'),
	(96, 1, '2022-09-26', 'prueba semana santa', 22, 'reservada'),
	(97, 1, '2022-09-27', 'prueba semana santa', 22, 'reservada'),
	(98, 1, '2022-09-28', 'prueba semana santa', 22, 'reservada'),
	(99, 1, '2022-09-29', 'prueba semana santa', 22, 'reservada'),
	(100, 1, '2022-09-30', 'prueba semana santa', 22, 'reservada'),
	(101, 1, '2022-10-01', 'prueba semana santa', 22, 'reservada'),
	(102, 1, '2022-10-02', 'prueba semana santa', 22, 'reservada'),
	(103, 1, '2022-10-03', 'prueba semana santa', 22, 'reservada'),
	(104, 1, '2022-10-04', 'prueba semana santa', 22, 'reservada'),
	(105, 1, '2022-10-05', 'prueba semana santa', 22, 'reservada'),
	(106, 1, '2022-10-06', 'prueba semana santa', 22, 'reservada'),
	(107, 1, '2022-10-07', 'prueba semana santa', 22, 'reservada'),
	(108, 1, '2022-10-08', 'prueba semana santa', 22, 'reservada'),
	(109, 1, '2022-10-09', 'prueba semana santa', 22, 'reservada'),
	(110, 1, '2022-10-10', 'prueba semana santa', 22, 'reservada'),
	(111, 1, '2022-10-11', 'prueba semana santa', 22, 'reservada'),
	(112, 1, '2022-10-12', 'prueba semana santa', 22, 'reservada'),
	(113, 1, '2022-10-13', 'prueba semana santa', 22, 'reservada'),
	(114, 1, '2022-10-14', 'prueba semana santa', 22, 'reservada'),
	(115, 1, '2022-10-15', 'prueba semana santa', 22, 'reservada'),
	(116, 1, '2022-10-16', 'prueba semana santa', 22, 'reservada'),
	(117, 1, '2022-10-17', 'prueba semana santa', 22, 'reservada'),
	(118, 1, '2022-10-18', 'prueba semana santa', 22, 'reservada'),
	(119, 1, '2022-10-19', 'prueba semana santa', 22, 'reservada');
/*!40000 ALTER TABLE `historicoentradas` ENABLE KEYS */;

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
