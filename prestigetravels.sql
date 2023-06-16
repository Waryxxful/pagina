-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-06-2023 a las 10:27:31
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prestigetravels`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacion`
--

CREATE TABLE `calificacion` (
  `id_usuario` int(11) NOT NULL,
  `id_hotel` int(11) DEFAULT NULL,
  `id_paquete` int(11) DEFAULT NULL,
  `calidad_hoteles` int(11) DEFAULT NULL,
  `transporte` int(11) DEFAULT NULL,
  `servicio_paquete` int(11) DEFAULT NULL,
  `precio_calidad` int(11) DEFAULT NULL,
  `limpieza` int(11) DEFAULT NULL,
  `servicio_hotel` int(11) DEFAULT NULL,
  `decoración` int(11) DEFAULT NULL,
  `calidad_camas` int(11) DEFAULT NULL,
  `resena` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `calificacion`
--
DELIMITER $$
CREATE TRIGGER `notNull` AFTER UPDATE ON `calificacion` FOR EACH ROW BEGIN
  IF NEW.id_hotel REGEXP '^[0-9]+$' THEN
    UPDATE calificacion SET limpieza = 'NOT NULL', servicio_hotel = 'NOT NULL', decoración = 'NOT NULL', calidad_camas = 'NOT NULL' WHERE id_hotel = NEW.id_hotel;
  END IF;
  IF NEW.id_paquete REGEXP '^[0-9]+$' THEN
    UPDATE calificacion SET calidad_hoteles = 'NOT NULL', transporte = 'NOT NULL', servicio_paquete = 'NOT NULL', precio_calidad = 'NOT NULL' WHERE id_paquete = NEW.id_paquete;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id_usuario` int(11) NOT NULL,
  `id_hotel` int(11) DEFAULT NULL,
  `id_paquete` int(11) DEFAULT NULL,
  `servicio` varchar(255) NOT NULL,
  `nombre_servicio` varchar(255) NOT NULL,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hoteles`
--

CREATE TABLE `hoteles` (
  `id_hotel` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `id_paquete` int(11) DEFAULT NULL,
  `ciudad` varchar(255) NOT NULL,
  `estrellas` int(11) NOT NULL,
  `precio` int(11) NOT NULL,
  `hab_total` int(11) NOT NULL,
  `hab_dispo` int(11) NOT NULL,
  `estacionamiento` bit(1) NOT NULL,
  `piscina` bit(1) NOT NULL,
  `lavanderia` bit(1) NOT NULL,
  `pet_friendly` bit(1) NOT NULL,
  `desayuno` bit(1) NOT NULL,
  `imagen` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `hoteles`
--

INSERT INTO `hoteles` (`id_hotel`, `nombre`, `id_paquete`, `ciudad`, `estrellas`, `precio`, `hab_total`, `hab_dispo`, `estacionamiento`, `piscina`, `lavanderia`, `pet_friendly`, `desayuno`, `imagen`) VALUES
(1, ' Hoteles Pueblo de Tierra', 1, ' San Pedro de Atacama', 3, 93000, 50, 23, b'1', b'1', b'1', b'1', b'1', '1686165272_pueblo.jpg'),
(2, ' Hotel Almasur', 3, ' Punta Arenas', 4, 60000, 90, 22, b'1', b'1', b'1', b'1', b'1', '1686168524_punta arenas.jpg'),
(3, ' Hotel Altiplánico', 3, 'Puerto Natales', 4, 120000, 43, 19, b'1', b'1', b'1', b'1', b'1', '1686169794_pto-natales.jpg'),
(4, 'Hotel Sheraton Santiago', 2, 'Santiago', 5, 135000, 525, 224, b'1', b'1', b'1', b'1', b'1', '1686170434_sheraton.jpg'),
(5, 'Hotel Marina Villa del Río', 4, 'Valdivia', 4, 80000, 120, 57, b'1', b'1', b'1', b'1', b'1', '1686170724_valdivia.jpg'),
(6, 'Hotel Boutique Cutipay', 4, 'Niebla', 4, 75000, 63, 51, b'1', b'1', b'1', b'1', b'1', '1686170947_niebla.jpg'),
(7, 'Hotel 381', 4, 'Panguipulli', 3, 45000, 38, 19, b'1', b'1', b'1', b'1', b'1', '1686171065_panguipulli.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paquetes`
--

CREATE TABLE `paquetes` (
  `id_paquete` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `cant_personas` int(11) NOT NULL,
  `precio` int(11) NOT NULL,
  `num_total` int(11) NOT NULL,
  `num_dispo` int(11) NOT NULL,
  `noches_totales` int(11) NOT NULL,
  `aero_ida` varchar(255) NOT NULL,
  `aero_vuelta` varchar(255) NOT NULL,
  `fecha_salida` date NOT NULL,
  `fecha_llegada` date NOT NULL,
  `imagen` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paquetes`
--

INSERT INTO `paquetes` (`id_paquete`, `nombre`, `cant_personas`, `precio`, `num_total`, `num_dispo`, `noches_totales`, `aero_ida`, `aero_vuelta`, `fecha_salida`, `fecha_llegada`, `imagen`) VALUES
(1, 'Paquete a Atacama     ', 2, 140000, 150, 23, 4, 'LATAM     ', 'SKY     ', '2024-07-03', '2024-07-07', '1686156971_atacama.jpg'),
(2, 'Disfruta la Capital ', 4, 115000, 130, 101, 3, 'LATAM ', 'LATAM ', '2024-02-15', '2024-02-18', '1686166203_capital.jpg'),
(3, 'A la Patagonia   ', 6, 420000, 200, 88, 5, 'SKY   ', 'JetSmart   ', '2024-01-26', '2024-01-31', '1686167970_patagonia.jpg'),
(4, 'Región de Los Ríos', 2, 230000, 350, 211, 5, 'SKY', 'SKY', '2024-03-01', '2024-03-06', '1686169075_los-rios.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id_usuario` int(11) NOT NULL,
  `id_hotel` int(11) DEFAULT NULL,
  `id_paquete` int(11) DEFAULT NULL,
  `servicio` varchar(255) NOT NULL,
  `nombre_servicio` varchar(255) NOT NULL,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `fecha_nac` date NOT NULL,
  `correo` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `fecha_nac`, `correo`, `password`) VALUES
(1, 'anto', '2023-06-01', 'antonia@gmail.com', '$2y$10$npPqWz8AgL14THPcHt08mumPS6lfPBh0nQ9pbK/Q1OlFf90tWUXvG');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_usuarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_usuarios` (
`id_usuario` int(11)
,`nombre` varchar(255)
,`correo` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wishlist`
--

CREATE TABLE `wishlist` (
  `id_usuario` int(11) NOT NULL,
  `id_hotel` int(11) DEFAULT NULL,
  `id_paquete` int(11) DEFAULT NULL,
  `servicio` varchar(255) NOT NULL,
  `nombre_servicio` varchar(255) NOT NULL,
  `precio` int(11) NOT NULL,
  `estado` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_usuarios`
--
DROP TABLE IF EXISTS `vista_usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_usuarios`  AS SELECT `usuarios`.`id_usuario` AS `id_usuario`, `usuarios`.`nombre` AS `nombre`, `usuarios`.`correo` AS `correo` FROM `usuarios` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_hotel` (`id_hotel`),
  ADD KEY `id_paquete` (`id_paquete`);

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_paquete` (`id_paquete`),
  ADD KEY `id_hotel` (`id_hotel`);

--
-- Indices de la tabla `hoteles`
--
ALTER TABLE `hoteles`
  ADD PRIMARY KEY (`id_hotel`),
  ADD KEY `paquetes_id_paquete_hoteles` (`id_paquete`);

--
-- Indices de la tabla `paquetes`
--
ALTER TABLE `paquetes`
  ADD PRIMARY KEY (`id_paquete`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_hotel` (`id_hotel`),
  ADD KEY `id_paquete` (`id_paquete`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `wishlist`
--
ALTER TABLE `wishlist`
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_hotel` (`id_hotel`),
  ADD KEY `id_paquete` (`id_paquete`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `hoteles`
--
ALTER TABLE `hoteles`
  MODIFY `id_hotel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `paquetes`
--
ALTER TABLE `paquetes`
  MODIFY `id_paquete` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD CONSTRAINT `calificacion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `calificacion_ibfk_2` FOREIGN KEY (`id_hotel`) REFERENCES `hoteles` (`id_hotel`),
  ADD CONSTRAINT `calificacion_ibfk_3` FOREIGN KEY (`id_paquete`) REFERENCES `paquetes` (`id_paquete`);

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`id_paquete`) REFERENCES `paquetes` (`id_paquete`),
  ADD CONSTRAINT `carrito_ibfk_3` FOREIGN KEY (`id_hotel`) REFERENCES `hoteles` (`id_hotel`);

--
-- Filtros para la tabla `hoteles`
--
ALTER TABLE `hoteles`
  ADD CONSTRAINT `paquetes_id_paquete_hoteles` FOREIGN KEY (`id_paquete`) REFERENCES `paquetes` (`id_paquete`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_hotel`) REFERENCES `hoteles` (`id_hotel`),
  ADD CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`id_paquete`) REFERENCES `paquetes` (`id_paquete`);

--
-- Filtros para la tabla `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`id_hotel`) REFERENCES `hoteles` (`id_hotel`),
  ADD CONSTRAINT `wishlist_ibfk_3` FOREIGN KEY (`id_paquete`) REFERENCES `paquetes` (`id_paquete`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
