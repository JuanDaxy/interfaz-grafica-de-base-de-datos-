-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.4.3 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para proyecto
CREATE DATABASE IF NOT EXISTS `proyecto` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proyecto`;

-- Volcando estructura para tabla proyecto.despacho
CREATE TABLE IF NOT EXISTS `despacho` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha_despacho` date DEFAULT NULL,
  `nit_tienda` varchar(20) DEFAULT NULL,
  `cedula_empleado` varchar(20) DEFAULT NULL,
  `id_direccion` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_despacho_tienda` (`nit_tienda`),
  KEY `fk_despacho_empleado` (`cedula_empleado`),
  KEY `fk_despacho_direccion` (`id_direccion`),
  CONSTRAINT `fk_despacho_direccion` FOREIGN KEY (`id_direccion`) REFERENCES `direccion_usuario` (`id`),
  CONSTRAINT `fk_despacho_empleado` FOREIGN KEY (`cedula_empleado`) REFERENCES `empleado` (`cedula`),
  CONSTRAINT `fk_despacho_tienda` FOREIGN KEY (`nit_tienda`) REFERENCES `tienda` (`nit`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla proyecto.despacho: ~8 rows (aproximadamente)
INSERT INTO `despacho` (`id`, `fecha_despacho`, `nit_tienda`, `cedula_empleado`, `id_direccion`) VALUES
	(1, '2025-11-16', '900001', '2001', 1),
	(2, '2025-12-11', '900002', '2002', 2),
	(3, '2026-01-09', '900003', '2003', 3),
	(4, '2026-03-21', '900004', '2004', 4),
	(5, '2026-06-06', '900001', '2001', 1),
	(6, '2027-02-15', '900002', '2002', 5),
	(7, '2027-05-01', '900005', '2005', 6),
	(8, '2027-07-12', '900003', '2003', 7),
	(9, '2026-07-13', '900001', '2001', 1),
	(10, '2026-08-04', '900002', '2002', 2),
	(11, '2026-09-19', '900004', '2004', 3),
	(12, '2026-10-06', '900001', '2001', 4),
	(13, '2026-11-22', '900005', '2005', 5),
	(14, '2026-12-02', '900003', '2003', 1),
	(15, '2026-12-16', '900002', '2002', 2);

-- Volcando estructura para tabla proyecto.detalle_pedido
CREATE TABLE IF NOT EXISTS `detalle_pedido` (
  `numero_pedido` int NOT NULL,
  `referencia_producto` varchar(20) NOT NULL,
  `cantidad` int DEFAULT NULL,
  `valor` int DEFAULT NULL,
  `id_despacho` int DEFAULT NULL,
  PRIMARY KEY (`numero_pedido`,`referencia_producto`),
  KEY `fk_detalle_producto` (`referencia_producto`),
  KEY `fk_detalle_despacho` (`id_despacho`),
  CONSTRAINT `fk_detalle_despacho` FOREIGN KEY (`id_despacho`) REFERENCES `despacho` (`id`),
  CONSTRAINT `fk_detalle_pedido` FOREIGN KEY (`numero_pedido`) REFERENCES `pedido` (`numero`),
  CONSTRAINT `fk_detalle_producto` FOREIGN KEY (`referencia_producto`) REFERENCES `producto` (`referencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla proyecto.detalle_pedido: ~12 rows (aproximadamente)
INSERT INTO `detalle_pedido` (`numero_pedido`, `referencia_producto`, `cantidad`, `valor`, `id_despacho`) VALUES
	(101, 'P001', 1, 3500000, 1),
	(101, 'P002', 1, 120000, 1),
	(102, 'P003', 1, 900000, 2),
	(103, 'P004', 1, 250000, 3),
	(104, 'P005', 1, 450000, 4),
	(105, 'P002', 1, 120000, 5),
	(106, 'P006', 1, 1500000, 6),
	(107, 'P007', 1, 650000, 7),
	(108, 'P008', 1, 400000, 8),
	(109, 'P009', 1, 220000, NULL),
	(110, 'P002', 1, 120000, NULL),
	(110, 'P010', 1, 980000, 4),
	(111, 'P013', 1, 320000, 9),
	(112, 'P005', 1, 450000, 10),
	(113, 'P010', 1, 980000, 11),
	(114, 'P009', 1, 220000, 12),
	(115, 'P007', 1, 650000, 13),
	(116, 'P008', 1, 400000, 14),
	(117, 'P006', 1, 1500000, 15),
	(118, 'P002', 1, 120000, NULL);

