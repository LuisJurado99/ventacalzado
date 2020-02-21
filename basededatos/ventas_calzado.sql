-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-02-2020 a las 00:57:30
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ventas_calzado`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `inserta_modelo_completo` (IN `pcolor` VARCHAR(15), IN `pmarca` VARCHAR(15), IN `ptipo` VARCHAR(15), IN `pclasificacion` VARCHAR(15), IN `nombre_provedor` VARCHAR(15), IN `telefon_provedor` INT(15), IN `cantidad` INT(5), IN `pnumero` INT(2), IN `pcosto` DECIMAL(5,2))  BEGIN
START TRANSACTION;
INSERT INTO modelotro(color,marca,tipo,clasificacion,numero,costo) VALUES (pcolor,pmarca,ptipo,pclasificacion,pnumero,pcosto); 
INSERT INTO provedor(nombre, telefono) VALUES (nombre_provedor,telefon_provedor);
SET @id_provedor = (SELECT MAX(idprovedor) FROM provedor);
SET @id_modelo = (SELECT MAX(idmodelo) FROM modelotro); 
INSERT INTO almacen(id_modelo,existencia, idproveedor) VALUES (@id_modelo,cantidad,@id_provedor); 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `venta_acto` (IN `id_modelo` INT(5), IN `fecha` VARCHAR(15), IN `monto` DECIMAL(7,2), IN `cnombre` VARCHAR(15), IN `cantidad` INT(2))  BEGIN
DECLARE id_cliente INT(5);
START TRANSACTION;
INSERT INTO cliente(nombre) VALUES (cnombre); 
SET @id_cliente = (SELECT MAX(idcliente) FROM cliente);
INSERT INTO venta(idmodelo,idcliente,monto,fecha) VALUES (id_modelo,@id_cliente,monto,fecha); 
SET @cantidad = (SELECT existencia FROM almacen WHERE almacen.id_modelo=id_modelo);
UPDATE almacen SET almacen.existencia = @cantidad-cantidad WHERE almacen.id_modelo=id_modelo;
COMMIT;
ROLLBACK;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacen`
--

CREATE TABLE `almacen` (
  `id_modelo` int(5) NOT NULL,
  `idproveedor` int(5) NOT NULL,
  `existencia` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `almacen`
--

INSERT INTO `almacen` (`id_modelo`, `idproveedor`, `existencia`) VALUES
(1, 1, 20),
(2, 2, 6),
(3, 3, 30),
(4, 4, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idcliente` int(5) NOT NULL,
  `nombre` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idcliente`, `nombre`) VALUES
(5, 'Abigail'),
(6, 'Cesar'),
(7, 'LUIS'),
(8, 'Irving');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelotro`
--

CREATE TABLE `modelotro` (
  `idmodelo` int(5) NOT NULL,
  `numero` int(2) NOT NULL,
  `color` varchar(15) NOT NULL,
  `marca` varchar(15) NOT NULL,
  `tipo` varchar(15) NOT NULL,
  `clasificacion` varchar(15) NOT NULL,
  `costo` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `modelotro`
--

INSERT INTO `modelotro` (`idmodelo`, `numero`, `color`, `marca`, `tipo`, `clasificacion`, `costo`) VALUES
(1, 23, 'blanco', 'addidas', 'tennis', 'informal', '1999.99'),
(2, 25, 'rojos', 'nike', 'zapatos', 'formal', '1499.99'),
(3, 25, 'rojo', 'puma', 'tennis', 'infromal', '850.00'),
(4, 23, 'rosa', 'panam', 'tennis', 'informal', '700.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provedor`
--

CREATE TABLE `provedor` (
  `idprovedor` int(5) NOT NULL,
  `nombre` varchar(10) NOT NULL,
  `telefono` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `provedor`
--

INSERT INTO `provedor` (`idprovedor`, `nombre`, `telefono`) VALUES
(1, 'Addidas SA', 2147483647),
(2, 'Nike SA', 0),
(3, 'puma SA', 2147483647),
(4, 'panam SA', 33223322);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int(5) NOT NULL,
  `idmodelo` int(5) NOT NULL,
  `idcliente` int(5) NOT NULL,
  `fecha` date NOT NULL,
  `monto` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`idventa`, `idmodelo`, `idcliente`, `fecha`, `monto`) VALUES
(2, 2, 5, '2020-02-19', '300.00'),
(3, 1, 6, '2020-02-20', '150.00'),
(4, 1, 7, '2020-02-04', '7999.96'),
(5, 2, 8, '2020-02-04', '2999.98');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacen`
--
ALTER TABLE `almacen`
  ADD KEY `FK_idproveedro` (`idproveedor`) USING BTREE,
  ADD KEY `id_modelo` (`id_modelo`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idcliente`);

--
-- Indices de la tabla `modelotro`
--
ALTER TABLE `modelotro`
  ADD PRIMARY KEY (`idmodelo`);

--
-- Indices de la tabla `provedor`
--
ALTER TABLE `provedor`
  ADD PRIMARY KEY (`idprovedor`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `idcliente` (`idcliente`),
  ADD KEY `idmodelo` (`idmodelo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idcliente` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `modelotro`
--
ALTER TABLE `modelotro`
  MODIFY `idmodelo` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `provedor`
--
ALTER TABLE `provedor`
  MODIFY `idprovedor` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `almacen`
--
ALTER TABLE `almacen`
  ADD CONSTRAINT `almacen_ibfk_1` FOREIGN KEY (`id_modelo`) REFERENCES `modelotro` (`idmodelo`),
  ADD CONSTRAINT `fk_idprovedor` FOREIGN KEY (`idproveedor`) REFERENCES `provedor` (`idprovedor`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`),
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`idmodelo`) REFERENCES `modelotro` (`idmodelo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
