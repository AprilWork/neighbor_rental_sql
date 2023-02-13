-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.16 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for rental
CREATE DATABASE IF NOT EXISTS `rental` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `rental`;

-- Dumping structure for table rental.bill
CREATE TABLE IF NOT EXISTS `bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `renter_id` int(11) DEFAULT '0',
  `rental_id` int(11) DEFAULT '0',
  `period_weeks` int(11) DEFAULT NULL,
  `period_days` int(11) DEFAULT NULL,
  `period_hours` int(11) DEFAULT NULL,
  `period_estimate` double(10,2) DEFAULT NULL,
  `sales_tax` double(2,2) DEFAULT NULL,
  `sales_tax_value` double(10,2) DEFAULT NULL,
  `deposit` double(10,2) DEFAULT NULL,
  `damage_protection` double(10,2) DEFAULT NULL,
  `total_estimate` double(10,2) DEFAULT NULL,
  `total_due_dropoff` double(10,2) DEFAULT NULL,
  `paid` double(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table rental.bill: ~0 rows (approximately)

-- Dumping structure for table rental.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT 'name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table rental.category: ~2 rows (approximately)
REPLACE INTO `category` (`id`, `name`) VALUES
	(1, 'concrete tools'),
	(2, 'Floor Care & Refinishing Rental');

-- Dumping structure for table rental.inventory
CREATE TABLE IF NOT EXISTS `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tool_id` int(11) DEFAULT NULL,
  `available` enum('Y','N') DEFAULT 'Y',
  `rental_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table rental.inventory: ~0 rows (approximately)

-- Dumping structure for table rental.rent
CREATE TABLE IF NOT EXISTS `rent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_id` int(11) NOT NULL DEFAULT '0',
  `customer_id` int(11) DEFAULT '0',
  `pickup` datetime DEFAULT NULL,
  `drop_off` datetime DEFAULT NULL,
  `returned` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table rental.rent: ~0 rows (approximately)

-- Dumping structure for table rental.renter
CREATE TABLE IF NOT EXISTS `renter` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table rental.renter: ~1 rows (approximately)
REPLACE INTO `renter` (`code`, `firstname`, `lastname`) VALUES
	(1, 'Irene', 'First'),
	(2, 'John', 'Second');

-- Dumping structure for table rental.subcategory
CREATE TABLE IF NOT EXISTS `subcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT '1',
  `name` varchar(50) DEFAULT 'name',
  PRIMARY KEY (`id`),
  KEY `FK_subcategory_category` (`category_id`),
  CONSTRAINT `FK_subcategory_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Dumping data for table rental.subcategory: ~5 rows (approximately)
REPLACE INTO `subcategory` (`id`, `category_id`, `name`) VALUES
	(1, 1, 'concrete mixers'),
	(2, 1, 'core drills'),
	(3, 1, 'concrete tools'),
	(4, 1, 'grinders'),
	(5, 1, 'concrete saw'),
	(6, 2, 'Floor Sanders');

