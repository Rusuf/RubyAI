-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 13, 2025 at 01:10 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `essayhar_ruby`
--

-- --------------------------------------------------------

--
-- Table structure for table `cash_at_hand`
--

CREATE TABLE `cash_at_hand` (
  `the_dates_time` datetime NOT NULL,
  `cash_id` int(11) NOT NULL,
  `cash_loaded` float NOT NULL,
  `cash_taken` float NOT NULL,
  `cash_taken_narration` float NOT NULL,
  `times_edited` int(10) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `cash_at_hand`
--
DELIMITER $$
CREATE TRIGGER `cash_at_hand_sync_trigger_after_delete` AFTER DELETE ON `cash_at_hand` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'cash_at_hand',
      OLD.cash_id,
      'cash_id',
      OLD.cash_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cash_at_hand_sync_trigger_after_insert` AFTER INSERT ON `cash_at_hand` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'cash_at_hand',
      NEW.cash_id,
      'cash_id',
      NEW.cash_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cash_at_hand_sync_trigger_after_update` AFTER UPDATE ON `cash_at_hand` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'cash_at_hand',
      NEW.cash_id,
      'cash_id',
      NEW.cash_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `changed products`
-- (See below for the actual view)
--
CREATE TABLE `changed products` (
`productname` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `complimentary`
--

CREATE TABLE `complimentary` (
  `thedate` datetime DEFAULT NULL,
  `complimentary_id` int(100) NOT NULL,
  `beneficiaryname` varchar(100) NOT NULL,
  `items` varchar(100) NOT NULL,
  `cost` int(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `complimentary`
--
DELIMITER $$
CREATE TRIGGER `complimentary_sync_trigger_after_delete` AFTER DELETE ON `complimentary` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'complimentary',
      OLD.complimentary_id,
      'complimentary_id',
      OLD.complimentary_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `complimentary_sync_trigger_after_insert` AFTER INSERT ON `complimentary` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'complimentary',
      NEW.complimentary_id,
      'complimentary_id',
      NEW.complimentary_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `complimentary_sync_trigger_after_update` AFTER UPDATE ON `complimentary` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'complimentary',
      NEW.complimentary_id,
      'complimentary_id',
      NEW.complimentary_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `credit`
--

CREATE TABLE `credit` (
  `thedate` datetime DEFAULT NULL,
  `todaysdate` date NOT NULL,
  `credit_id` int(100) NOT NULL,
  `receipt_no` int(11) NOT NULL,
  `customername` varchar(100) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `sellingprice` varchar(20) NOT NULL,
  `cost_of_goods` varchar(20) NOT NULL,
  `debtamount` varchar(20) NOT NULL,
  `profit_stalled` varchar(20) NOT NULL,
  `total_cost_excl` float NOT NULL,
  `tax` float NOT NULL,
  `total_debt_amount` varchar(20) NOT NULL,
  `amount_paid` varchar(20) NOT NULL,
  `debt_balance` varchar(20) NOT NULL,
  `sales_rep` varchar(100) NOT NULL,
  `recorded_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `credit`
--
DELIMITER $$
CREATE TRIGGER `credit_sync_trigger_after_delete` AFTER DELETE ON `credit` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'credit',
      OLD.credit_id,
      'credit_id',
      OLD.credit_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `credit_sync_trigger_after_insert` AFTER INSERT ON `credit` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'credit',
      NEW.credit_id,
      'credit_id',
      NEW.credit_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `credit_sync_trigger_after_update` AFTER UPDATE ON `credit` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'credit',
      NEW.credit_id,
      'credit_id',
      NEW.credit_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `registered_on` datetime NOT NULL,
  `name` varchar(100) NOT NULL,
  `id_number` varchar(100) NOT NULL,
  `phone_number` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'Active',
  `overpayment_amount` float NOT NULL,
  `loyalty_points` varchar(20) NOT NULL,
  `redeemed_on` date NOT NULL,
  `edited_by` varchar(100) NOT NULL,
  `date_edited` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `customers_sync_trigger_after_delete` AFTER DELETE ON `customers` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'customers',
      OLD.customer_id,
      'customer_id',
      OLD.customer_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `customers_sync_trigger_after_insert` AFTER INSERT ON `customers` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'customers',
      NEW.customer_id,
      'customer_id',
      NEW.customer_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `customers_sync_trigger_after_update` AFTER UPDATE ON `customers` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'customers',
      NEW.customer_id,
      'customer_id',
      NEW.customer_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `damaged_products`
--

CREATE TABLE `damaged_products` (
  `thedate` datetime NOT NULL,
  `damage_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `quantity` varchar(11) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `cost_incl` varchar(11) NOT NULL,
  `total_cost_excl` varchar(11) NOT NULL,
  `tax_rate` varchar(11) NOT NULL,
  `tax` varchar(11) NOT NULL,
  `total_cost_incl` varchar(11) NOT NULL,
  `sales_rep` varchar(20) NOT NULL,
  `cashier` varchar(20) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `damaged_products`
--
DELIMITER $$
CREATE TRIGGER `damaged_products_sync_trigger_after_delete` AFTER DELETE ON `damaged_products` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'damaged_products',
      OLD.damage_id,
      'damage_id',
      OLD.damage_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `damaged_products_sync_trigger_after_insert` AFTER INSERT ON `damaged_products` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'damaged_products',
      NEW.damage_id,
      'damage_id',
      NEW.damage_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `damaged_products_sync_trigger_after_update` AFTER UPDATE ON `damaged_products` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'damaged_products',
      NEW.damage_id,
      'damage_id',
      NEW.damage_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `damaged_products_invoices`
--

CREATE TABLE `damaged_products_invoices` (
  `invoice_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `date_today` datetime NOT NULL,
  `date` date NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `total_cost_excl` float NOT NULL,
  `tax` float NOT NULL,
  `total_cost_incl` float NOT NULL,
  `last_edited_on` datetime NOT NULL,
  `last_edited_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `damaged_products_invoices`
--
DELIMITER $$
CREATE TRIGGER `damaged_products_invoices_sync_trigger_after_delete` AFTER DELETE ON `damaged_products_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'damaged_products_invoices',
      OLD.invoice_id,
      'invoice_id',
      OLD.invoice_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `damaged_products_invoices_sync_trigger_after_insert` AFTER INSERT ON `damaged_products_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'damaged_products_invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `damaged_products_invoices_sync_trigger_after_update` AFTER UPDATE ON `damaged_products_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'damaged_products_invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dispatched_order_delete_log`
--

CREATE TABLE `dispatched_order_delete_log` (
  `delete_id` int(11) NOT NULL,
  `time_voided` datetime NOT NULL,
  `dispatch_no` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `quantity` float DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `dispatch_date` date DEFAULT NULL,
  `voided_by` varchar(100) DEFAULT NULL,
  `void_reason` text DEFAULT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `dispatched_order_delete_log`
--
DELIMITER $$
CREATE TRIGGER `dispatched_order_delete_log_sync_trigger_after_delete` AFTER DELETE ON `dispatched_order_delete_log` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'dispatched_order_delete_log',
      OLD.delete_id,
      'delete_id',
      OLD.delete_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `dispatched_order_delete_log_sync_trigger_after_insert` AFTER INSERT ON `dispatched_order_delete_log` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'dispatched_order_delete_log',
      NEW.delete_id,
      'delete_id',
      NEW.delete_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `dispatched_order_delete_log_sync_trigger_after_update` AFTER UPDATE ON `dispatched_order_delete_log` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'dispatched_order_delete_log',
      NEW.delete_id,
      'delete_id',
      NEW.delete_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dispatch_log`
--

CREATE TABLE `dispatch_log` (
  `dispatch_id` int(11) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `received_by` varchar(100) DEFAULT NULL,
  `dispatch_no` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `quantity` float DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `dispatch_date` datetime DEFAULT NULL,
  `dispatched_by` varchar(100) NOT NULL,
  `last_edited_on` datetime DEFAULT NULL,
  `last_editor` varchar(50) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `dispatch_log`
--
DELIMITER $$
CREATE TRIGGER `dispatch_log_sync_trigger_after_delete` AFTER DELETE ON `dispatch_log` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'dispatch_log',
      OLD.dispatch_id,
      'dispatch_id',
      OLD.dispatch_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `dispatch_log_sync_trigger_after_insert` AFTER INSERT ON `dispatch_log` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'dispatch_log',
      NEW.dispatch_id,
      'dispatch_id',
      NEW.dispatch_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `dispatch_log_sync_trigger_after_update` AFTER UPDATE ON `dispatch_log` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'dispatch_log',
      NEW.dispatch_id,
      'dispatch_id',
      NEW.dispatch_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employees_departments`
--

CREATE TABLE `employees_departments` (
  `department_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `date_modified` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `employees_departments`
--
DELIMITER $$
CREATE TRIGGER `employees_departments_sync_trigger_after_delete` AFTER DELETE ON `employees_departments` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'employees_departments',
      OLD.department_id,
      'department_id',
      OLD.department_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `employees_departments_sync_trigger_after_insert` AFTER INSERT ON `employees_departments` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'employees_departments',
      NEW.department_id,
      'department_id',
      NEW.department_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `employees_departments_sync_trigger_after_update` AFTER UPDATE ON `employees_departments` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'employees_departments',
      NEW.department_id,
      'department_id',
      NEW.department_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `essential_supplies`
--

CREATE TABLE `essential_supplies` (
  `thedate` datetime NOT NULL,
  `essential_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `essential_code` varchar(100) NOT NULL,
  `essential_name` varchar(100) NOT NULL,
  `buyingprice` varchar(20) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `total_cost_incl` varchar(100) NOT NULL,
  `current_stock` varchar(20) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `added_by` varchar(100) NOT NULL,
  `purchase_order_status` int(11) NOT NULL,
  `inventory_type` varchar(50) NOT NULL DEFAULT 'Inventory',
  `inventory_status` varchar(20) NOT NULL DEFAULT 'Active',
  `restock_level` int(11) NOT NULL DEFAULT 4,
  `restock_quantity` int(11) NOT NULL DEFAULT 4,
  `received_by` varchar(50) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `essential_supplies`
--
DELIMITER $$
CREATE TRIGGER `essential_supplies_sync_trigger_after_delete` AFTER DELETE ON `essential_supplies` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'essential_supplies',
      OLD.essential_id,
      'essential_id',
      OLD.essential_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `essential_supplies_sync_trigger_after_insert` AFTER INSERT ON `essential_supplies` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'essential_supplies',
      NEW.essential_id,
      'essential_id',
      NEW.essential_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `essential_supplies_sync_trigger_after_update` AFTER UPDATE ON `essential_supplies` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'essential_supplies',
      NEW.essential_id,
      'essential_id',
      NEW.essential_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `essential_supplies_invoices`
--

CREATE TABLE `essential_supplies_invoices` (
  `invoice_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `date_today` datetime NOT NULL,
  `date` date NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `total_cost_excl` float NOT NULL,
  `tax` float NOT NULL,
  `total_cost_incl` float NOT NULL,
  `last_edited_on` datetime NOT NULL,
  `last_edited_by` varchar(100) NOT NULL,
  `received_by` varchar(50) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `essential_supplies_invoices`
--
DELIMITER $$
CREATE TRIGGER `essential_supplies_invoices_sync_trigger_after_delete` AFTER DELETE ON `essential_supplies_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'essential_supplies_invoices',
      OLD.invoice_id,
      'invoice_id',
      OLD.invoice_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `essential_supplies_invoices_sync_trigger_after_insert` AFTER INSERT ON `essential_supplies_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'essential_supplies_invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `essential_supplies_invoices_sync_trigger_after_update` AFTER UPDATE ON `essential_supplies_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'essential_supplies_invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `thedate` datetime DEFAULT NULL,
  `expense_id` int(100) NOT NULL,
  `expense_name` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `amountspend` float NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `expenses`
--
DELIMITER $$
CREATE TRIGGER `expenses_sync_trigger_after_delete` AFTER DELETE ON `expenses` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expenses',
      OLD.expense_id,
      'expense_id',
      OLD.expense_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `expenses_sync_trigger_after_insert` AFTER INSERT ON `expenses` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expenses',
      NEW.expense_id,
      'expense_id',
      NEW.expense_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `expenses_sync_trigger_after_update` AFTER UPDATE ON `expenses` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expenses',
      NEW.expense_id,
      'expense_id',
      NEW.expense_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `expense_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `category` varchar(100) NOT NULL,
  `date_modified` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `expense_categories`
--
DELIMITER $$
CREATE TRIGGER `expense_categories_sync_trigger_after_delete` AFTER DELETE ON `expense_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expense_categories',
      OLD.expense_id,
      'expense_id',
      OLD.expense_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `expense_categories_sync_trigger_after_insert` AFTER INSERT ON `expense_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expense_categories',
      NEW.expense_id,
      'expense_id',
      NEW.expense_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `expense_categories_sync_trigger_after_update` AFTER UPDATE ON `expense_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expense_categories',
      NEW.expense_id,
      'expense_id',
      NEW.expense_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `expired_products`
--

CREATE TABLE `expired_products` (
  `thedate` datetime NOT NULL,
  `expiry_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `quantity` varchar(11) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `cost_incl` varchar(11) NOT NULL,
  `total_cost_excl` varchar(11) NOT NULL,
  `tax_rate` varchar(11) NOT NULL,
  `tax` varchar(11) NOT NULL,
  `total_cost_incl` varchar(11) NOT NULL,
  `sales_rep` varchar(20) NOT NULL,
  `cashier` varchar(20) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `expired_products`
--
DELIMITER $$
CREATE TRIGGER `expired_products_sync_trigger_after_delete` AFTER DELETE ON `expired_products` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expired_products',
      OLD.expiry_id,
      'expiry_id',
      OLD.expiry_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `expired_products_sync_trigger_after_insert` AFTER INSERT ON `expired_products` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expired_products',
      NEW.expiry_id,
      'expiry_id',
      NEW.expiry_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `expired_products_sync_trigger_after_update` AFTER UPDATE ON `expired_products` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expired_products',
      NEW.expiry_id,
      'expiry_id',
      NEW.expiry_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `expired_products_invoices`
--

CREATE TABLE `expired_products_invoices` (
  `invoice_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `date_today` datetime NOT NULL,
  `date` date NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `total_cost_excl` float NOT NULL,
  `tax` float NOT NULL,
  `total_cost_incl` float NOT NULL,
  `last_edited_on` datetime NOT NULL,
  `last_edited_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `expired_products_invoices`
--
DELIMITER $$
CREATE TRIGGER `expired_products_invoices_sync_trigger_after_delete` AFTER DELETE ON `expired_products_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expired_products_invoices',
      OLD.invoice_id,
      'invoice_id',
      OLD.invoice_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `expired_products_invoices_sync_trigger_after_insert` AFTER INSERT ON `expired_products_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expired_products_invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `expired_products_invoices_sync_trigger_after_update` AFTER UPDATE ON `expired_products_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'expired_products_invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `thedate` datetime NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `ingredient_code` varchar(100) NOT NULL,
  `ingredient_name` varchar(100) NOT NULL,
  `buyingprice` varchar(20) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `total_cost_incl` varchar(100) NOT NULL,
  `current_stock` varchar(20) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `added_by` varchar(100) NOT NULL,
  `purchase_order_status` int(11) NOT NULL,
  `inventory_type` varchar(50) NOT NULL DEFAULT 'Inventory',
  `inventory_status` varchar(20) NOT NULL DEFAULT 'Active',
  `restock_level` int(10) NOT NULL DEFAULT 4,
  `restock_quantity` int(10) NOT NULL DEFAULT 4,
  `received_by` varchar(50) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `ingredients`
--
DELIMITER $$
CREATE TRIGGER `ingredients_sync_trigger_after_delete` AFTER DELETE ON `ingredients` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'ingredients',
      OLD.ingredient_id,
      'ingredient_id',
      OLD.ingredient_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ingredients_sync_trigger_after_insert` AFTER INSERT ON `ingredients` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'ingredients',
      NEW.ingredient_id,
      'ingredient_id',
      NEW.ingredient_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ingredients_sync_trigger_after_update` AFTER UPDATE ON `ingredients` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'ingredients',
      NEW.ingredient_id,
      'ingredient_id',
      NEW.ingredient_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ingredients_invoices`
--

CREATE TABLE `ingredients_invoices` (
  `invoice_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `date_today` datetime NOT NULL,
  `date` date NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `total_cost_excl` float NOT NULL,
  `tax` float NOT NULL,
  `total_cost_incl` float NOT NULL,
  `last_edited_on` datetime NOT NULL,
  `last_edited_by` varchar(100) NOT NULL,
  `received_by` varchar(50) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `ingredients_invoices`
--
DELIMITER $$
CREATE TRIGGER `ingredients_invoices_sync_trigger_after_delete` AFTER DELETE ON `ingredients_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'ingredients_invoices',
      OLD.invoice_id,
      'invoice_id',
      OLD.invoice_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ingredients_invoices_sync_trigger_after_insert` AFTER INSERT ON `ingredients_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'ingredients_invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ingredients_invoices_sync_trigger_after_update` AFTER UPDATE ON `ingredients_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'ingredients_invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `client_name` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `date_today` datetime NOT NULL,
  `date` date NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `total_cost_excl` float NOT NULL,
  `tax` float NOT NULL,
  `total_cost_incl` float NOT NULL,
  `received_by` varchar(50) NOT NULL,
  `last_edited_on` datetime NOT NULL,
  `last_edited_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `invoices`
--
DELIMITER $$
CREATE TRIGGER `invoices_sync_trigger_after_delete` AFTER DELETE ON `invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'invoices',
      OLD.invoice_id,
      'invoice_id',
      OLD.invoice_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `invoices_sync_trigger_after_insert` AFTER INSERT ON `invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `invoices_sync_trigger_after_update` AFTER UPDATE ON `invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'invoices',
      NEW.invoice_id,
      'invoice_id',
      NEW.invoice_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `log_table_sync_change`
--

CREATE TABLE `log_table_sync_change` (
  `id` int(11) NOT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `row_id` int(11) NOT NULL,
  `primary_key_column` varchar(100) DEFAULT NULL,
  `primary_key_value` varchar(100) DEFAULT NULL,
  `change_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `change_time` datetime DEFAULT current_timestamp(),
  `status` enum('pending','synced') DEFAULT 'pending',
  `synced_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maximum_discount_rate`
--

CREATE TABLE `maximum_discount_rate` (
  `discount_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `discount_rate` varchar(5) NOT NULL,
  `added_by` varchar(100) NOT NULL,
  `date_edited` datetime NOT NULL,
  `edited_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `maximum_discount_rate`
--
DELIMITER $$
CREATE TRIGGER `maximum_discount_rate_sync_trigger_after_delete` AFTER DELETE ON `maximum_discount_rate` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'maximum_discount_rate',
      OLD.discount_id,
      'discount_id',
      OLD.discount_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `maximum_discount_rate_sync_trigger_after_insert` AFTER INSERT ON `maximum_discount_rate` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'maximum_discount_rate',
      NEW.discount_id,
      'discount_id',
      NEW.discount_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `maximum_discount_rate_sync_trigger_after_update` AFTER UPDATE ON `maximum_discount_rate` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'maximum_discount_rate',
      NEW.discount_id,
      'discount_id',
      NEW.discount_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mpesa`
--

CREATE TABLE `mpesa` (
  `the_date` date NOT NULL,
  `thedates_time` datetime NOT NULL,
  `last_edited` datetime NOT NULL,
  `mpesa_id` int(100) NOT NULL,
  `mpesa_float` float NOT NULL,
  `mpesa_cash` float NOT NULL,
  `mpesa_cash_float_taken` varchar(10) NOT NULL,
  `mpesa_taken_narration` varchar(100) NOT NULL,
  `fuliza_cash` float NOT NULL,
  `fuliza_float` float NOT NULL,
  `fuliza_taken` float NOT NULL,
  `fuliza_taken_narration` varchar(100) NOT NULL,
  `times_edited` int(11) NOT NULL,
  `user` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `mpesa`
--
DELIMITER $$
CREATE TRIGGER `mpesa_sync_trigger_after_delete` AFTER DELETE ON `mpesa` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'mpesa',
      OLD.mpesa_id,
      'mpesa_id',
      OLD.mpesa_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `mpesa_sync_trigger_after_insert` AFTER INSERT ON `mpesa` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'mpesa',
      NEW.mpesa_id,
      'mpesa_id',
      NEW.mpesa_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `mpesa_sync_trigger_after_update` AFTER UPDATE ON `mpesa` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'mpesa',
      NEW.mpesa_id,
      'mpesa_id',
      NEW.mpesa_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `opening_balance`
--

CREATE TABLE `opening_balance` (
  `transaction_id` int(10) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `amount` varchar(12) NOT NULL,
  `times_edited` int(11) NOT NULL,
  `edited_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `opening_balance`
--
DELIMITER $$
CREATE TRIGGER `opening_balance_sync_trigger_after_delete` AFTER DELETE ON `opening_balance` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'opening_balance',
      OLD.transaction_id,
      'transaction_id',
      OLD.transaction_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `opening_balance_sync_trigger_after_insert` AFTER INSERT ON `opening_balance` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'opening_balance',
      NEW.transaction_id,
      'transaction_id',
      NEW.transaction_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `opening_balance_sync_trigger_after_update` AFTER UPDATE ON `opening_balance` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'opening_balance',
      NEW.transaction_id,
      'transaction_id',
      NEW.transaction_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `proudct_id` varchar(55) NOT NULL,
  `product_name` varchar(55) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_qty` int(11) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `orders_sync_trigger_after_delete` AFTER DELETE ON `orders` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'orders',
      OLD.id,
      'id',
      OLD.id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `orders_sync_trigger_after_insert` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'orders',
      NEW.id,
      'id',
      NEW.id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `orders_sync_trigger_after_update` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'orders',
      NEW.id,
      'id',
      NEW.id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_temp`
--

CREATE TABLE `password_reset_temp` (
  `email` varchar(250) NOT NULL,
  `key` varchar(250) NOT NULL,
  `expDate` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pettycash`
--

CREATE TABLE `pettycash` (
  `pettycash_id` int(11) NOT NULL,
  `date_loaded` date NOT NULL,
  `amount` float NOT NULL,
  `balance` float NOT NULL,
  `edited_on` varchar(100) NOT NULL,
  `edited_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `pettycash`
--
DELIMITER $$
CREATE TRIGGER `pettycash_sync_trigger_after_delete` AFTER DELETE ON `pettycash` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'pettycash',
      OLD.pettycash_id,
      'pettycash_id',
      OLD.pettycash_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pettycash_sync_trigger_after_insert` AFTER INSERT ON `pettycash` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'pettycash',
      NEW.pettycash_id,
      'pettycash_id',
      NEW.pettycash_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pettycash_sync_trigger_after_update` AFTER UPDATE ON `pettycash` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'pettycash',
      NEW.pettycash_id,
      'pettycash_id',
      NEW.pettycash_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `postpaid_sales`
--

CREATE TABLE `postpaid_sales` (
  `thedate` datetime DEFAULT NULL,
  `thedates` date DEFAULT NULL,
  `sale_id` int(100) NOT NULL,
  `receipt_no` int(11) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `quantity` float NOT NULL,
  `unit` varchar(20) NOT NULL,
  `comments` varchar(100) NOT NULL,
  `buyingprice` varchar(20) NOT NULL,
  `sellingprice` float NOT NULL,
  `discount_rate` varchar(20) DEFAULT NULL,
  `discount_amount` varchar(20) NOT NULL,
  `total_cost_excl` varchar(20) NOT NULL,
  `tax_rate` varchar(20) NOT NULL,
  `tax` varchar(100) NOT NULL,
  `totalsales` float NOT NULL,
  `cost_of_goods_sold` float DEFAULT NULL,
  `profit` float DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `customer` varchar(100) NOT NULL,
  `sales_rep` varchar(100) NOT NULL,
  `chef` varchar(100) NOT NULL,
  `action_status` varchar(20) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `postpaid_sales`
--
DELIMITER $$
CREATE TRIGGER `postpaid_sales_sync_trigger_after_delete` AFTER DELETE ON `postpaid_sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'postpaid_sales',
      OLD.sale_id,
      'sale_id',
      OLD.sale_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `postpaid_sales_sync_trigger_after_insert` AFTER INSERT ON `postpaid_sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'postpaid_sales',
      NEW.sale_id,
      'sale_id',
      NEW.sale_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `postpaid_sales_sync_trigger_after_update` AFTER UPDATE ON `postpaid_sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'postpaid_sales',
      NEW.sale_id,
      'sale_id',
      NEW.sale_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `thedate` datetime NOT NULL,
  `product_id` int(100) NOT NULL,
  `inventory_type` varchar(50) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `ProductImage` varchar(1000) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `cost_price_excl` varchar(10) NOT NULL,
  `buyingprice` varchar(20) NOT NULL,
  `sellingprice` varchar(20) NOT NULL,
  `amountspend` varchar(20) NOT NULL,
  `expectedsales` varchar(20) NOT NULL,
  `expectedprofit` varchar(20) NOT NULL,
  `tax_rate` varchar(10) NOT NULL DEFAULT '16%',
  `department` varchar(100) NOT NULL DEFAULT 'Uncategorized',
  `category` varchar(100) NOT NULL DEFAULT 'Uncategorized',
  `unit` varchar(100) NOT NULL,
  `purchase_order_status` tinyint(10) NOT NULL,
  `today_spent` varchar(20) NOT NULL,
  `today_expected_sales` varchar(20) NOT NULL,
  `today_profit` varchar(20) NOT NULL,
  `used_stock` varchar(20) NOT NULL,
  `additional_stock` varchar(20) NOT NULL,
  `current_stock` varchar(100) NOT NULL,
  `shift_stock_fed` varchar(100) NOT NULL,
  `shift_current_stock` varchar(10) NOT NULL,
  `closed_shift_stock_approved` varchar(100) NOT NULL,
  `times_shift_stock_approved` int(10) NOT NULL,
  `times_approved` int(10) NOT NULL,
  `last_updated` datetime NOT NULL,
  `status` varchar(100) NOT NULL,
  `inventory_status` varchar(100) NOT NULL,
  `stock_lastly_adjusted_on` datetime NOT NULL,
  `today_date` date NOT NULL,
  `added_by` varchar(100) NOT NULL,
  `lastly_adjusted_by` varchar(100) NOT NULL,
  `product_code2` varchar(100) NOT NULL,
  `product_code3` varchar(100) NOT NULL,
  `product_code4` varchar(100) NOT NULL,
  `product_code5` varchar(100) NOT NULL,
  `restock_level` int(10) NOT NULL DEFAULT 4,
  `restock_quantity` int(10) NOT NULL DEFAULT 4,
  `received_by` varchar(50) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `products_sync_trigger_after_delete` AFTER DELETE ON `products` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products',
      OLD.product_id,
      'product_id',
      OLD.product_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_sync_trigger_after_insert` AFTER INSERT ON `products` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products',
      NEW.product_id,
      'product_id',
      NEW.product_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_sync_trigger_after_update` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products',
      NEW.product_id,
      'product_id',
      NEW.product_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products_categories`
--

CREATE TABLE `products_categories` (
  `category_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `parent_category` varchar(20) NOT NULL DEFAULT 'Uncategorized',
  `date_modified` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `products_categories`
--
DELIMITER $$
CREATE TRIGGER `products_categories_sync_trigger_after_delete` AFTER DELETE ON `products_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_categories',
      OLD.category_id,
      'category_id',
      OLD.category_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_categories_sync_trigger_after_insert` AFTER INSERT ON `products_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_categories',
      NEW.category_id,
      'category_id',
      NEW.category_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_categories_sync_trigger_after_update` AFTER UPDATE ON `products_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_categories',
      NEW.category_id,
      'category_id',
      NEW.category_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products_departments`
--

CREATE TABLE `products_departments` (
  `department_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `date_modified` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `products_departments`
--
DELIMITER $$
CREATE TRIGGER `products_departments_sync_trigger_after_delete` AFTER DELETE ON `products_departments` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_departments',
      OLD.department_id,
      'department_id',
      OLD.department_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_departments_sync_trigger_after_insert` AFTER INSERT ON `products_departments` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_departments',
      NEW.department_id,
      'department_id',
      NEW.department_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_departments_sync_trigger_after_update` AFTER UPDATE ON `products_departments` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_departments',
      NEW.department_id,
      'department_id',
      NEW.department_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products_parent_categories`
--

CREATE TABLE `products_parent_categories` (
  `parent_category_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `parent_category_name` varchar(100) NOT NULL,
  `date_modified` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `products_parent_categories`
--
DELIMITER $$
CREATE TRIGGER `products_parent_categories_sync_trigger_after_delete` AFTER DELETE ON `products_parent_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_parent_categories',
      OLD.parent_category_id,
      'parent_category_id',
      OLD.parent_category_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_parent_categories_sync_trigger_after_insert` AFTER INSERT ON `products_parent_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_parent_categories',
      NEW.parent_category_id,
      'parent_category_id',
      NEW.parent_category_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_parent_categories_sync_trigger_after_update` AFTER UPDATE ON `products_parent_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_parent_categories',
      NEW.parent_category_id,
      'parent_category_id',
      NEW.parent_category_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products_units`
--

CREATE TABLE `products_units` (
  `unit_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `unit` varchar(100) NOT NULL,
  `date_modified` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `products_units`
--
DELIMITER $$
CREATE TRIGGER `products_units_sync_trigger_after_delete` AFTER DELETE ON `products_units` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_units',
      OLD.unit_id,
      'unit_id',
      OLD.unit_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_units_sync_trigger_after_insert` AFTER INSERT ON `products_units` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_units',
      NEW.unit_id,
      'unit_id',
      NEW.unit_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `products_units_sync_trigger_after_update` AFTER UPDATE ON `products_units` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'products_units',
      NEW.unit_id,
      'unit_id',
      NEW.unit_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `purchased_essential_supplies`
--

CREATE TABLE `purchased_essential_supplies` (
  `thedate` datetime NOT NULL,
  `essential_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `essential_code` varchar(100) NOT NULL,
  `essential_name` varchar(100) NOT NULL,
  `buyingprice` varchar(20) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `total_cost_incl` varchar(100) NOT NULL,
  `current_stock` varchar(20) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `added_by` varchar(100) NOT NULL,
  `received_by` varchar(50) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `purchased_essential_supplies`
--
DELIMITER $$
CREATE TRIGGER `purchased_essential_supplies_sync_trigger_after_delete` AFTER DELETE ON `purchased_essential_supplies` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchased_essential_supplies',
      OLD.essential_id,
      'essential_id',
      OLD.essential_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchased_essential_supplies_sync_trigger_after_insert` AFTER INSERT ON `purchased_essential_supplies` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchased_essential_supplies',
      NEW.essential_id,
      'essential_id',
      NEW.essential_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchased_essential_supplies_sync_trigger_after_update` AFTER UPDATE ON `purchased_essential_supplies` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchased_essential_supplies',
      NEW.essential_id,
      'essential_id',
      NEW.essential_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `purchased_ingredients`
--

CREATE TABLE `purchased_ingredients` (
  `thedate` datetime NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `ingredient_code` varchar(100) NOT NULL,
  `ingredient_name` varchar(100) NOT NULL,
  `buyingprice` varchar(20) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `total_cost_incl` varchar(100) NOT NULL,
  `current_stock` varchar(20) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `added_by` varchar(100) NOT NULL,
  `received_by` varchar(50) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `purchased_ingredients`
--
DELIMITER $$
CREATE TRIGGER `purchased_ingredients_sync_trigger_after_delete` AFTER DELETE ON `purchased_ingredients` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchased_ingredients',
      OLD.ingredient_id,
      'ingredient_id',
      OLD.ingredient_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchased_ingredients_sync_trigger_after_insert` AFTER INSERT ON `purchased_ingredients` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchased_ingredients',
      NEW.ingredient_id,
      'ingredient_id',
      NEW.ingredient_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchased_ingredients_sync_trigger_after_update` AFTER UPDATE ON `purchased_ingredients` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchased_ingredients',
      NEW.ingredient_id,
      'ingredient_id',
      NEW.ingredient_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `purchased_order`
--

CREATE TABLE `purchased_order` (
  `thedate` datetime DEFAULT NULL,
  `invoice_id` int(10) NOT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `product_id` int(100) NOT NULL,
  `product_code` varchar(100) DEFAULT NULL,
  `productname` varchar(100) NOT NULL,
  `ProductImage` varchar(1000) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `unit` varchar(100) NOT NULL,
  `cost_price_excl` varchar(10) NOT NULL,
  `previous_buyingprice` float NOT NULL,
  `buyingprice` varchar(20) NOT NULL,
  `sellingprice` varchar(20) DEFAULT NULL,
  `total_cost_excl` varchar(20) NOT NULL,
  `tax_rate` varchar(10) NOT NULL,
  `amountspend` varchar(20) NOT NULL,
  `expectedsales` varchar(20) DEFAULT NULL,
  `expectedprofit` varchar(20) NOT NULL,
  `current_stock` varchar(20) DEFAULT NULL,
  `shift_current_stock` varchar(10) DEFAULT NULL,
  `shift_stock_fed` varchar(100) NOT NULL,
  `shift_stock_difference` float NOT NULL,
  `closed_shift_stock_approved` varchar(100) NOT NULL,
  `times_shift_stock_approved` int(10) NOT NULL,
  `received_by` varchar(20) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `purchased_order`
--
DELIMITER $$
CREATE TRIGGER `purchased_order_sync_trigger_after_delete` AFTER DELETE ON `purchased_order` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchased_order',
      OLD.product_id,
      'product_id',
      OLD.product_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchased_order_sync_trigger_after_insert` AFTER INSERT ON `purchased_order` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchased_order',
      NEW.product_id,
      'product_id',
      NEW.product_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchased_order_sync_trigger_after_update` AFTER UPDATE ON `purchased_order` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchased_order',
      NEW.product_id,
      'product_id',
      NEW.product_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order`
--

CREATE TABLE `purchase_order` (
  `added_on` datetime DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `productname` varchar(100) DEFAULT NULL,
  `product_code` varchar(100) NOT NULL,
  `amount_to_purchase` float DEFAULT NULL,
  `unit` varchar(20) NOT NULL,
  `buying_price` float DEFAULT NULL,
  `rough_cost` float DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `purchase_order`
--
DELIMITER $$
CREATE TRIGGER `purchase_order_sync_trigger_after_delete` AFTER DELETE ON `purchase_order` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchase_order',
      OLD.product_id,
      'product_id',
      OLD.product_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchase_order_sync_trigger_after_insert` AFTER INSERT ON `purchase_order` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchase_order',
      NEW.product_id,
      'product_id',
      NEW.product_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `purchase_order_sync_trigger_after_update` AFTER UPDATE ON `purchase_order` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'purchase_order',
      NEW.product_id,
      'product_id',
      NEW.product_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `receipt_id` int(11) NOT NULL,
  `receipt_no` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `discount_amount` varchar(20) NOT NULL,
  `total_cost_excl` varchar(20) NOT NULL,
  `tax` varchar(20) NOT NULL,
  `total_cost_incl` varchar(20) NOT NULL,
  `tendered` varchar(20) NOT NULL,
  `change_amount` varchar(20) NOT NULL,
  `payment_channel` varchar(500) NOT NULL,
  `payment_ref` varchar(200) NOT NULL,
  `customer` varchar(100) NOT NULL,
  `loyalty_points` varchar(20) NOT NULL,
  `action_status` varchar(20) NOT NULL,
  `status` varchar(50) NOT NULL,
  `sales_rep` varchar(100) NOT NULL,
  `chef` varchar(100) NOT NULL,
  `cashier` varchar(100) NOT NULL,
  `type_of_sale_processing` varchar(100) NOT NULL,
  `payment_processed_on` datetime NOT NULL,
  `backdated_by` varchar(50) NOT NULL,
  `backdated_on` datetime NOT NULL,
  `customer_pin` varchar(100) DEFAULT NULL,
  `last_edited_on` datetime DEFAULT NULL,
  `last_edited_by` varchar(50) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `receipts`
--
DELIMITER $$
CREATE TRIGGER `receipts_sync_trigger_after_delete` AFTER DELETE ON `receipts` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'receipts',
      OLD.receipt_id,
      'receipt_id',
      OLD.receipt_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `receipts_sync_trigger_after_insert` AFTER INSERT ON `receipts` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'receipts',
      NEW.receipt_id,
      'receipt_id',
      NEW.receipt_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `receipts_sync_trigger_after_update` AFTER UPDATE ON `receipts` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'receipts',
      NEW.receipt_id,
      'receipt_id',
      NEW.receipt_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `restock_level`
--

CREATE TABLE `restock_level` (
  `id` int(11) NOT NULL,
  `date_modified` datetime NOT NULL,
  `last_restock_level` int(10) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `restock_level`
--
DELIMITER $$
CREATE TRIGGER `restock_level_sync_trigger_after_delete` AFTER DELETE ON `restock_level` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'restock_level',
      OLD.id,
      'id',
      OLD.id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `restock_level_sync_trigger_after_insert` AFTER INSERT ON `restock_level` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'restock_level',
      NEW.id,
      'id',
      NEW.id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `restock_level_sync_trigger_after_update` AFTER UPDATE ON `restock_level` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'restock_level',
      NEW.id,
      'id',
      NEW.id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `thedate` datetime DEFAULT NULL,
  `thedates` date DEFAULT NULL,
  `sale_id` int(100) NOT NULL,
  `receipt_no` int(11) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `quantity` float NOT NULL,
  `unit` varchar(20) NOT NULL,
  `comments` varchar(100) NOT NULL,
  `sellingprice` float NOT NULL,
  `discount_amount` varchar(20) NOT NULL,
  `total_cost_excl` varchar(20) NOT NULL,
  `vat` varchar(100) NOT NULL,
  `totalsales` float NOT NULL,
  `cost_of_goods_sold` float DEFAULT NULL,
  `payment_channel` varchar(100) NOT NULL,
  `payment_ref` varchar(200) NOT NULL,
  `profit` float DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `customer` varchar(100) NOT NULL,
  `sales_rep` varchar(100) NOT NULL,
  `chef` varchar(100) NOT NULL,
  `cashier` varchar(100) NOT NULL,
  `type_of_sale_processing` varchar(100) NOT NULL,
  `payment_processed_on` datetime NOT NULL,
  `backdated_by` varchar(50) NOT NULL,
  `backdated_on` datetime NOT NULL,
  `quantity_analysis` float NOT NULL,
  `sales_analysis` float NOT NULL,
  `profit_analysis` float NOT NULL,
  `total_sales_analysis` float NOT NULL,
  `cost_of_goods_sold_analysis` float NOT NULL,
  `sales_profit_analysis` float NOT NULL,
  `net_sales_analysis` float NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `sales`
--
DELIMITER $$
CREATE TRIGGER `sales_sync_trigger_after_delete` AFTER DELETE ON `sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'sales',
      OLD.sale_id,
      'sale_id',
      OLD.sale_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sales_sync_trigger_after_insert` AFTER INSERT ON `sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'sales',
      NEW.sale_id,
      'sale_id',
      NEW.sale_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sales_sync_trigger_after_update` AFTER UPDATE ON `sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'sales',
      NEW.sale_id,
      'sale_id',
      NEW.sale_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_analysis`
--

CREATE TABLE `sales_analysis` (
  `productname` varchar(100) NOT NULL,
  `quantity` float NOT NULL,
  `totalsales` float NOT NULL,
  `profit` float NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales_errors`
--

CREATE TABLE `sales_errors` (
  `time_on` datetime DEFAULT NULL,
  `sale_error_id` int(100) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `quantity_tried_to_be_sold` float NOT NULL,
  `current_stock` float NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `sales_errors`
--
DELIMITER $$
CREATE TRIGGER `sales_errors_sync_trigger_after_delete` AFTER DELETE ON `sales_errors` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'sales_errors',
      OLD.sale_error_id,
      'sale_error_id',
      OLD.sale_error_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sales_errors_sync_trigger_after_insert` AFTER INSERT ON `sales_errors` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'sales_errors',
      NEW.sale_error_id,
      'sale_error_id',
      NEW.sale_error_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sales_errors_sync_trigger_after_update` AFTER UPDATE ON `sales_errors` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'sales_errors',
      NEW.sale_error_id,
      'sale_error_id',
      NEW.sale_error_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_reconciliation`
--

CREATE TABLE `sales_reconciliation` (
  `the_date` date NOT NULL,
  `sales_recon_id` int(11) NOT NULL,
  `total_cash` float NOT NULL,
  `total_mpesa` float NOT NULL,
  `total_pdq` float NOT NULL,
  `total_voucher` float NOT NULL,
  `total_credit` float NOT NULL,
  `user` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `sales_reconciliation`
--
DELIMITER $$
CREATE TRIGGER `sales_reconciliation_sync_trigger_after_delete` AFTER DELETE ON `sales_reconciliation` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'sales_reconciliation',
      OLD.sales_recon_id,
      'sales_recon_id',
      OLD.sales_recon_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sales_reconciliation_sync_trigger_after_insert` AFTER INSERT ON `sales_reconciliation` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'sales_reconciliation',
      NEW.sales_recon_id,
      'sales_recon_id',
      NEW.sales_recon_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sales_reconciliation_sync_trigger_after_update` AFTER UPDATE ON `sales_reconciliation` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'sales_reconciliation',
      NEW.sales_recon_id,
      'sales_recon_id',
      NEW.sales_recon_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `samz_taste_products`
--

CREATE TABLE `samz_taste_products` (
  `thedate` datetime DEFAULT current_timestamp(),
  `productname` varchar(100) NOT NULL,
  `ProductImage` varchar(1000) NOT NULL,
  `quantity` float NOT NULL,
  `buyingprice` float NOT NULL,
  `sellingprice` float NOT NULL,
  `amountspend` float NOT NULL,
  `expectedsales` float NOT NULL,
  `expectedprofit` float NOT NULL,
  `used_stock` float DEFAULT NULL,
  `current_stock` float DEFAULT NULL,
  `last_updated` datetime DEFAULT current_timestamp(),
  `status` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `samz_taste_sales_errors`
--

CREATE TABLE `samz_taste_sales_errors` (
  `time_on` datetime NOT NULL DEFAULT current_timestamp(),
  `productname` varchar(100) NOT NULL,
  `quantity_tried_to_be_sold` float NOT NULL,
  `current_stock` float NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shift_management`
--

CREATE TABLE `shift_management` (
  `shift_id` int(11) NOT NULL,
  `thedate` date NOT NULL,
  `system_recorded_on` datetime NOT NULL,
  `system_cash_sales` float NOT NULL,
  `system_mpesa_sales` float NOT NULL,
  `system_credit_sales` float NOT NULL,
  `system_sales_taken` float NOT NULL,
  `system_sales_taken_narration` varchar(100) NOT NULL,
  `system_total_sales` float NOT NULL,
  `cash_top_up` float NOT NULL,
  `balance_after_top_up` float NOT NULL,
  `topped_by` varchar(100) NOT NULL,
  `topped_on` datetime NOT NULL,
  `user_shift closed_on` datetime NOT NULL,
  `shift_closed_by` varchar(100) NOT NULL,
  `user_cash_sales` float NOT NULL,
  `user_mpesa_sales` float NOT NULL,
  `user_credit_sales` float NOT NULL,
  `shift_status` varchar(10) NOT NULL,
  `approved_by` varchar(100) NOT NULL,
  `edited_by` varchar(100) NOT NULL,
  `edited_on` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `shift_management`
--
DELIMITER $$
CREATE TRIGGER `shift_management_sync_trigger_after_delete` AFTER DELETE ON `shift_management` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'shift_management',
      OLD.shift_id,
      'shift_id',
      OLD.shift_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `shift_management_sync_trigger_after_insert` AFTER INSERT ON `shift_management` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'shift_management',
      NEW.shift_id,
      'shift_id',
      NEW.shift_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `shift_management_sync_trigger_after_update` AFTER UPDATE ON `shift_management` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'shift_management',
      NEW.shift_id,
      'shift_id',
      NEW.shift_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `shift_manager`
--

CREATE TABLE `shift_manager` (
  `shift_id` int(11) NOT NULL,
  `date_on` date NOT NULL,
  `todays_sales_taken` float NOT NULL,
  `todays_sales_taken_narration` varchar(100) NOT NULL,
  `recorded_by` varchar(100) NOT NULL,
  `edited_by` varchar(100) NOT NULL,
  `edited_on` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `shift_manager`
--
DELIMITER $$
CREATE TRIGGER `shift_manager_sync_trigger_after_delete` AFTER DELETE ON `shift_manager` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'shift_manager',
      OLD.shift_id,
      'shift_id',
      OLD.shift_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `shift_manager_sync_trigger_after_insert` AFTER INSERT ON `shift_manager` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'shift_manager',
      NEW.shift_id,
      'shift_id',
      NEW.shift_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `shift_manager_sync_trigger_after_update` AFTER UPDATE ON `shift_manager` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'shift_manager',
      NEW.shift_id,
      'shift_id',
      NEW.shift_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `shift_reconciliation`
--

CREATE TABLE `shift_reconciliation` (
  `shift_id` int(11) NOT NULL,
  `date_on` datetime NOT NULL,
  `date_today` date NOT NULL,
  `user` varchar(100) NOT NULL,
  `user_previous_cash_at_hand` float NOT NULL,
  `sy_pcash` float NOT NULL,
  `user_previous_cash_at_hand_taken` float NOT NULL,
  `sy_pcash_taken` float NOT NULL,
  `user_previous_cash_at_hand_taken_narration` varchar(100) NOT NULL,
  `sy_pcash_taken_narration` varchar(100) NOT NULL,
  `user_mpesa_closing_float` float NOT NULL,
  `sy_m_float` float NOT NULL,
  `user_mpesa_closing_cash` float NOT NULL,
  `sy_m_cash` float NOT NULL,
  `user_mpesa_taken` float NOT NULL,
  `sy_mpesa_taken` float NOT NULL,
  `user_mpesa_taken_narration` varchar(100) NOT NULL,
  `sy_mpesa_taken_narration` varchar(100) NOT NULL,
  `user_pettycash_balance` float NOT NULL,
  `sy_pettycash_balance` float NOT NULL,
  `pettycash_taken` float NOT NULL,
  `pettycash_taken_narration` varchar(100) NOT NULL,
  `user_total_cash_sales` float NOT NULL,
  `sy_today_sales` float NOT NULL,
  `user_total_mpesa_till_sales` float NOT NULL,
  `sy_mpesa_sales` float NOT NULL,
  `user_total_credit_sales` float NOT NULL,
  `sy_credit_sales` float NOT NULL,
  `total_sy_sales` float NOT NULL,
  `todays_sales_taken` float NOT NULL,
  `sy_sales_taken` float NOT NULL,
  `todays_sales_taken_narration` varchar(100) NOT NULL,
  `sy_sales_taken_narration` varchar(100) NOT NULL,
  `user_fuliza_float` float NOT NULL,
  `user_fuliza_cash` float NOT NULL,
  `system_fuliza_float` float NOT NULL,
  `system_fuliza_cash` float NOT NULL,
  `user_fuliza_taken` float NOT NULL,
  `system_fuliza_taken` float NOT NULL,
  `user_fuliza_taken_narration` int(100) NOT NULL,
  `system_user_fuliza_taken_narration` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `shift_reconciliation`
--
DELIMITER $$
CREATE TRIGGER `shift_reconciliation_sync_trigger_after_delete` AFTER DELETE ON `shift_reconciliation` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'shift_reconciliation',
      OLD.shift_id,
      'shift_id',
      OLD.shift_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `shift_reconciliation_sync_trigger_after_insert` AFTER INSERT ON `shift_reconciliation` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'shift_reconciliation',
      NEW.shift_id,
      'shift_id',
      NEW.shift_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `shift_reconciliation_sync_trigger_after_update` AFTER UPDATE ON `shift_reconciliation` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'shift_reconciliation',
      NEW.shift_id,
      'shift_id',
      NEW.shift_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `store_config`
--

CREATE TABLE `store_config` (
  `id` int(11) NOT NULL,
  `store_name` varchar(255) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `payment_method` varchar(100) DEFAULT NULL,
  `account_number` varchar(100) DEFAULT NULL,
  `thank_you_text` text DEFAULT NULL,
  `store_slogan` text DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `store_config`
--
DELIMITER $$
CREATE TRIGGER `store_config_sync_trigger_after_delete` AFTER DELETE ON `store_config` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'store_config',
      OLD.id,
      'id',
      OLD.id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `store_config_sync_trigger_after_insert` AFTER INSERT ON `store_config` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'store_config',
      NEW.id,
      'id',
      NEW.id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `store_config_sync_trigger_after_update` AFTER UPDATE ON `store_config` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'store_config',
      NEW.id,
      'id',
      NEW.id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supdebt`
--

CREATE TABLE `supdebt` (
  `thedate` datetime DEFAULT NULL,
  `debt_id` int(100) NOT NULL,
  `suppliername` varchar(100) NOT NULL,
  `debtamount` int(100) NOT NULL,
  `itemssupplied` varchar(100) NOT NULL,
  `recorded_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `supdebt`
--
DELIMITER $$
CREATE TRIGGER `supdebt_sync_trigger_after_delete` AFTER DELETE ON `supdebt` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'supdebt',
      OLD.debt_id,
      'debt_id',
      OLD.debt_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `supdebt_sync_trigger_after_insert` AFTER INSERT ON `supdebt` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'supdebt',
      NEW.debt_id,
      'debt_id',
      NEW.debt_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `supdebt_sync_trigger_after_update` AFTER UPDATE ON `supdebt` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'supdebt',
      NEW.debt_id,
      'debt_id',
      NEW.debt_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `added_on` datetime NOT NULL,
  `supplier_id` int(100) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `types_of_goods_supplied` varchar(100) NOT NULL,
  `mobile_number` varchar(100) NOT NULL,
  `added_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `suppliers`
--
DELIMITER $$
CREATE TRIGGER `suppliers_sync_trigger_after_delete` AFTER DELETE ON `suppliers` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'suppliers',
      OLD.supplier_id,
      'supplier_id',
      OLD.supplier_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `suppliers_sync_trigger_after_insert` AFTER INSERT ON `suppliers` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'suppliers',
      NEW.supplier_id,
      'supplier_id',
      NEW.supplier_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `suppliers_sync_trigger_after_update` AFTER UPDATE ON `suppliers` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'suppliers',
      NEW.supplier_id,
      'supplier_id',
      NEW.supplier_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_categories`
--

CREATE TABLE `supplier_categories` (
  `category_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `category` varchar(100) NOT NULL,
  `date_modified` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `supplier_categories`
--
DELIMITER $$
CREATE TRIGGER `supplier_categories_sync_trigger_after_delete` AFTER DELETE ON `supplier_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'supplier_categories',
      OLD.category_id,
      'category_id',
      OLD.category_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `supplier_categories_sync_trigger_after_insert` AFTER INSERT ON `supplier_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'supplier_categories',
      NEW.category_id,
      'category_id',
      NEW.category_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `supplier_categories_sync_trigger_after_update` AFTER UPDATE ON `supplier_categories` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'supplier_categories',
      NEW.category_id,
      'category_id',
      NEW.category_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_rates`
--

CREATE TABLE `tax_rates` (
  `rate_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `rate` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `tax_rates`
--
DELIMITER $$
CREATE TRIGGER `tax_rates_sync_trigger_after_delete` AFTER DELETE ON `tax_rates` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'tax_rates',
      OLD.rate_id,
      'rate_id',
      OLD.rate_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tax_rates_sync_trigger_after_insert` AFTER INSERT ON `tax_rates` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'tax_rates',
      NEW.rate_id,
      'rate_id',
      NEW.rate_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tax_rates_sync_trigger_after_update` AFTER UPDATE ON `tax_rates` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'tax_rates',
      NEW.rate_id,
      'rate_id',
      NEW.rate_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_level` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `official_name` varchar(100) NOT NULL,
  `mobile_number` varchar(100) NOT NULL,
  `id_number` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `last_password_reset_on` datetime NOT NULL,
  `last_edited_on` datetime NOT NULL,
  `last_editor` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `users_sync_trigger_after_delete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'users',
      OLD.id,
      'id',
      OLD.id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `users_sync_trigger_after_insert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'users',
      NEW.id,
      'id',
      NEW.id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `users_sync_trigger_after_update` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'users',
      NEW.id,
      'id',
      NEW.id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `role_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `role` varchar(100) NOT NULL,
  `date_modified` datetime NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `user_roles`
--
DELIMITER $$
CREATE TRIGGER `user_roles_sync_trigger_after_delete` AFTER DELETE ON `user_roles` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'user_roles',
      OLD.role_id,
      'role_id',
      OLD.role_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `user_roles_sync_trigger_after_insert` AFTER INSERT ON `user_roles` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'user_roles',
      NEW.role_id,
      'role_id',
      NEW.role_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `user_roles_sync_trigger_after_update` AFTER UPDATE ON `user_roles` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'user_roles',
      NEW.role_id,
      'role_id',
      NEW.role_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voided_credit`
--

CREATE TABLE `voided_credit` (
  `date_on` datetime NOT NULL,
  `void_id` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `quantity` float NOT NULL,
  `total_void_sales` float NOT NULL,
  `void_reason` varchar(100) NOT NULL,
  `voided_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voided_credit`
--
DELIMITER $$
CREATE TRIGGER `voided_credit_sync_trigger_after_delete` AFTER DELETE ON `voided_credit` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_credit',
      OLD.void_id,
      'void_id',
      OLD.void_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_credit_sync_trigger_after_insert` AFTER INSERT ON `voided_credit` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_credit',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_credit_sync_trigger_after_update` AFTER UPDATE ON `voided_credit` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_credit',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voided_essential_supplies_invoices`
--

CREATE TABLE `voided_essential_supplies_invoices` (
  `void_id` int(11) NOT NULL,
  `date_voided` datetime NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `total_cost_excl` float NOT NULL,
  `tax` float NOT NULL,
  `total_cost_incl` float NOT NULL,
  `void_reason` varchar(100) NOT NULL,
  `voided_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voided_essential_supplies_invoices`
--
DELIMITER $$
CREATE TRIGGER `voided_essential_supplies_invoices_sync_trigger_after_delete` AFTER DELETE ON `voided_essential_supplies_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_essential_supplies_invoices',
      OLD.void_id,
      'void_id',
      OLD.void_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_essential_supplies_invoices_sync_trigger_after_insert` AFTER INSERT ON `voided_essential_supplies_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_essential_supplies_invoices',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_essential_supplies_invoices_sync_trigger_after_update` AFTER UPDATE ON `voided_essential_supplies_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_essential_supplies_invoices',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voided_expenses`
--

CREATE TABLE `voided_expenses` (
  `date_on` datetime NOT NULL,
  `void_id` int(11) NOT NULL,
  `expense_name` varchar(100) NOT NULL,
  `total_void_amount` float NOT NULL,
  `void_reason` varchar(100) NOT NULL,
  `voided_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voided_expenses`
--
DELIMITER $$
CREATE TRIGGER `voided_expenses_sync_trigger_after_delete` AFTER DELETE ON `voided_expenses` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_expenses',
      OLD.void_id,
      'void_id',
      OLD.void_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_expenses_sync_trigger_after_insert` AFTER INSERT ON `voided_expenses` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_expenses',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_expenses_sync_trigger_after_update` AFTER UPDATE ON `voided_expenses` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_expenses',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voided_ingredients_invoices`
--

CREATE TABLE `voided_ingredients_invoices` (
  `void_id` int(11) NOT NULL,
  `date_voided` datetime NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `total_cost_excl` float NOT NULL,
  `tax` float NOT NULL,
  `total_cost_incl` float NOT NULL,
  `void_reason` varchar(100) NOT NULL,
  `voided_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voided_ingredients_invoices`
--
DELIMITER $$
CREATE TRIGGER `voided_ingredients_invoices_sync_trigger_after_delete` AFTER DELETE ON `voided_ingredients_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_ingredients_invoices',
      OLD.void_id,
      'void_id',
      OLD.void_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_ingredients_invoices_sync_trigger_after_insert` AFTER INSERT ON `voided_ingredients_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_ingredients_invoices',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_ingredients_invoices_sync_trigger_after_update` AFTER UPDATE ON `voided_ingredients_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_ingredients_invoices',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voided_invoices`
--

CREATE TABLE `voided_invoices` (
  `void_id` int(11) NOT NULL,
  `date_voided` datetime NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `total_cost_excl` float NOT NULL,
  `tax` float NOT NULL,
  `total_cost_incl` float NOT NULL,
  `void_reason` varchar(100) NOT NULL,
  `voided_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voided_invoices`
--
DELIMITER $$
CREATE TRIGGER `voided_invoices_sync_trigger_after_delete` AFTER DELETE ON `voided_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_invoices',
      OLD.void_id,
      'void_id',
      OLD.void_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_invoices_sync_trigger_after_insert` AFTER INSERT ON `voided_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_invoices',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_invoices_sync_trigger_after_update` AFTER UPDATE ON `voided_invoices` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_invoices',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voided_postpaid_sales`
--

CREATE TABLE `voided_postpaid_sales` (
  `date_on` datetime NOT NULL,
  `void_id` int(11) NOT NULL,
  `receipt_no` int(11) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `quantity` float NOT NULL,
  `unit` varchar(20) NOT NULL,
  `total_void_sales` float NOT NULL,
  `payment_channel` varchar(500) NOT NULL,
  `void_reason` varchar(100) NOT NULL,
  `voided_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voided_postpaid_sales`
--
DELIMITER $$
CREATE TRIGGER `voided_postpaid_sales_sync_trigger_after_delete` AFTER DELETE ON `voided_postpaid_sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_postpaid_sales',
      OLD.void_id,
      'void_id',
      OLD.void_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_postpaid_sales_sync_trigger_after_insert` AFTER INSERT ON `voided_postpaid_sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_postpaid_sales',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_postpaid_sales_sync_trigger_after_update` AFTER UPDATE ON `voided_postpaid_sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_postpaid_sales',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voided_postpaid_sales_receipts`
--

CREATE TABLE `voided_postpaid_sales_receipts` (
  `receipt_id` int(11) NOT NULL,
  `receipt_no` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `total_cost_excl` varchar(20) NOT NULL,
  `tax` varchar(20) NOT NULL,
  `total_cost_incl` varchar(20) NOT NULL,
  `payment_channel` varchar(500) NOT NULL,
  `voided_reason` varchar(100) NOT NULL,
  `voided_by` varchar(20) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voided_postpaid_sales_receipts`
--
DELIMITER $$
CREATE TRIGGER `voided_postpaid_sales_receipts_sync_trigger_after_delete` AFTER DELETE ON `voided_postpaid_sales_receipts` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_postpaid_sales_receipts',
      OLD.receipt_id,
      'receipt_id',
      OLD.receipt_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_postpaid_sales_receipts_sync_trigger_after_insert` AFTER INSERT ON `voided_postpaid_sales_receipts` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_postpaid_sales_receipts',
      NEW.receipt_id,
      'receipt_id',
      NEW.receipt_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_postpaid_sales_receipts_sync_trigger_after_update` AFTER UPDATE ON `voided_postpaid_sales_receipts` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_postpaid_sales_receipts',
      NEW.receipt_id,
      'receipt_id',
      NEW.receipt_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voided_receipts`
--

CREATE TABLE `voided_receipts` (
  `receipt_id` int(11) NOT NULL,
  `receipt_no` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `total_cost_excl` varchar(20) NOT NULL,
  `tax` varchar(20) NOT NULL,
  `total_cost_incl` varchar(20) NOT NULL,
  `payment_channel` varchar(500) NOT NULL,
  `voided_reason` varchar(100) NOT NULL,
  `voided_by` varchar(20) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voided_receipts`
--
DELIMITER $$
CREATE TRIGGER `voided_receipts_sync_trigger_after_delete` AFTER DELETE ON `voided_receipts` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_receipts',
      OLD.receipt_id,
      'receipt_id',
      OLD.receipt_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_receipts_sync_trigger_after_insert` AFTER INSERT ON `voided_receipts` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_receipts',
      NEW.receipt_id,
      'receipt_id',
      NEW.receipt_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_receipts_sync_trigger_after_update` AFTER UPDATE ON `voided_receipts` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_receipts',
      NEW.receipt_id,
      'receipt_id',
      NEW.receipt_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voided_sales`
--

CREATE TABLE `voided_sales` (
  `date_on` datetime NOT NULL,
  `void_id` int(11) NOT NULL,
  `receipt_no` int(11) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `product_code` varchar(100) NOT NULL,
  `quantity` float NOT NULL,
  `unit` varchar(20) NOT NULL,
  `sellingprice` varchar(20) NOT NULL,
  `total_void_sales` float NOT NULL,
  `payment_channel` varchar(500) NOT NULL,
  `void_reason` varchar(100) NOT NULL,
  `voided_by` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voided_sales`
--
DELIMITER $$
CREATE TRIGGER `voided_sales_sync_trigger_after_delete` AFTER DELETE ON `voided_sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_sales',
      OLD.void_id,
      'void_id',
      OLD.void_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_sales_sync_trigger_after_insert` AFTER INSERT ON `voided_sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_sales',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `voided_sales_sync_trigger_after_update` AFTER UPDATE ON `voided_sales` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'voided_sales',
      NEW.void_id,
      'void_id',
      NEW.void_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `wastage`
--

CREATE TABLE `wastage` (
  `thedate` datetime NOT NULL DEFAULT current_timestamp(),
  `wastage_id` int(100) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `quantity` float NOT NULL,
  `sellingprice` float NOT NULL,
  `total_sales` float NOT NULL,
  `cost_of_goods_sold` float NOT NULL,
  `profit` float NOT NULL,
  `status` varchar(100) NOT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `wastage`
--
DELIMITER $$
CREATE TRIGGER `wastage_sync_trigger_after_delete` AFTER DELETE ON `wastage` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'wastage',
      OLD.wastage_id,
      'wastage_id',
      OLD.wastage_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `wastage_sync_trigger_after_insert` AFTER INSERT ON `wastage` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'wastage',
      NEW.wastage_id,
      'wastage_id',
      NEW.wastage_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `wastage_sync_trigger_after_update` AFTER UPDATE ON `wastage` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'wastage',
      NEW.wastage_id,
      'wastage_id',
      NEW.wastage_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `work_periods`
--

CREATE TABLE `work_periods` (
  `work_period_id` int(11) NOT NULL,
  `work_date` date NOT NULL,
  `first_sale_date` datetime DEFAULT NULL,
  `last_sale_date` datetime DEFAULT NULL,
  `total_paid_sales` decimal(10,2) NOT NULL,
  `total_credit_sales` decimal(10,2) NOT NULL,
  `total_pending_sales` decimal(10,2) NOT NULL,
  `total_cumulative` decimal(10,2) NOT NULL,
  `ended_on` datetime DEFAULT NULL,
  `ended_by` varchar(255) DEFAULT NULL,
  `sync_uuid` varchar(50) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sync_status` enum('pending','synced') DEFAULT 'pending',
  `sync_last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `work_periods`
--
DELIMITER $$
CREATE TRIGGER `work_periods_sync_trigger_after_delete` AFTER DELETE ON `work_periods` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'work_periods',
      OLD.work_period_id,
      'work_period_id',
      OLD.work_period_id,
      'DELETE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `work_periods_sync_trigger_after_insert` AFTER INSERT ON `work_periods` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'work_periods',
      NEW.work_period_id,
      'work_period_id',
      NEW.work_period_id,
      'INSERT',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `work_periods_sync_trigger_after_update` AFTER UPDATE ON `work_periods` FOR EACH ROW BEGIN
  IF @syncing_now IS NULL THEN
    INSERT INTO log_table_sync_change (
      table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status
    ) VALUES (
      'work_periods',
      NEW.work_period_id,
      'work_period_id',
      NEW.work_period_id,
      'UPDATE',
      NOW(),
      'pending'
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `changed products`
--
DROP TABLE IF EXISTS `changed products`;

CREATE ALGORITHM=UNDEFINED DEFINER=`essayhar`@`localhost` SQL SECURITY DEFINER VIEW `changed products`  AS SELECT `products`.`productname` AS `productname` FROM `products` WHERE `products`.`current_stock` = '29' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cash_at_hand`
--
ALTER TABLE `cash_at_hand`
  ADD PRIMARY KEY (`cash_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `complimentary`
--
ALTER TABLE `complimentary`
  ADD PRIMARY KEY (`complimentary_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `credit`
--
ALTER TABLE `credit`
  ADD PRIMARY KEY (`credit_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `damaged_products`
--
ALTER TABLE `damaged_products`
  ADD PRIMARY KEY (`damage_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `damaged_products_invoices`
--
ALTER TABLE `damaged_products_invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `dispatched_order_delete_log`
--
ALTER TABLE `dispatched_order_delete_log`
  ADD PRIMARY KEY (`delete_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `dispatch_log`
--
ALTER TABLE `dispatch_log`
  ADD PRIMARY KEY (`dispatch_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `employees_departments`
--
ALTER TABLE `employees_departments`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `essential_supplies`
--
ALTER TABLE `essential_supplies`
  ADD PRIMARY KEY (`essential_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `essential_supplies_invoices`
--
ALTER TABLE `essential_supplies_invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`expense_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `expired_products`
--
ALTER TABLE `expired_products`
  ADD PRIMARY KEY (`expiry_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `expired_products_invoices`
--
ALTER TABLE `expired_products_invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`ingredient_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `ingredients_invoices`
--
ALTER TABLE `ingredients_invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `log_table_sync_change`
--
ALTER TABLE `log_table_sync_change`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `maximum_discount_rate`
--
ALTER TABLE `maximum_discount_rate`
  ADD PRIMARY KEY (`discount_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `mpesa`
--
ALTER TABLE `mpesa`
  ADD PRIMARY KEY (`mpesa_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `opening_balance`
--
ALTER TABLE `opening_balance`
  ADD PRIMARY KEY (`transaction_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `password_reset_temp`
--
ALTER TABLE `password_reset_temp`
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `pettycash`
--
ALTER TABLE `pettycash`
  ADD PRIMARY KEY (`pettycash_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `postpaid_sales`
--
ALTER TABLE `postpaid_sales`
  ADD PRIMARY KEY (`sale_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `UQ_products_product_code` (`product_code`),
  ADD UNIQUE KEY `UQ_products_product_name` (`productname`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `products_categories`
--
ALTER TABLE `products_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `products_departments`
--
ALTER TABLE `products_departments`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `products_parent_categories`
--
ALTER TABLE `products_parent_categories`
  ADD PRIMARY KEY (`parent_category_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `products_units`
--
ALTER TABLE `products_units`
  ADD PRIMARY KEY (`unit_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `purchased_essential_supplies`
--
ALTER TABLE `purchased_essential_supplies`
  ADD PRIMARY KEY (`essential_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `purchased_ingredients`
--
ALTER TABLE `purchased_ingredients`
  ADD PRIMARY KEY (`ingredient_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `purchased_order`
--
ALTER TABLE `purchased_order`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`receipt_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `restock_level`
--
ALTER TABLE `restock_level`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`sale_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `sales_analysis`
--
ALTER TABLE `sales_analysis`
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `sales_errors`
--
ALTER TABLE `sales_errors`
  ADD PRIMARY KEY (`sale_error_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `sales_reconciliation`
--
ALTER TABLE `sales_reconciliation`
  ADD PRIMARY KEY (`sales_recon_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `samz_taste_products`
--
ALTER TABLE `samz_taste_products`
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `samz_taste_sales_errors`
--
ALTER TABLE `samz_taste_sales_errors`
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `shift_management`
--
ALTER TABLE `shift_management`
  ADD PRIMARY KEY (`shift_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `shift_manager`
--
ALTER TABLE `shift_manager`
  ADD PRIMARY KEY (`shift_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `shift_reconciliation`
--
ALTER TABLE `shift_reconciliation`
  ADD PRIMARY KEY (`shift_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `store_config`
--
ALTER TABLE `store_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `supdebt`
--
ALTER TABLE `supdebt`
  ADD PRIMARY KEY (`debt_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `supplier_categories`
--
ALTER TABLE `supplier_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD PRIMARY KEY (`rate_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `voided_credit`
--
ALTER TABLE `voided_credit`
  ADD PRIMARY KEY (`void_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `voided_essential_supplies_invoices`
--
ALTER TABLE `voided_essential_supplies_invoices`
  ADD PRIMARY KEY (`void_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `voided_expenses`
--
ALTER TABLE `voided_expenses`
  ADD PRIMARY KEY (`void_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `voided_ingredients_invoices`
--
ALTER TABLE `voided_ingredients_invoices`
  ADD PRIMARY KEY (`void_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `voided_invoices`
--
ALTER TABLE `voided_invoices`
  ADD PRIMARY KEY (`void_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `voided_postpaid_sales`
--
ALTER TABLE `voided_postpaid_sales`
  ADD PRIMARY KEY (`void_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `voided_postpaid_sales_receipts`
--
ALTER TABLE `voided_postpaid_sales_receipts`
  ADD PRIMARY KEY (`receipt_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `voided_receipts`
--
ALTER TABLE `voided_receipts`
  ADD PRIMARY KEY (`receipt_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `voided_sales`
--
ALTER TABLE `voided_sales`
  ADD PRIMARY KEY (`void_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `wastage`
--
ALTER TABLE `wastage`
  ADD PRIMARY KEY (`wastage_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- Indexes for table `work_periods`
--
ALTER TABLE `work_periods`
  ADD PRIMARY KEY (`work_period_id`),
  ADD UNIQUE KEY `sync_uuid` (`sync_uuid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `complimentary`
--
ALTER TABLE `complimentary`
  MODIFY `complimentary_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `credit`
--
ALTER TABLE `credit`
  MODIFY `credit_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `damaged_products`
--
ALTER TABLE `damaged_products`
  MODIFY `damage_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `damaged_products_invoices`
--
ALTER TABLE `damaged_products_invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dispatched_order_delete_log`
--
ALTER TABLE `dispatched_order_delete_log`
  MODIFY `delete_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dispatch_log`
--
ALTER TABLE `dispatch_log`
  MODIFY `dispatch_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees_departments`
--
ALTER TABLE `employees_departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `essential_supplies`
--
ALTER TABLE `essential_supplies`
  MODIFY `essential_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `essential_supplies_invoices`
--
ALTER TABLE `essential_supplies_invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expired_products`
--
ALTER TABLE `expired_products`
  MODIFY `expiry_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expired_products_invoices`
--
ALTER TABLE `expired_products_invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ingredients_invoices`
--
ALTER TABLE `ingredients_invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_table_sync_change`
--
ALTER TABLE `log_table_sync_change`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maximum_discount_rate`
--
ALTER TABLE `maximum_discount_rate`
  MODIFY `discount_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mpesa`
--
ALTER TABLE `mpesa`
  MODIFY `mpesa_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `opening_balance`
--
ALTER TABLE `opening_balance`
  MODIFY `transaction_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pettycash`
--
ALTER TABLE `pettycash`
  MODIFY `pettycash_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `postpaid_sales`
--
ALTER TABLE `postpaid_sales`
  MODIFY `sale_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_categories`
--
ALTER TABLE `products_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_departments`
--
ALTER TABLE `products_departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_parent_categories`
--
ALTER TABLE `products_parent_categories`
  MODIFY `parent_category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_units`
--
ALTER TABLE `products_units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchased_essential_supplies`
--
ALTER TABLE `purchased_essential_supplies`
  MODIFY `essential_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchased_ingredients`
--
ALTER TABLE `purchased_ingredients`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchased_order`
--
ALTER TABLE `purchased_order`
  MODIFY `product_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_order`
--
ALTER TABLE `purchase_order`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receipts`
--
ALTER TABLE `receipts`
  MODIFY `receipt_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `restock_level`
--
ALTER TABLE `restock_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `sale_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_errors`
--
ALTER TABLE `sales_errors`
  MODIFY `sale_error_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_reconciliation`
--
ALTER TABLE `sales_reconciliation`
  MODIFY `sales_recon_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shift_management`
--
ALTER TABLE `shift_management`
  MODIFY `shift_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shift_manager`
--
ALTER TABLE `shift_manager`
  MODIFY `shift_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shift_reconciliation`
--
ALTER TABLE `shift_reconciliation`
  MODIFY `shift_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_config`
--
ALTER TABLE `store_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supdebt`
--
ALTER TABLE `supdebt`
  MODIFY `debt_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplier_categories`
--
ALTER TABLE `supplier_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tax_rates`
--
ALTER TABLE `tax_rates`
  MODIFY `rate_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voided_credit`
--
ALTER TABLE `voided_credit`
  MODIFY `void_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voided_essential_supplies_invoices`
--
ALTER TABLE `voided_essential_supplies_invoices`
  MODIFY `void_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voided_expenses`
--
ALTER TABLE `voided_expenses`
  MODIFY `void_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voided_ingredients_invoices`
--
ALTER TABLE `voided_ingredients_invoices`
  MODIFY `void_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voided_invoices`
--
ALTER TABLE `voided_invoices`
  MODIFY `void_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voided_postpaid_sales`
--
ALTER TABLE `voided_postpaid_sales`
  MODIFY `void_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voided_postpaid_sales_receipts`
--
ALTER TABLE `voided_postpaid_sales_receipts`
  MODIFY `receipt_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voided_receipts`
--
ALTER TABLE `voided_receipts`
  MODIFY `receipt_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `voided_sales`
--
ALTER TABLE `voided_sales`
  MODIFY `void_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wastage`
--
ALTER TABLE `wastage`
  MODIFY `wastage_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `work_periods`
--
ALTER TABLE `work_periods`
  MODIFY `work_period_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
