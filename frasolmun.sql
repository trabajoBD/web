-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 03-06-2013 a las 12:55:53
-- Versión del servidor: 5.5.24-log
-- Versión de PHP: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `frasolmun`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alquiler`
--

CREATE TABLE IF NOT EXISTS `alquiler` (
  `idalquiler` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `idcarrito` int(11) NOT NULL COMMENT 'ID del carrito',
  `fechainicio` datetime DEFAULT NULL COMMENT 'Fecha de inicio del alquiler',
  `fechafinprevista` datetime DEFAULT NULL COMMENT 'Fecha de fin prevista (real en modalidad Online)',
  `esOnline` tinyint(1) DEFAULT NULL COMMENT 'Indicador de online:\\n0- Offline\\n1- Online',
  PRIMARY KEY (`idalquiler`,`idpersona`,`idcarrito`),
  KEY `idpersona_idx` (`idpersona`),
  KEY `idcarrito_idx` (`idcarrito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alquileroffline`
--

CREATE TABLE IF NOT EXISTS `alquileroffline` (
  `idalquiler` int(11) NOT NULL,
  `iddireccion` int(11) NOT NULL,
  `fechadevolucion` datetime DEFAULT NULL,
  `precioenvio` float DEFAULT NULL,
  PRIMARY KEY (`idalquiler`,`iddireccion`),
  KEY `idalquiler_idx` (`idalquiler`),
  KEY `iddireccion_idx` (`iddireccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE IF NOT EXISTS `articulo` (
  `idarticulo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion` varchar(400) COLLATE utf8_spanish_ci DEFAULT NULL,
  `preciooffline` float DEFAULT NULL,
  `precioonline` float DEFAULT NULL,
  `disponibleonline` tinyint(1) DEFAULT NULL,
  `disponibleoffline` tinyint(1) DEFAULT NULL,
  `imagen` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idarticulo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `nombre`, `descripcion`, `preciooffline`, `precioonline`, `disponibleonline`, `disponibleoffline`, `imagen`) VALUES