-- Dumping structure for table rental.tool
CREATE TABLE IF NOT EXISTS `tool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `subcategory_id` int(11) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `description` text,
  `fair_price_value` decimal(10,2) DEFAULT NULL,
  `price_4hour` decimal(10,2) DEFAULT '5.00',
  `price_day` decimal(10,2) DEFAULT '5.00',
  `price_week` decimal(10,2) DEFAULT '5.00',
  `deposit` decimal(10,2) DEFAULT '5.00',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_tool_subcategory` (`subcategory_id`),
  KEY `FK_tool_category` (`category_id`),
  CONSTRAINT `FK_tool_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tool_subcategory` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategory` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Dumping data for table rental.tool: ~18 rows (approximately)
REPLACE INTO `tool` (`id`, `category_id`, `subcategory_id`, `model`, `description`, `fair_price_value`, `price_4hour`, `price_day`, `price_week`, `deposit`) VALUES
	(1, 1, 1, 'Electric Cement Mixer 3.5 cu. ft.', 'Ideal size for mixing concrete for small to medium size projects around the house. Use to build a backyard BBQ pit, pour a concrete slab for a shed, repair an in-ground pool or set fence posts. Capable of handling drywall mud, plaster, stucco, mortar, concrete and more up to 180 lbs.', NULL, 5.00, 5.00, 5.00, 5.00),
	(2, 1, 1, 'Electric Cement Mixer 6.0 cu. ft.', 'Ideal size for medium to large size projects and can mix up to 320 lbs of concrete. Equipped with a 3/4 HP capacitor start, high torque, brushless electric motor with gear box, 120V, 28RPM to tackle the heaviest jobs. Larger wheels make it durable and portable, even when filled.', NULL, 5.00, 5.00, 5.00, 5.00),
	(3, 1, 1, 'Electric Cement Mixer 10.0 cu. ft.', 'This mixer is ideal for the professional contractor on larger jobs. Mounted on heavy-duty welded steel tubing frame with retracting handles and wide non-flat wheels, this 10 cu. ft. wheelbarrow mixer can be easily transported and maneuvered around the jobsite. The drum is supported by a dual wheel drum guide that is mounted to the frame and turns at 28 rotations per minute. This drum is resistant to dents, cracks and rust, and is easier to clean than a metal drum. This mixer can handle larger loads than other wheelbarrow styled mixers on the market today. The 10 cu. ft. capacity drum holds 600 lbs. of premixed concrete.', NULL, 5.00, 5.00, 5.00, 5.00),
	(7, 1, 3, 'Bull Float', '48" round end magnesium bull float. Equipped with pivoting Worm Gear bracket. Connect additional extension handles as needed for required operating length.', NULL, 5.00, 5.00, 5.00, 5.00),
	(8, 1, 3, 'Concrete Vibrator', 'Ideal for a variety of concrete vibration jobs. Single person operation with carrying strap makes for easy and comfortable use on all jobs. Lightweight and easy plug-in play operation. Plugs into any 110V outlet.', NULL, 5.00, 5.00, 5.00, 5.00),
	(9, 1, 3, 'Rebar Cutter and Bender', 'Rebar cutter/bender provides the user with the ability to quickly cut and bend rebar up to 1/2" thick. The bending function allows for a variety of bends, up to 180 degrees.', NULL, 5.00, 5.00, 5.00, 5.00),
	(10, 1, 5, 'Electric Concrete Saw 14"', 'Ideal for cutting concrete, asphalt, and metal in indoor or enclosed environments. Tool base adjusts allowing up to 5" cutting depth; best for cutting split face block when building retaining walls. Lightweight, less noisy and simpler alternative to gas powered cut-off machines.', NULL, 5.00, 5.00, 5.00, 5.00),
	(11, 1, 5, 'PRO Electric Concrete Saw 12"', 'Perfect for dry cutting in a variety of materials from masonary to metal. Same cutting depth as a 14" blade on a conventional tool, cuts to a depth of 4-3/4" using a 12" blade. Dust control cutting when paired with a dust control vacuum.', NULL, 5.00, 5.00, 5.00, 5.00),
	(12, 1, 5, 'Light-weight Concrete Gas Saw 12"', 'This gas saw offers superior performance, balance and jobsite safety while weighing only 21.7 lbs. Common applications include masonry work, metalwork, laying pavers, landscaping, cutting out openings in brick or concrete walls, road construction and pool work.', NULL, 5.00, 5.00, 5.00, 5.00),
	(13, 1, 5, 'Light-weight Concrete Gas Saw 14"', 'An ideal cutting solution for metal decking, angle iron, i-beams, cast iron pipe, brick/masonry, stone/concrete blocks, railroad rails, road curbs, and asphalt. Engineered for industrial performance but with less weight at only 19.6 lbs. This compact and efficient concrete saw is powered by a 61cc engine with a full 4.4 HP for the most demanding concrete cutting applications. It’s engineered to start easier and vibrate less.', NULL, 5.00, 5.00, 5.00, 5.00),
	(14, 1, 5, 'Walk Behind Concrete Saw 14"', 'Capable of cutting up to 5-1/2" deep using a 14" blade. Ideal for small to medium jobs like parking lots and asphalt roadway repairs. Lightweight, compact machine capable of wet or dry cutting.', NULL, 5.00, 5.00, 5.00, 5.00),
	(15, 1, 2, 'Small Core Drill', 'Diamond core drilling through a variety of base materials up to 5" diameter wet and 6" dry. This versatile tool can be used wet or dry, rig-based or hand held, floor or wall, and a tilt column for 45 degree coring applications. Power control LED helps new users to achieve the optimum rate of drilling progress.', NULL, 5.00, 5.00, 5.00, 5.00),
	(16, 1, 2, 'Large Core Drill', 'Diamond core drilling through a variety of base materials up to 15 3/4" diameter wet. This powerful tool will core wet through floor or wall with a tilt column for 45 degree coring applications. The power control LED helps new users to achieve the optimum rate of drilling progress, making it easy to handle and easy to understand.', NULL, 5.00, 5.00, 5.00, 5.00),
	(17, 1, 4, 'Mini Grinder', 'Ideal for DIY, fabricators, general contractors, concrete prep. Powerful 10.5 AMP motor delivers 11,000 RPM to handle the most demanding applications. Constant speed control applies additional power to product.', NULL, 5.00, 5.00, 5.00, 5.00),
	(18, 1, 4, 'Grinder 7"', 'The Makita 7 in. angle grinder handles cutting and polishing applications including thick woods, metals, stones and concrete. Powered by a 15.0 Amp motor for high output power in a more compact tool (only 7.5 lbs.). The large trigger switch for easy operation and includes lock-on feature. The grinder has a soft start feature for smooth start-ups and is ideal for welders, fabricators, masons, maintenance/repair and more.', NULL, 5.00, 5.00, 5.00, 5.00),
	(19, 1, 4, 'Concrete Grinder 10" w/ Disc', 'Perfect for indoor surface grinding applications, including garage, kitchen, basement or patio. Grinds down concrete high spots, removes sealers and thin mil paints, removes mastics and preps floors to accept new coatings. Conveniently plugs into any standard 110V outlet.', NULL, 5.00, 5.00, 5.00, 5.00),
	(20, 1, 1, 'Towable Cement Mixer', '9 cu. ft. capacity concrete mixer ideal for commercial and home use. Heavy duty axle with 13" tires and axle springs for smooth towing. Large convenient hand wheel provides greater operator control.', NULL, 5.00, 5.00, 5.00, 5.00),
	(21, 1, 1, 'Towable Mortar Mixer', '9 cu. ft. drum volume mortar mixer ideal for commercial and home use. Knee operated drum latch frees the operator\'s hands for smooth dumping. Patented lift guard stays in place while mixing, automatically moves out of the way as mix is discharged for easy operation.', NULL, 5.00, 5.00, 5.00, 5.00),
	(22, 2, 6, 'Radiator/Base Heater Extension Edger', ' Use for wood floor refinishing in hard-to-reach areas such as under cabinets, base board heaters and radiator heaters.', NULL, 5.00, 5.00, 5.00, 5.00);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