-- Volcando estructura para tabla proyecto.direccion_usuario
CREATE TABLE IF NOT EXISTS `direccion_usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cedula_usuario` varchar(20) DEFAULT NULL,
  `calle_carrera` varchar(100) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `barrio` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `departamento` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_direccion_usuario` (`cedula_usuario`),
  CONSTRAINT `fk_direccion_usuario` FOREIGN KEY (`cedula_usuario`) REFERENCES `usuario` (`cedula`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla proyecto.direccion_usuario: ~8 rows (aproximadamente)
INSERT INTO `direccion_usuario` (`id`, `cedula_usuario`, `calle_carrera`, `numero`, `barrio`, `ciudad`, `departamento`) VALUES
	(1, '1001', 'Cra 20', '15-10', 'Chapinero', 'Bogotá', 'Cundinamarca'),
	(2, '1002', 'Calle 10', '20-15', 'El Poblado', 'Medellín', 'Antioquia'),
	(3, '1003', 'Av Kevin Angel', '30-20', 'Palermo', 'Manizales', 'Caldas'),
	(4, '1004', 'Cra 5', '12-40', 'San Fernando', 'Cali', 'Valle del Cauca'),
	(5, '1005', 'Calle 50', '80-25', 'Riomar', 'Barranquilla', 'Atlántico'),
	(6, '1006', 'Cra 14', '18-55', 'Cabecera', 'Bucaramanga', 'Santander'),
	(7, '1007', 'Calle 8', '22-11', 'Centro', 'Pereira', 'Risaralda'),
	(8, '1008', 'Av Pedro de Heredia', '90-40', 'Bocagrande', 'Cartagena', 'Bolívar');

-- Volcando estructura para tabla proyecto.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `cedula` varchar(20) NOT NULL,
  `nombre_empleado` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `nit_tienda` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cedula`),
  KEY `fk_empleado_tienda` (`nit_tienda`),
  CONSTRAINT `fk_empleado_tienda` FOREIGN KEY (`nit_tienda`) REFERENCES `tienda` (`nit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla proyecto.empleado: ~5 rows (aproximadamente)
INSERT INTO `empleado` (`cedula`, `nombre_empleado`, `email`, `celular`, `nit_tienda`) VALUES
	('2001', 'Pedro Martinez', 'pedro@tecno.com', '3111111111', '900001'),
	('2002', 'Sofia Ramirez', 'sofia@mega.com', '3222222222', '900002'),
	('2003', 'Daniel Castro', 'daniel@compu.com', '3333333333', '900003'),
	('2004', 'Natalia Rojas', 'natalia@digital.com', '3444444444', '900004'),
	('2005', 'Miguel Torres', 'miguel@electro.com', '3555555555', '900005');

-- Volcando estructura para vista proyecto.informe_ventas_periodo
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `informe_ventas_periodo` (
	`anio` YEAR NULL,
	`mes` INT NULL,
	`total_ventas` DECIMAL(32,0) NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.informe_ventas_producto
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `informe_ventas_producto` (
	`descripcion_producto` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`total_unidades_vendidas` DECIMAL(32,0) NULL,
	`total_ventas` DECIMAL(42,0) NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.informe_ventas_tienda
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `informe_ventas_tienda` (
	`nombre_tienda` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`total_vendido` DECIMAL(42,0) NULL
) ENGINE=MyISAM;

-- Volcando estructura para tabla proyecto.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `numero` int NOT NULL,
  `fecha` date DEFAULT NULL,
  `total_pedido` int DEFAULT NULL,
  `cedula_usuario` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_pedido_usuario` (`cedula_usuario`),
  CONSTRAINT `fk_pedido_usuario` FOREIGN KEY (`cedula_usuario`) REFERENCES `usuario` (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla proyecto.pedido: ~10 rows (aproximadamente)
INSERT INTO `pedido` (`numero`, `fecha`, `total_pedido`, `cedula_usuario`) VALUES
	(101, '2025-11-15', 3620000, '1001'),
	(102, '2025-12-10', 900000, '1002'),
	(103, '2026-01-08', 250000, '1003'),
	(104, '2026-03-20', 450000, '1004'),
	(105, '2026-06-05', 120000, '1001'),
	(106, '2027-02-14', 1500000, '1005'),
	(107, '2027-04-30', 650000, '1006'),
	(108, '2027-07-11', 400000, '1007'),
	(109, '2028-01-22', 220000, '1008'),
	(110, '2028-05-09', 980000, '1002'),
	(111, '2026-07-12', 320000, '1001'),
	(112, '2026-08-03', 450000, '1002'),
	(113, '2026-09-18', 980000, '1003'),
	(114, '2026-10-05', 220000, '1004'),
	(115, '2026-11-21', 650000, '1005'),
	(116, '2026-12-01', 400000, '1001'),
	(117, '2026-12-15', 1500000, '1002'),
	(118, '2026-06-30', 120000, '1006');

-- Volcando estructura para vista proyecto.pedidos_pendientes_despacho
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `pedidos_pendientes_despacho` (
	`numero` INT NOT NULL,
	`fecha` DATE NULL,
	`total_pedido` INT NULL
) ENGINE=MyISAM;

-- Volcando estructura para tabla proyecto.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `referencia` varchar(20) NOT NULL,
  `descripcion_producto` varchar(150) DEFAULT NULL,
  `linea_grupo` varchar(100) DEFAULT NULL,
  `peso` decimal(10,2) DEFAULT NULL,
  `detalles` text,
  `precio` int DEFAULT NULL,
  `garantia` date DEFAULT NULL,
  `costo_compra` int DEFAULT NULL,
  `nit_tienda` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`referencia`),
  KEY `fk_producto_tienda` (`nit_tienda`),
  CONSTRAINT `fk_producto_tienda` FOREIGN KEY (`nit_tienda`) REFERENCES `tienda` (`nit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla proyecto.producto: ~10 rows (aproximadamente)
INSERT INTO `producto` (`referencia`, `descripcion_producto`, `linea_grupo`, `peso`, `detalles`, `precio`, `garantia`, `costo_compra`, `nit_tienda`) VALUES
	('P001', 'Laptop Lenovo', 'Computadores', 2.00, 'Ryzen 7 16GB RAM', 3500000, '2027-12-31', 2800000, '900001'),
	('P002', 'Mouse Logitech', 'Accesorios', 1.00, 'Mouse inalámbrico', 120000, '2026-08-15', 80000, '900001'),
	('P003', 'Monitor Samsung', 'Pantallas', 5.00, 'Monitor 24 pulgadas', 900000, '2027-05-20', 700000, '900002'),
	('P004', 'Teclado Redragon', 'Accesorios', 1.00, 'Teclado mecánico RGB', 250000, '2026-10-10', 180000, '900003'),
	('P005', 'Audifonos Sony', 'Audio', 1.00, 'Cancelación de ruido', 450000, '2027-01-01', 320000, '900004'),
	('P006', 'Tablet Samsung', 'Tablets', 1.00, 'Tablet de 10 pulgadas', 1500000, '2027-09-15', 1200000, '900002'),
	('P007', 'Impresora HP', 'Impresoras', 4.00, 'Impresora multifuncional', 650000, '2026-11-20', 500000, '900005'),
	('P008', 'Disco SSD Kingston', 'Almacenamiento', 1.00, 'SSD 1TB', 400000, '2027-06-30', 300000, '900003'),
	('P009', 'Webcam Logitech', 'Accesorios', 1.00, 'Webcam HD', 220000, '2026-12-12', 150000, '900001'),
	('P010', 'Silla Gamer', 'Muebles', 15.00, 'Silla ergonómica RGB', 980000, '2028-01-01', 750000, '900004'),
	('P011', 'Mouse Pad RGB', 'Accesorios', 1.00, 'Mouse pad gamer con iluminación', 90000, '2027-08-15', 60000, '900001'),
	('P012', 'Microfono HyperX', 'Audio', 2.00, 'Micrófono para streaming USB', 480000, '2028-03-10', 350000, '900002'),
	('P013', 'Router TP-Link', 'Redes', 1.00, 'Router WiFi 6 de alta velocidad', 320000, '2027-11-25', 250000, '900003'),
	('P014', 'Smartwatch Xiaomi', 'Wearables', 1.00, 'Reloj inteligente deportivo', 550000, '2028-06-01', 420000, '900005');

-- Volcando estructura para tabla proyecto.tienda
CREATE TABLE IF NOT EXISTS `tienda` (
  `nit` varchar(20) NOT NULL,
  `nombre_tienda` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla proyecto.tienda: ~5 rows (aproximadamente)
INSERT INTO `tienda` (`nit`, `nombre_tienda`, `direccion`, `telefono`, `email`) VALUES
	('900001', 'TecnoPlus', 'Cra 10 #20-30', '6011111111', 'contacto@tecnoplus.com'),
	('900002', 'MegaStore', 'Calle 85 #15-40', '6042222222', 'ventas@megastore.com'),
	('900003', 'CompuWorld', 'Av Santander #45-20', '6063333333', 'info@compuworld.com'),
	('900004', 'DigitalCenter', 'Cra 50 #12-15', '6024444444', 'soporte@digitalcenter.com'),
	('900005', 'ElectroShop', 'Calle 30 #18-70', '6055555555', 'servicio@electroshop.com');

-- Volcando estructura para tabla proyecto.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `cedula` varchar(20) NOT NULL,
  `nombre_usuario` varchar(100) DEFAULT NULL,
  `telefono_fijo` varchar(20) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla proyecto.usuario: ~8 rows (aproximadamente)
INSERT INTO `usuario` (`cedula`, `nombre_usuario`, `telefono_fijo`, `celular`, `email`) VALUES
	('1001', 'Juan Perez', '6011000001', '3001111111', 'juan@gmail.com'),
	('1002', 'Maria Gomez', '6041000002', '3002222222', 'maria@gmail.com'),
	('1003', 'Carlos Ruiz', '6021000003', '3003333333', 'carlos@gmail.com'),
	('1004', 'Laura Diaz', '6051000004', '3004444444', 'laura@gmail.com'),
	('1005', 'Andres Lopez', '6061000005', '3005555555', 'andres@gmail.com'),
	('1006', 'Camila Torres', '6071000006', '3006666666', 'camila@gmail.com'),
	('1007', 'Santiago Castro', '6081000007', '3007777777', 'santiago@gmail.com'),
	('1008', 'Valentina Rios', '6011000008', '3008888888', 'valentina@gmail.com');

-- Volcando estructura para vista proyecto.vista_empleados_tienda
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_empleados_tienda` (
	`nombre_empleado` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nombre_tienda` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.vista_pedidos_2026
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_pedidos_2026` (
	`numero` INT NOT NULL,
	`fecha` DATE NULL,
	`total_pedido` INT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.vista_pedidos_por_usuario
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_pedidos_por_usuario` (
	`nombre_usuario` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`cantidad_pedidos` BIGINT NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.vista_productos_costosos
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_productos_costosos` (
	`referencia` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`descripcion_producto` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`precio` INT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.vista_productos_no_vendidos
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_productos_no_vendidos` (
	`descripcion_producto` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.vista_productos_por_precio
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_productos_por_precio` (
	`descripcion_producto` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`precio` INT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.vista_productos_por_tienda
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_productos_por_tienda` (
	`nombre_tienda` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`cantidad_productos` BIGINT NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.vista_promedio_precios
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_promedio_precios` (
	`promedio_precios` DECIMAL(14,4) NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.vista_total_gastado_usuario
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_total_gastado_usuario` (
	`nombre_usuario` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`total_gastado` DECIMAL(32,0) NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista proyecto.vista_usuarios_frecuentes
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_usuarios_frecuentes` (
	`nombre_usuario` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`cantidad_pedidos` BIGINT NOT NULL
) ENGINE=MyISAM;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `informe_ventas_periodo`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `informe_ventas_periodo` AS select year(`pedido`.`fecha`) AS `anio`,month(`pedido`.`fecha`) AS `mes`,sum(`pedido`.`total_pedido`) AS `total_ventas` from `pedido` group by year(`pedido`.`fecha`),month(`pedido`.`fecha`) order by `anio`,`mes`;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `informe_ventas_producto`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `informe_ventas_producto` AS select `producto`.`descripcion_producto` AS `descripcion_producto`,sum(`detalle_pedido`.`cantidad`) AS `total_unidades_vendidas`,sum((`detalle_pedido`.`valor` * `detalle_pedido`.`cantidad`)) AS `total_ventas` from (`producto` join `detalle_pedido` on((`producto`.`referencia` = `detalle_pedido`.`referencia_producto`))) group by `producto`.`descripcion_producto`;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `informe_ventas_tienda`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `informe_ventas_tienda` AS select `tienda`.`nombre_tienda` AS `nombre_tienda`,sum((`detalle_pedido`.`valor` * `detalle_pedido`.`cantidad`)) AS `total_vendido` from ((`tienda` join `producto` on((`tienda`.`nit` = `producto`.`nit_tienda`))) join `detalle_pedido` on((`producto`.`referencia` = `detalle_pedido`.`referencia_producto`))) group by `tienda`.`nombre_tienda`;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `pedidos_pendientes_despacho`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `pedidos_pendientes_despacho` AS select `pedido`.`numero` AS `numero`,`pedido`.`fecha` AS `fecha`,`pedido`.`total_pedido` AS `total_pedido` from ((`pedido` join `detalle_pedido` on((`pedido`.`numero` = `detalle_pedido`.`numero_pedido`))) left join `despacho` on((`detalle_pedido`.`id_despacho` = `despacho`.`id`))) where (`despacho`.`fecha_despacho` is null);

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_empleados_tienda`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_empleados_tienda` AS select `empleado`.`nombre_empleado` AS `nombre_empleado`,`tienda`.`nombre_tienda` AS `nombre_tienda` from (`empleado` join `tienda` on((`empleado`.`nit_tienda` = `tienda`.`nit`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_pedidos_2026`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_pedidos_2026` AS select `pedido`.`numero` AS `numero`,`pedido`.`fecha` AS `fecha`,`pedido`.`total_pedido` AS `total_pedido` from `pedido` where (year(`pedido`.`fecha`) = 2026);

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_pedidos_por_usuario`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_pedidos_por_usuario` AS select `usuario`.`nombre_usuario` AS `nombre_usuario`,count(`pedido`.`numero`) AS `cantidad_pedidos` from (`usuario` left join `pedido` on((`usuario`.`cedula` = `pedido`.`cedula_usuario`))) group by `usuario`.`nombre_usuario`;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_productos_costosos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_productos_costosos` AS select `producto`.`referencia` AS `referencia`,`producto`.`descripcion_producto` AS `descripcion_producto`,`producto`.`precio` AS `precio` from `producto` where (`producto`.`precio` > 500000);

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_productos_no_vendidos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_productos_no_vendidos` AS select `producto`.`descripcion_producto` AS `descripcion_producto` from (`producto` left join `detalle_pedido` on((`producto`.`referencia` = `detalle_pedido`.`referencia_producto`))) where (`detalle_pedido`.`referencia_producto` is null);

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_productos_por_precio`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_productos_por_precio` AS select `producto`.`descripcion_producto` AS `descripcion_producto`,`producto`.`precio` AS `precio` from `producto` order by `producto`.`precio` desc;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_productos_por_tienda`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_productos_por_tienda` AS select `tienda`.`nombre_tienda` AS `nombre_tienda`,count(`producto`.`referencia`) AS `cantidad_productos` from (`tienda` left join `producto` on((`tienda`.`nit` = `producto`.`nit_tienda`))) group by `tienda`.`nombre_tienda`;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_promedio_precios`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_promedio_precios` AS select avg(`producto`.`precio`) AS `promedio_precios` from `producto`;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_total_gastado_usuario`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_total_gastado_usuario` AS select `usuario`.`nombre_usuario` AS `nombre_usuario`,sum(`pedido`.`total_pedido`) AS `total_gastado` from (`usuario` join `pedido` on((`usuario`.`cedula` = `pedido`.`cedula_usuario`))) group by `usuario`.`nombre_usuario`;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_usuarios_frecuentes`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_usuarios_frecuentes` AS select `usuario`.`nombre_usuario` AS `nombre_usuario`,count(`pedido`.`numero`) AS `cantidad_pedidos` from (`usuario` join `pedido` on((`usuario`.`cedula` = `pedido`.`cedula_usuario`))) group by `usuario`.`nombre_usuario` having (count(`pedido`.`numero`) > 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