(1, 'Troya', 'Película', 5, 1, 1, 1, NULL),
(12, 'Iron Maiden - The Number Of The Beast', '', 0, 0, 0, 0, ''),
(13, 'Iron Maiden - The Number Of The Beast', '', 0, 0, 0, 0, ''),
(14, 'Rammstein - Mutter', '', 0, 0, 0, 0, ''),
(15, 'Rammstein - Reise, Reise', '', 0, 0, 0, 0, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artista`
--

CREATE TABLE IF NOT EXISTS `artista` (
  `idartista` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nacimiento` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estatura` float DEFAULT NULL,
  PRIMARY KEY (`idartista`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=85 ;

--
-- Volcado de datos para la tabla `artista`
--

INSERT INTO `artista` (`idartista`, `nombre`, `nacimiento`, `estatura`) VALUES
(48, 'Julian Glover', NULL, NULL),
(49, 'Brian Cox', NULL, NULL),
(50, 'Nathan Jones', NULL, NULL),
(51, 'Adoni Maropis', NULL, NULL),
(52, 'Jacob Smith', NULL, NULL),
(53, 'Brad Pitt', NULL, NULL),
(54, 'John Shrapnel', NULL, NULL),
(55, 'Brendan Gleeson', NULL, NULL),
(56, 'Diane Kruger', NULL, NULL),
(57, 'Eric Bana', NULL, NULL),
(58, 'Orlando Bloom', NULL, NULL),
(59, 'Siri Svegler', NULL, NULL),
(60, 'Lucie Barat', NULL, NULL),
(61, 'Ken Bones', NULL, NULL),
(62, 'Manuel Cauchi', NULL, NULL),
(63, 'Mark Lewis Jones', NULL, NULL),
(64, 'Garrett Hedlund', NULL, NULL),
(65, 'Sean Bean', NULL, NULL),
(66, 'Julie Christie', NULL, NULL),
(67, 'Peter O''Toole', NULL, NULL),
(68, 'James Cosmo', NULL, NULL),
(69, 'Nigel Terry', NULL, NULL),
(70, 'Trevor Eve', NULL, NULL),
(71, 'Owain Yeoman', NULL, NULL),
(72, 'Saffron Burrows', NULL, NULL),
(73, 'Luke Tal', NULL, NULL),
(74, 'Matthew Tal', NULL, NULL),
(75, 'Rose Byrne', NULL, NULL),
(76, 'Vincent Regan', NULL, NULL),
(77, 'Tyler Mane', NULL, NULL),
(78, 'Louis Dempsey', NULL, NULL),
(79, 'Joshua Richards', NULL, NULL),
(80, 'Tim Chipping', NULL, NULL),
(81, 'Desislava Stefanova', NULL, NULL),
(82, 'Tanja Tzarovska', NULL, NULL),
(83, 'Alex King', NULL, NULL),
(84, 'Frankie Fitzgerald', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE IF NOT EXISTS `carrito` (
  `idcarrito` int(11) NOT NULL AUTO_INCREMENT,
  `iddescuento` int(11) NOT NULL DEFAULT '0',
  `fechamodificacion` datetime DEFAULT NULL COMMENT 'Fecha de la última modificación del carrito',
  `confenvio` tinyint(1) DEFAULT NULL COMMENT 'Confirmación de envío:\\n0- No confirmado\\n1- Confirmado',
  PRIMARY KEY (`idcarrito`,`iddescuento`),
  KEY `iddescuento_idx` (`iddescuento`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`idcarrito`, `iddescuento`, `fechamodificacion`, `confenvio`) VALUES
(1, 1, '2013-01-29 16:30:01', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carritolinea`
--

CREATE TABLE IF NOT EXISTS `carritolinea` (
  `idcarritolinea` int(11) NOT NULL AUTO_INCREMENT,
  `idcarrito` int(11) NOT NULL,
  `idejemplar` int(11) NOT NULL,
  `precio` float DEFAULT NULL,
  PRIMARY KEY (`idcarritolinea`,`idcarrito`,`idejemplar`),
  KEY `idcarrito_idx` (`idcarrito`),
  KEY `idejemplar_idx` (`idejemplar`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `carritolinea`
--

INSERT INTO `carritolinea` (`idcarritolinea`, `idcarrito`, `idejemplar`, `precio`) VALUES
(6, 1, 1, 5),
(7, 1, 1, 5),
(8, 1, 1, 5),
(9, 1, 1, 5),
(10, 1, 1, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `descuento`
--

CREATE TABLE IF NOT EXISTS `descuento` (
  `iddescuento` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `porcentaje` float DEFAULT NULL,
  `preciobruto` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddescuento`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `descuento`
--

INSERT INTO `descuento` (`iddescuento`, `codigo`, `porcentaje`, `preciobruto`) VALUES
(1, 'TROYA5', NULL, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion`
--

CREATE TABLE IF NOT EXISTS `direccion` (
  `iddireccion` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `ciudad` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigoPostal` int(11) DEFAULT NULL,
  `direccionCompleta` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `esFavorita` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`iddireccion`,`idpersona`),
  KEY `idpersona_idx` (`idpersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`iddireccion`, `idpersona`, `ciudad`, `codigoPostal`, `direccionCompleta`, `esFavorita`) VALUES
(1, 1, 'Sevilla', 41920, 'Plaza persona 1', NULL),
(2, 1, 'Madrid', 49383, 'Plaza persona 1 (2)', 1),
(3, 3, 'Córdoba', 49384, 'Plaza persona 3', NULL),
(4, 3, 'Granada', 43923, 'Plaza persona 3 (2)', 1),
(5, 5, 'Madrid', 49384, 'Plaza persona 5', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disco`
--

CREATE TABLE IF NOT EXISTS `disco` (
  `idproducto` int(11) NOT NULL,
  `artista` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `album` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `anho` year(4) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `genero` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idproducto`),
  KEY `idproducto_idx` (`idproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `disco`
--

INSERT INTO `disco` (`idproducto`, `artista`, `album`, `anho`, `duracion`, `genero`) VALUES
(12, 'Iron Maiden', 'The Number Of The Beast', 1982, 4026, 'Metal'),
(13, 'Iron Maiden', 'The Number Of The Beast', 1982, 4026, 'Metal'),
(14, 'Rammstein', 'Mutter', 2001, 3596, 'Rock'),
(15, 'Rammstein', 'Reise, Reise', 2004, 3238, 'Rock');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejemplar`
--

CREATE TABLE IF NOT EXISTS `ejemplar` (
  `idejemplar` int(11) NOT NULL AUTO_INCREMENT,
  `idarticulo` int(11) NOT NULL,
  `formato` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'VHS, DVD, BluRay, CD',
  `estado` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Disponible, no disponible, dañado...',
  PRIMARY KEY (`idejemplar`,`idarticulo`),
  KEY `idarticulo_idx` (`idarticulo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `ejemplar`
--

INSERT INTO `ejemplar` (`idejemplar`, `idarticulo`, `formato`, `estado`) VALUES
(1, 1, 'DVD', 'Disponible'),
(2, 1, 'DVD', 'Disponible'),
(3, 1, 'DVD', 'Disponible'),
(4, 1, 'DVD', 'Disponible'),
(5, 1, 'DVD', 'Disponible'),
(6, 1, 'DVD', 'Disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE IF NOT EXISTS `empleado` (
  `idpersona` int(11) NOT NULL,
  `idpersonasupervisor` int(11) NOT NULL DEFAULT '0',
  `codigoempleado` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpersona`,`idpersonasupervisor`),
  KEY `idpersona_idx` (`idpersona`),
  KEY `idpersonasupervisor_idx` (`idpersonasupervisor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idpersona`, `idpersonasupervisor`, `codigoempleado`) VALUES
(1, 1, 1),
(3, 1, 2),
(5, 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foto`
--

CREATE TABLE IF NOT EXISTS `foto` (
  `idfoto` int(11) NOT NULL AUTO_INCREMENT,
  `idproducto` int(11) NOT NULL,
  `piedefoto` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `imagen` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idfoto`,`idproducto`),
  KEY `idproducto_idx` (`idproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foto_aparece`
--

CREATE TABLE IF NOT EXISTS `foto_aparece` (
  `idfoto` int(11) NOT NULL,
  `idartista` int(11) NOT NULL,
  `posx` int(11) DEFAULT NULL,
  `posy` int(11) DEFAULT NULL,
  PRIMARY KEY (`idfoto`,`idartista`),
  KEY `idfoto_idx` (`idfoto`),
  KEY `idartista_idx` (`idartista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `juego`
--

CREATE TABLE IF NOT EXISTS `juego` (
  `idproducto` int(11) NOT NULL,
  `plataforma` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `genero` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fechasalida` date DEFAULT NULL,
  `desarrolla` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idproducto`),
  KEY `idproducto_idx` (`idproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pack`
--

CREATE TABLE IF NOT EXISTS `pack` (
  `idpack` int(11) NOT NULL AUTO_INCREMENT,
  `idarticulo` int(11) NOT NULL,
  PRIMARY KEY (`idpack`,`idarticulo`),
  KEY `idarticulo_idx` (`idarticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pack_contiene`
--

CREATE TABLE IF NOT EXISTS `pack_contiene` (
  `idpack` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  PRIMARY KEY (`idpack`,`idproducto`),
  KEY `idpack_idx` (`idpack`),
  KEY `idproducto_idx` (`idproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE IF NOT EXISTS `pais` (
  `idpais` int(11) NOT NULL AUTO_INCREMENT,
  `nombrepais` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idpais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `idpersona` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la persona',
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Nombre de la persona',
  `apellidos` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Apellidos de la persona',
  `documento` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'DNI de la persona',
  `masculino` tinyint(1) DEFAULT NULL COMMENT 'Sexo:\\n0-Femenino\\n1-Masculino',
  `fechaNac` date DEFAULT NULL COMMENT 'Fecha de nacimiento',
  `email` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Email de la persona',
  `saldo` float DEFAULT '0' COMMENT 'Saldo actual',
  `usuario` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Nombre de usuario para login',
  `password` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'MD5(salt.password) del usuario',
  PRIMARY KEY (`idpersona`),
  UNIQUE KEY `idpersona_UNIQUE` (`idpersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `nombre`, `apellidos`, `documento`, `masculino`, `fechaNac`, `email`, `saldo`, `usuario`, `password`) VALUES
(1, 'Nombre1', 'Apellido1', NULL, NULL, NULL, NULL, 0, NULL, NULL),
(2, 'Nombre2', 'Apellido2', NULL, NULL, NULL, NULL, 0, NULL, NULL),
(3, 'Nombre3', 'Apellido3', NULL, NULL, NULL, NULL, 0, NULL, NULL),
(4, 'Nombre4', 'Apellido4', NULL, NULL, NULL, NULL, 0, NULL, NULL),
(5, 'Nombre5', 'Apellido5', NULL, NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pista`
--

CREATE TABLE IF NOT EXISTS `pista` (
  `idpista` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) DEFAULT NULL,
  `artista` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `titulo` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpista`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=62 ;

--
-- Volcado de datos para la tabla `pista`
--

INSERT INTO `pista` (`idpista`, `numero`, `artista`, `titulo`, `duracion`) VALUES
(27, 1, 'Iron Maiden', 'Invaders', 204),
(28, 2, 'Iron Maiden', 'Children Of The Damned', 276),
(29, 3, 'Iron Maiden', 'The Prisoner', 363),
(30, 4, 'Iron Maiden', '22 Acacia Avenue', 397),
(31, 5, 'Iron Maiden', 'The Number Of The Beast', 292),
(32, 6, 'Iron Maiden', 'Run To The Hills', 234),
(33, 7, 'Iron Maiden', 'Gangland', 229),
(34, 8, 'Iron Maiden', 'Hallowed Be Thy Name', 266),
(35, 9, 'Iron Maiden', 'Total Eclipse', 585),
(36, 10, 'Iron Maiden', 'Multimedia', 1180),
(37, 1, 'Rammstein', 'Mein Herz Brennt', 282),
(38, 2, 'Rammstein', 'Links 2 3 4', 219),
(39, 3, 'Rammstein', 'Sonne', 274),
(40, 4, 'Rammstein', 'Ich will', 220),
(41, 5, 'Rammstein', 'Feuer Frei', 190),
(42, 6, 'Rammstein', 'Mutter', 271),
(43, 7, 'Rammstein', 'Spieluhr', 288),
(44, 8, 'Rammstein', 'Zwitter', 260),
(45, 9, 'Rammstein', 'Rein Raus', 192),
(46, 10, 'Rammstein', 'Adios', 230),
(47, 11, 'Rammstein', 'Nebel', 296),
(48, 12, 'Rammstein', 'Sonne remix', 251),
(49, 13, 'Rammstein', 'Remix 1', 351),
(50, 14, 'Rammstein', 'Remix 2', 272),
(51, 1, 'Rammstein', 'Resie, Resie', 596),
(52, 2, 'Rammstein', 'Mein Teil', 274),
(53, 3, 'Rammstein', 'Dalai Lama', 341),
(54, 4, 'Rammstein', 'Keine Lust', 225),
(55, 5, 'Rammstein', 'Los', 267),
(56, 6, 'Rammstein', 'Amerika', 230),
(57, 7, 'Rammstein', 'Moskau', 258),
(58, 8, 'Rammstein', 'Morgenstern', 242),
(59, 9, 'Rammstein', 'Stein Um Stein', 238),
(60, 10, 'Rammstein', 'Ohne Dich', 274),
(61, 11, 'Rammstein', 'Amour', 292);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pista_disco`
--

CREATE TABLE IF NOT EXISTS `pista_disco` (
  `idproducto` int(11) NOT NULL,
  `idpista` int(11) NOT NULL,
  PRIMARY KEY (`idproducto`,`idpista`),
  KEY `idproducto_idx` (`idproducto`),
  KEY `idpista_idx` (`idpista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pista_disco`
--

INSERT INTO `pista_disco` (`idproducto`, `idpista`) VALUES
(13, 27),
(13, 28),
(13, 29),
(13, 30),
(13, 31),
(13, 32),
(13, 33),
(13, 34),
(13, 35),
(13, 36),
(14, 37),
(14, 38),
(14, 39),
(14, 40),
(14, 41),
(14, 42),
(14, 43),
(14, 44),
(14, 45),
(14, 46),
(14, 47),
(14, 48),
(14, 49),
(14, 50),
(15, 51),
(15, 52),
(15, 53),
(15, 54),
(15, 55),
(15, 56),
(15, 57),
(15, 58),
(15, 59),
(15, 60),
(15, 61);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE IF NOT EXISTS `producto` (
  `idproducto` int(11) NOT NULL AUTO_INCREMENT,
  `idarticulo` int(11) NOT NULL,
  PRIMARY KEY (`idproducto`,`idarticulo`),
  KEY `idarticulo_idx` (`idarticulo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idproducto`, `idarticulo`) VALUES
(1, 1),
(12, 12),
(13, 13),
(14, 14),
(15, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

CREATE TABLE IF NOT EXISTS `registro` (
  `idregistro` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `idpersona` int(11) NOT NULL COMMENT 'ID de la persona',
  `fecha` datetime DEFAULT NULL COMMENT 'Fecha del suceso',
  `estado` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Estado o hash de password',
  PRIMARY KEY (`idregistro`,`idpersona`),
  KEY `idpersona_idx` (`idpersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reparto`
--

CREATE TABLE IF NOT EXISTS `reparto` (
  `idproducto` int(11) NOT NULL,
  `idartista` int(11) NOT NULL,
  `idrol` int(11) NOT NULL,
  PRIMARY KEY (`idproducto`,`idartista`,`idrol`),
  KEY `idproducto_idx` (`idproducto`),
  KEY `idartista_idx` (`idartista`),
  KEY `idrol_idx` (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `reparto`
--

INSERT INTO `reparto` (`idproducto`, `idartista`, `idrol`) VALUES
(1, 48, 1),
(1, 49, 1),
(1, 50, 1),
(1, 51, 1),
(1, 52, 1),
(1, 53, 1),
(1, 54, 1),
(1, 55, 1),
(1, 56, 1),
(1, 57, 1),
(1, 58, 1),
(1, 59, 1),
(1, 60, 1),
(1, 61, 1),
(1, 62, 1),
(1, 63, 1),
(1, 64, 1),
(1, 65, 1),
(1, 66, 1),
(1, 67, 1),
(1, 68, 1),
(1, 69, 1),
(1, 70, 1),
(1, 71, 1),
(1, 72, 1),
(1, 73, 1),
(1, 74, 1),
(1, 75, 1),
(1, 76, 1),
(1, 77, 1),
(1, 78, 1),
(1, 79, 1),
(1, 80, 1),
(1, 81, 1),
(1, 82, 1),
(1, 83, 1),
(1, 84, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `idrol` int(11) NOT NULL AUTO_INCREMENT,
  `nombrerol` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `nombrerol`) VALUES
(1, 'Actor'),
(2, 'Director'),
(3, 'Música'),
(4, 'Escritor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesion`
--

CREATE TABLE IF NOT EXISTS `sesion` (
  `idsesion` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `cookie` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Cookie de la sesión',
  `ultimoMovimiento` datetime DEFAULT NULL COMMENT 'Fecha del último movimiento',
  `ip` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'IP',
  `activo` tinyint(1) DEFAULT NULL COMMENT 'Sesión activa',
  PRIMARY KEY (`idsesion`,`idpersona`),
  KEY `idpersona_idx` (`idpersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono`
--

CREATE TABLE IF NOT EXISTS `telefono` (
  `idtelefono` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `numero` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Número de teléfono',
  `esFavorito` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idtelefono`,`idpersona`),
  KEY `idpersona_idx` (`idpersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `telefono`
--

INSERT INTO `telefono` (`idtelefono`, `idpersona`, `numero`, `esFavorito`) VALUES
(1, 1, '95949595', 1),
(2, 1, '89649455', NULL),
(3, 3, '64684952', 1),
(4, 5, '49849552', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoracion`
--

CREATE TABLE IF NOT EXISTS `valoracion` (
  `idvaloracion` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `puntuacion` int(11) DEFAULT NULL,
  `comentario` varchar(140) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idvaloracion`,`idpersona`,`idarticulo`),
  KEY `idpersona_idx` (`idpersona`),
  KEY `idarticulo_idx` (`idarticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `video`
--

CREATE TABLE IF NOT EXISTS `video` (
  `idproducto` int(11) NOT NULL,
  `trailer` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tituloespanhol` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `duracion` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `titulooriginal` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `idioma` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tiposonido` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `distribuidora` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipovideo` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `calificacionedad` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `relacionaspecto` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `numeroexp` int(11) DEFAULT NULL,
  `fechainiciocalif` date DEFAULT NULL,
  `fechafincalif` date DEFAULT NULL,
  `anho` year(4) DEFAULT NULL,
  PRIMARY KEY (`idproducto`),
  KEY `idproducto_idx` (`idproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `video`
--

INSERT INTO `video` (`idproducto`, `trailer`, `tituloespanhol`, `duracion`, `titulooriginal`, `idioma`, `tiposonido`, `distribuidora`, `tipovideo`, `calificacionedad`, `relacionaspecto`, `numeroexp`, `fechainiciocalif`, `fechafincalif`, `anho`) VALUES
(1, NULL, 'Troya', NULL, 'Troy', 'Inglés', 'Dolby Digital', 'WARNER BROS. ENTERTAINMENT ESPAÑA S.L.', NULL, 'NO RECOM. MENORES DE TRECE AÑOS', NULL, 81795, '0000-00-00', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `videopais`
--

CREATE TABLE IF NOT EXISTS `videopais` (
  `idproducto` int(11) NOT NULL,
  `idpais` int(11) NOT NULL,
  PRIMARY KEY (`idproducto`,`idpais`),
  KEY `idproducto_idx` (`idproducto`),
  KEY `idpais_idx` (`idpais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alquiler`
--
ALTER TABLE `alquiler`
  ADD CONSTRAINT `alquiler_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `alquiler_ibfk_2` FOREIGN KEY (`idcarrito`) REFERENCES `carrito` (`idcarrito`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `alquileroffline`
--
ALTER TABLE `alquileroffline`
  ADD CONSTRAINT `alquileroffline_ibfk_1` FOREIGN KEY (`idalquiler`) REFERENCES `alquiler` (`idalquiler`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `alquileroffline_ibfk_2` FOREIGN KEY (`iddireccion`) REFERENCES `direccion` (`iddireccion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`iddescuento`) REFERENCES `descuento` (`iddescuento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `carritolinea`
--
ALTER TABLE `carritolinea`
  ADD CONSTRAINT `carritolinea_ibfk_1` FOREIGN KEY (`idcarrito`) REFERENCES `carrito` (`idcarrito`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `carritolinea_ibfk_2` FOREIGN KEY (`idejemplar`) REFERENCES `ejemplar` (`idejemplar`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD CONSTRAINT `direccion_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `disco`
--
ALTER TABLE `disco`
  ADD CONSTRAINT `disco_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ejemplar`
--
ALTER TABLE `ejemplar`
  ADD CONSTRAINT `ejemplar_ibfk_1` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `empleado_ibfk_2` FOREIGN KEY (`idpersonasupervisor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `foto`
--
ALTER TABLE `foto`
  ADD CONSTRAINT `foto_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `video` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `foto_aparece`
--
ALTER TABLE `foto_aparece`
  ADD CONSTRAINT `foto_aparece_ibfk_1` FOREIGN KEY (`idfoto`) REFERENCES `foto` (`idfoto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `foto_aparece_ibfk_2` FOREIGN KEY (`idartista`) REFERENCES `artista` (`idartista`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `juego`
--
ALTER TABLE `juego`
  ADD CONSTRAINT `juego_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pack`
--
ALTER TABLE `pack`
  ADD CONSTRAINT `pack_ibfk_1` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pack_contiene`
--
ALTER TABLE `pack_contiene`
  ADD CONSTRAINT `pack_contiene_ibfk_1` FOREIGN KEY (`idpack`) REFERENCES `pack` (`idpack`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `pack_contiene_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pista_disco`
--
ALTER TABLE `pista_disco`
  ADD CONSTRAINT `pista_disco_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `disco` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `pista_disco_ibfk_2` FOREIGN KEY (`idpista`) REFERENCES `pista` (`idpista`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `registro`
--
ALTER TABLE `registro`
  ADD CONSTRAINT `registro_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `reparto`
--
ALTER TABLE `reparto`
  ADD CONSTRAINT `reparto_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `video` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `reparto_ibfk_2` FOREIGN KEY (`idartista`) REFERENCES `artista` (`idartista`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `reparto_ibfk_3` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sesion`
--
ALTER TABLE `sesion`
  ADD CONSTRAINT `sesion_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `telefono`
--
ALTER TABLE `telefono`
  ADD CONSTRAINT `telefono_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `valoracion`
--
ALTER TABLE `valoracion`
  ADD CONSTRAINT `valoracion_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `valoracion_ibfk_2` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `video_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `videopais`
--
ALTER TABLE `videopais`
  ADD CONSTRAINT `idproducto` FOREIGN KEY (`idproducto`) REFERENCES `video` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `videopais_ibfk_1` FOREIGN KEY (`idpais`) REFERENCES `pais` (`idpais`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
