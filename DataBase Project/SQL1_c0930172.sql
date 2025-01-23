
-- Name : Unni Krishna Prasad
-- Student number : c0930172
-- Project name: Database Build Requirements for Clothing Iron Product
-- Term : 01
-- Professor : Jim Cooper


-- CREATE TABLE STATEMENTS FOR IMPRESSED CLOTHING IRON PRODUCTS
CREATE TABLE ImP_products ( 
	product_id INTEGER NOT NULL, 
	model_number VARCHAR(30) NOT NULL, 
	serial_number VARCHAR(30) NOT NULL, 
	brand VARCHAR(20) NOT NULL, 
	description VARCHAR(60) NOT NULL, 
	Iron_type VARCHAR(20) NOT NULL, 
	price DECIMAL(5,2) NOT NULL, 
	rating DECIMAL(3,2), 
	colour VARCHAR(20) NOT NULL, 
	cord_length INTEGER, 
	temperature_settings INTEGER
 );

CREATE TABLE ImP_warehouses ( 
	warehouse_id INTEGER NOT NULL, 
	location_id INTEGER NOT NULL,
	warehouse_zip VARCHAR(7) NOT NULL,
	warehouse_city VARCHAR(30) NOT NULL
);

CREATE TABLE ImP_inventory ( 
	product_id INTEGER NOT NULL,
	warehouse_id INTEGER NOT NULL, 
	quantity INTEGER
);

CREATE TABLE ImP_employees ( 
	employee_id  INTEGER NOT NULL, 
	first_name VARCHAR(20) NOT NULL, 
	last_name VARCHAR(20) NOT NULL, 
	soc_sec_no INTEGER NOT NULL, 
	hire_date DATE NOT NULL DEFAULT CURRENT_DATE, 
	salary DECIMAL(9,2) NOT NULL, 
	manager_id INTEGER
);

CREATE TABLE ImP_customers ( 
	customer_id INTEGER NOT NULL, 
	first_name VARCHAR(20) NOT NULL, 
	last_name VARCHAR(20) NOT NULL, 
	email VARCHAR(30), 
	phone VARCHAR(20)
);

CREATE TABLE ImP_orders ( 
	order_id INTEGER NOT NULL, 
	customer_id INTEGER NOT NULL, 
	order_cost DECIMAL(10,2) NOT NULL, 
	order_date DATE NOT NULL DEFAULT CURRENT_DATE, 
	employee_id INTEGER
);

CREATE TABLE ImP_locations ( 
	location_id INTEGER NOT NULL,
	city VARCHAR(30) NOT NULL,
	region_id INTEGER NOT NULL
);

CREATE TABLE ImP_regions (
region_id INTEGER NOT NULL,
region_name VARCHAR(30) NOT NULL, 
province VARCHAR(30) NOT NULL, 
zip_code VARCHAR(10) NOT NULL
);

CREATE TABLE ImP_order_lines (
    order_line_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    price DECIMAL(6,2) NOT NULL,
);


-- Adding DATABASE CONSTRAINTS STATEMENTS
ALTER TABLE ImP_products
ADD CONSTRAINT ImP_products_PK 
PRIMARY KEY (product_id);

ALTER TABLE ImP_products
ADD CONSTRAINT ImP_products_MODEL_NUMBER_UK 
UNIQUE (model_number);

ALTER TABLE ImP_products
ADD CONSTRAINT ImP_products_SERIAL_NUMBER_UK 
UNIQUE (serial_number);


ALTER TABLE ImP_warehouses
ADD CONSTRAINT ImP_warehouses_PK
PRIMARY KEY (warehouse_id);

ALTER TABLE ImP_inventory
ADD CONSTRAINT ImP_inventory_PK 
PRIMARY KEY (product_id, warehouse_id);

ALTER TABLE ImP_regions
ADD CONSTRAINT ImP_regions_PK 
PRIMARY KEY (region_id);

ALTER TABLE ImP_regions
ADD CONSTRAINT ImP_regions_REGION_NAME_UK 
UNIQUE (region_name);

ALTER TABLE ImP_locations
ADD CONSTRAINT ImP_locations_PK 
PRIMARY KEY (location_id);


ALTER TABLE ImP_order_lines
ADD CONSTRAINT ImP_order_lines_PK 
PRIMARY KEY (order_id, product_id);

ALTER TABLE ImP_orders
ADD CONSTRAINT ImP_orders_PK 
PRIMARY KEY (order_id);

  
ALTER TABLE ImP_customers
ADD CONSTRAINT ImP_customers_PK 
PRIMARY KEY (customer_id);

ALTER TABLE ImP_customers
ADD CONSTRAINT ImP_customers_EMAIL_UK 
UNIQUE (email);

ALTER TABLE ImP_employees
ADD CONSTRAINT ImP_employees_PK 
PRIMARY KEY (employee_id);

ALTER TABLE ImP_employees
ADD CONSTRAINT ImP_employees_soc_sec_no_UK 
UNIQUE (soc_sec_no);

ALTER TABLE ImP_warehouses
ADD CONSTRAINT ImP_warehouses_LOCATION_ID_FK 
FOREIGN KEY (location_id) 
REFERENCES ImP_locations(location_id);


ALTER TABLE ImP_inventory
ADD CONSTRAINT ImP_inventory_PRODUCT_ID_FK 
FOREIGN KEY (product_id)
REFERENCES ImP_products(product_id)
  ON DELETE CASCADE;
  
ALTER TABLE ImP_inventory
ADD CONSTRAINT ImP_inventory_WAREHOUSE_ID_FK
FOREIGN KEY (warehouse_id) 
REFERENCES ImP_warehouses(warehouse_id)
  ON DELETE CASCADE;

ALTER TABLE ImP_locations
ADD CONSTRAINT ImP_locations_REGION_ID_FK 
FOREIGN KEY (region_id) 
REFERENCES ImP_regions(region_id);


ALTER TABLE ImP_order_lines
ADD CONSTRAINT ImP_order_lines_ORDER_ID_FK 
FOREIGN KEY (order_id) 
REFERENCES ImP_orders(order_id)
  ON DELETE CASCADE;

ALTER TABLE ImP_order_lines
ADD CONSTRAINT ImP_order_lines_PRODUCT_ID_FK 
FOREIGN KEY (product_id) 
REFERENCES ImP_products(product_id)
  ON DELETE CASCADE;
  
ALTER TABLE ImP_orders
ADD CONSTRAINT ImP_orders_CUSTOMER_ID_FK 
FOREIGN KEY (customer_id) 
REFERENCES ImP_customers(customer_id)
  ON DELETE CASCADE;

ALTER TABLE ImP_orders
ADD CONSTRAINT ImP_orders_EMPLOYEE_ID_FK 
FOREIGN KEY (employee_id) 
REFERENCES ImP_employees(employee_id)
  ON DELETE SET NULL;
  

ALTER TABLE ImP_employees
ADD CONSTRAINT ImP_employees_MANAGER_ID_FK 
FOREIGN KEY (manager_id) 
REFERENCES ImP_employees(employee_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
ALTER TABLE ImP_employees
ADD CONSTRAINT ImP_employees_soc_sec_no_ck
CHECK (soc_sec_no between 111111111 and 999999999);



--INSERT STATEMENTS FOR REGIONS INTO ImP_Regions
INSERT ALL 
INTO ImP_regions 
VALUES (1, 'Greater Toronto Area', 'Ontario', 'M5B 2K3')
INTO ImP_regions 
VALUES(2, 'Greater Vancouver Area', 'British Columbia', 'V6C 3C1')
INTO ImP_regions 
VALUES(3, 'Calgary Region', 'Alberta', 'T2P 0L6')
INTO ImP_regions 
VALUES(4, 'Greater Montreal Area', 'Quebec', 'H3B 4X9')
INTO ImP_regions 
VALUES(5, 'Winnipeg Capital Region', 'Manitoba', 'R3C 3J7')
INTO ImP_regions 
VALUES(6, 'Halifax Regional Municipality', 'Nova Scotia', 'B3H 4P7')
INTO ImP_regions 
VALUES(7, 'Ottawa-Gatineau Area', 'Ontario', 'K1A 0A6')
INTO ImP_regions 
VALUES(8, 'Regina Metropolitan Area', 'Saskatchewan', 'S4S 0A3')
INTO ImP_regions 
VALUES(9, 'St. John''s Metropolitan Area', 'Newfoundland and Labrador', 'A1B 4J6')
SELECT * from DUAL;



-- Insert statements for location detials into ImP_locations table
INSERT ALL
INTO ImP_locations
VALUES (1, 'Toronto', 1)
INTO ImP_locations
VALUES(2, 'Mississauga', 1)
INTO ImP_locations
VALUES(3, 'Markham', 1)
INTO ImP_locations
VALUES(4, 'Vancouver', 2)
INTO ImP_locations
VALUES(5, 'Burnaby', 2)
INTO ImP_locations
VALUES(6, 'Surrey', 2)
INTO ImP_locations
VALUES(7, 'Calgary', 3)
INTO ImP_locations
VALUES(8, 'Edmonton', 3)
INTO ImP_locations
VALUES(9, 'Montreal', 4)
INTO ImP_locations
VALUES(10, 'Laval', 4)
INTO ImP_locations
VALUES(11, 'Winnipeg', 5)
INTO ImP_locations
VALUES(12, 'Halifax', 6)
INTO ImP_locations
VALUES(13, 'Dartmouth', 6)
INTO ImP_locations
VALUES(14, 'Ottawa', 7)
INTO ImP_locations
VALUES(15, 'Gatineau', 7)
INTO ImP_locations
VALUES(16, 'Regina', 8)
INTO ImP_locations
VALUES(17, 'Saskatoon', 8)
INTO ImP_locations
VALUES(18, 'St. John''s', 9)
INTO ImP_locations
VALUES(19, 'Mount Pearl', 9)
INTO ImP_locations
VALUES(20, 'Brampton', 1)
SELECT * FROM Dual;



-- Insert statements into Imp_warehouses table
INSERT ALL
INTO ImP_warehouses
VALUES (1, 1, 'M5B 2K3', 'Toronto')
INTO ImP_warehouses
VALUES(2, 2, 'M5B 2K3', 'Mississauga')
INTO ImP_warehouses
VALUES(3, 3, 'M5B 2K3', 'Markham')
INTO ImP_warehouses
VALUES(4, 4, 'V6C 3C1', 'Vancouver')
INTO ImP_warehouses
VALUES(5, 5, 'V6C 3C1', 'Burnaby')
INTO ImP_warehouses
VALUES(6, 6, 'V6C 3C1', 'Surrey')
INTO ImP_warehouses
VALUES(7, 7, 'T2P 0L6', 'Calgary')
INTO ImP_warehouses
VALUES(8, 8, 'T2P 0L6', 'Edmonton')
INTO ImP_warehouses
VALUES(9, 9, 'H3B 4X9', 'Montreal')
INTO ImP_warehouses
VALUES(10, 10, 'H3B 4X9', 'Laval')
INTO ImP_warehouses
VALUES(11, 11, 'R3C 3J7', 'Winnipeg')
INTO ImP_warehouses
VALUES(12, 12, 'B3H 4P7', 'Halifax')
INTO ImP_warehouses
VALUES(13, 13, 'B3H 4P7', 'Dartmouth')
INTO ImP_warehouses
VALUES(14, 14, 'K1A 0A6', 'Ottawa')
INTO ImP_warehouses
VALUES(15, 15, 'K1A 0A6', 'Gatineau')
INTO ImP_warehouses
VALUES(16, 16, 'S4S 0A3', 'Regina')
INTO ImP_warehouses
VALUES(17, 17, 'S4S 0A3', 'Saskatoon')
INTO ImP_warehouses
VALUES(18, 18, 'A1B 4J6', 'St. John''s')
INTO ImP_warehouses
VALUES(19, 19, 'A1B 4J6', 'Mount Pearl')
INTO ImP_warehouses
VALUES(20, 20, 'M5B 2K3', 'Brampton')
SELECT * FROM Dual;



-- Insert customer data statements into Imp_customers table
INSERT ALL 
INTO ImP_customers
VALUES(1, 'John', 'Doe', 'john.doe@example.com', '+1234567890')
INTO ImP_customers
VALUES(2, 'Jane', 'Smith', 'jane.smith@example.com', '+1987654321')
INTO ImP_customers
VALUES(3, 'Michael', 'Johnson', 'michael.johnson@example.com', '+1555555555')
INTO ImP_customers
VALUES(4, 'Emily', 'Brown', 'emily.brown@example.com', '+1777777777')
INTO ImP_customers
VALUES(5, 'David', 'Wilson', 'david.wilson@example.com', '+1666666666')
INTO ImP_customers
VALUES(6, 'Sarah', 'Taylor', 'sarah.taylor@example.com', '+1888888888')
INTO ImP_customers
VALUES(7, 'Robert', 'Martinez', 'robert.martinez@example.com', '+1999999999')
INTO ImP_customers
VALUES(8, 'Jennifer', 'Anderson', 'jennifer.anderson@example.com', '+1444444444')
INTO ImP_customers
VALUES(9, 'Christopher', 'Thomas', 'christopher.thomas@example.com', '+1333333333')
INTO ImP_customers
VALUES(10, 'Jessica', 'Jackson', 'jessica.jackson@example.com', '+1222222222')
INTO ImP_customers
VALUES(11, 'Matthew', 'White', 'matthew.white@example.com', '+1777555333')
INTO ImP_customers
VALUES(12, 'Amanda', 'Brown', 'amanda.brown@example.com', '+1222555888')
INTO ImP_customers
VALUES(13, 'Daniel', 'Lee', 'daniel.lee@example.com', '+1444666999')
INTO ImP_customers
VALUES(14, 'Ashley', 'Garcia', 'ashley.garcia@example.com', '+1666777888')
INTO ImP_customers
VALUES(15, 'James', 'Lopez', 'james.lopez@example.com', '+1999888222')
SELECT * FROM Dual;



-- Insert statements employee details into ImP_employees table
INSERT ALL
INTO ImP_employees
VALUES (1, 'John', 'Doe', 123456789, '2022-01-15', 60000.00, NULL)
INTO ImP_employees
VALUES (2, 'Jane', 'Smith', 234567890, '2022-02-20', 55000.00, 1)
INTO ImP_employees
VALUES (3, 'Michael', 'Johnson', 345678901, '2022-03-25', 62000.00, 1)
INTO ImP_employees
VALUES (4, 'Emily', 'Brown', 456789012, '2022-04-10', 58000.00, 1)
INTO ImP_employees
VALUES (5, 'David', 'Wilson', 567890123, '2022-05-05', 63000.00, 2)
INTO ImP_employees
VALUES (6, 'Sarah', 'Taylor', 678901234, '2022-06-15', 59000.00, 2)
INTO ImP_employees
VALUES (7, 'Robert', 'Martinez', 789012345, '2022-07-20', 65000.00, 3)
INTO ImP_employees
VALUES (8, 'Jennifer', 'Anderson', 890123456, '2022-08-25', 60000.00, 3)
INTO ImP_employees
VALUES (9, 'Christopher', 'Thomas', 901234567, '2022-09-10', 67000.00, 3)
INTO ImP_employees
VALUES (10, 'Jessica', 'Jackson', 123456999, '2022-10-05', 62000.00, 4)
INTO ImP_employees
VALUES (11, 'Matthew', 'White', 455567890, '2022-11-15', 69000.00, 4)
INTO ImP_employees
VALUES (12, 'Amanda', 'Brown', 322278901, '2022-12-20', 64000.00, 5)
INTO ImP_employees
VALUES (13, 'Daniel', 'Lee', 456777012, '2023-01-25', 70000.00, 5)
INTO ImP_employees
VALUES (14, 'Ashley', 'Garcia', 245890123, '2023-02-10', 66000.00, 6)
INTO ImP_employees
VALUES (15, 'James', 'Lopez', 666901234, '2023-03-05', 71000.00, 6)
SELECT * FROM DUAL;



-- INSERT statements for ImP_products
INSERT ALL
INTO ImP_products
VALUES (1, 'CI1001', 'SN001', 'SteamMaster', 'SteamMaster Lightweight Iron', 'Steam', 39.99, 4.5, 'Blue', 6, 5)
INTO ImP_products
VALUES (2, 'CI2002', 'SN002', 'IronWorks', 'IronWorks Stainless Steel Iron', 'Dry', 49.99, 4.3, 'Black', 5, NULL)
INTO ImP_products
VALUES (3, 'CI3003', 'SN003', 'UltraSteam', 'UltraSteam Advanced Iron', 'Steam', 59.99, 4.7, 'Red', 7, 6)
INTO ImP_products
VALUES (4, 'CI4004', 'SN004', 'ProPress', 'ProPress Professional Iron', 'Steam', 79.99, 4.9, 'White', 6, 7)
INTO ImP_products
VALUES (5, 'CI5005', 'SN005', 'QuickIron', 'QuickIron Rapid Heat Iron', 'Dry', 69.99, 4.4, 'Silver', 5, NULL)
INTO ImP_products
VALUES (6, 'CI6006', 'SN006', 'SmartPress', 'SmartPress Digital Iron', 'Steam', 89.99, 4.8, 'Purple', 8, 8)
INTO ImP_products
VALUES (7, 'CI7007', 'SN007', 'EliteSteam', 'EliteSteam Luxury Iron', 'Steam', 99.99, 4.6, 'Gold', 7, 9)
INTO ImP_products
VALUES (8, 'CI8008', 'SN008', 'TurboPress', 'TurboPress Turbocharged Iron', 'Steam', 119.99, 4.9, 'Green', 7, 10)
INTO ImP_products
VALUES (9, 'CI9009', 'SN009', 'QuickSteam', 'QuickSteam Fast-Heating Iron', 'Steam', 79.99, 4.5, 'Orange', 6, 6)
INTO ImP_products
VALUES (10, 'CI1010', 'SN010', 'SwiftIron', 'SwiftIron Lightweight Iron', 'Dry', 29.99, 4.2, 'Yellow', 5, NULL)
INTO ImP_products
VALUES (11, 'CI1111', 'SN011', 'MaxSteam', 'MaxSteam Heavy Duty Iron', 'Steam', 129.99, 4.7, 'Pink', 8, 8)
INTO ImP_products
VALUES (12, 'CI1212', 'SN012', 'PowerPress', 'PowerPress Advanced Iron', 'Steam', 139.99, 4.8, 'Brown', 7, 9)
INTO ImP_products
VALUES (13, 'CI1313', 'SN013', 'MegaSteam', 'MegaSteam High-Capacity Iron', 'Steam', 159.99, 4.9, 'Gray', 7, 10)
INTO ImP_products
VALUES (14, 'CI1414', 'SN014', 'SuperIron', 'SuperIron Pro Steam Iron', 'Steam', 169.99, 4.6, 'Cyan', 6, 7)
INTO ImP_products
VALUES (15, 'CI1515', 'SN015', 'TurboSteam', 'TurboSteam Power Iron', 'Steam', 179.99, 4.7, 'Lime', 5, 6)
INTO ImP_products
VALUES (16, 'CI1616', 'SN016', 'QuickPress', 'QuickPress Rapid Iron', 'Dry', 79.99, 4.5, 'Purple', 6, NULL)
INTO ImP_products
VALUES (17, 'CI1717', 'SN017', 'SpeedSteam', 'SpeedSteam Fast Iron', 'Steam', 89.99, 4.3, 'Black', 7, 5)
INTO ImP_products
VALUES (18, 'CI1818', 'SN018', 'SwiftSteam', 'SwiftSteam Lightweight Iron', 'Steam', 49.99, 4.1, 'Red', 5, 4)
INTO ImP_products
VALUES (19, 'CI1919', 'SN019', 'EasyPress', 'EasyPress Simple Iron', 'Dry', 59.99, 4.2, 'White', 6, NULL)
INTO ImP_products
VALUES (20, 'CI2020', 'SN020', 'MaxHeat', 'MaxHeat High-Temperature Iron', 'Dry', 69.99, 4.4, 'Blue', 7, NULL)
INTO ImP_products
VALUES (21, 'CI2121', 'SN021', 'UltraPress', 'UltraPress Heavy Duty Iron', 'Steam', 79.99, 4.6, 'Green', 8, 7)
INTO ImP_products
VALUES (22, 'CI2222', 'SN022', 'TurboHeat', 'TurboHeat Power Iron', 'Dry', 99.99, 4.7, 'Yellow', 6, NULL)
INTO ImP_products
VALUES (23, 'CI2323', 'SN023', 'QuickHeat', 'QuickHeat Rapid Iron', 'Dry', 89.99, 4.5, 'Orange', 7, NULL)
INTO ImP_products
VALUES (24, 'CI2424', 'SN024', 'SmartHeat', 'SmartHeat Digital Iron', 'Steam', 109.99, 4.8, 'Pink', 8, 8)
INTO ImP_products
VALUES (25, 'CI2525', 'SN025', 'MaxPress', 'MaxPress Professional Iron', 'Steam', 119.99, 4.9, 'Brown', 7, 9)
INTO ImP_products
VALUES (26, 'CI2626', 'SN026', 'QuickSteam', 'QuickSteam Compact Iron', 'Steam', 69.99, 4.4, 'Gray', 6, 6)
INTO ImP_products
VALUES (27, 'CI2727', 'SN027', 'TurboPress', 'TurboPress Deluxe Iron', 'Steam', 79.99, 4.6, 'Cyan', 7, 7)
INTO ImP_products
VALUES (28, 'CI2828', 'SN028', 'MegaSteam', 'MegaSteam Ultimate Iron', 'Steam', 129.99, 4.8, 'Lime', 8, 8)
INTO ImP_products
VALUES (29, 'CI2929', 'SN029', 'SuperSteam', 'SuperSteam Pro Iron', 'Steam', 139.99, 4.9, 'Purple', 7, 9)
INTO ImP_products
VALUES (30, 'CI3030', 'SN030', 'SpeedPress', 'SpeedPress Advanced Iron', 'Steam', 149.99, 4.7, 'Black', 6, 7)
SELECT * FROM DUAL;



-- INSERT STATEMENTS FOR ImP_ORDERS Table
INSERT ALL
INTO ImP_orders
VALUES(1, 3, 59.99, '2023-03-01', 8)
INTO ImP_orders
VALUES(2, 10, 99.98, '2023-02-20', 2)
INTO ImP_orders
VALUES(3, 5, 159.97, '2023-01-10', 4)
INTO ImP_orders
VALUES(4, 8, 49.99, '2023-03-05', 5)
INTO ImP_orders
VALUES(5, 1, 219.96, '2022-12-15', 3)
INTO ImP_orders
VALUES(6, 13, 129.99, '2022-10-25', 11)
INTO ImP_orders
VALUES(7, 6, 219.97, '2022-08-30', 3)
INTO ImP_orders
VALUES(8, 12, 259.96, '2023-01-05', 10)
INTO ImP_orders
VALUES(9, 4, 199.97, '2023-02-12', 9)
INTO ImP_orders
VALUES(10, 7, 129.99, '2023-03-15', 5)
INTO ImP_orders
VALUES(11, 14, 119.98, '2022-12-28', 6)
INTO ImP_orders
VALUES(12, 11, 189.96, '2023-01-20', 8)
INTO ImP_orders
VALUES(13, 15, 169.98, '2022-11-18', 10)
INTO ImP_orders
VALUES(14, 3, 119.98, '2022-10-08', 6)
INTO ImP_orders
VALUES(15, 9, 119.98, '2022-09-22', 1)
INTO ImP_orders
VALUES(16, 7, 229.95, '2023-01-30', 8)
INTO ImP_orders
VALUES(17, 10, 89.99, '2022-11-10', 7)
INTO ImP_orders
VALUES(18, 2, 99.99, '2023-02-08', 6)
INTO ImP_orders
VALUES(19, 4, 249.94, '2023-03-20', 12)
INTO ImP_orders
VALUES(20, 12, 89.99, '2022-09-05', 13)
INTO ImP_orders
VALUES(21, 6, 179.97, '2022-12-01', 8)
INTO ImP_orders
VALUES(22, 11, 109.99, '2023-01-15', 15)
INTO ImP_orders
VALUES(23, 8, 129.98, '2022-10-30', 7)
INTO ImP_orders
VALUES(24, 13, 229.97, '2022-12-10', 10)
INTO ImP_orders
VALUES(25, 9, 239.96, '2023-02-25', 6)
INTO ImP_orders
VALUES(26, 5, 99.99, '2022-11-28', 4)
INTO ImP_orders
VALUES(27, 15, 149.97, '2023-03-10', 5)
INTO ImP_orders
VALUES(28, 1, 169.98, '2022-09-15', 12)
INTO ImP_orders
VALUES(29, 14, 159.97, '2023-01-25', 3)
INTO ImP_orders
VALUES(30, 2, 249.96, '2022-12-05', 11)
SELECT * FROM DUAL;


-- INSERT STATEMENTS FOR ImP_order_lines
INSERT ALL
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (1, 1, 7, 1, 59.99)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (2, 2, 26, 2, 49.98)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (3, 3, 13, 3, 89.91)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (4, 4, 16, 4, 199.96)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (5, 5, 1, 1, 219.96)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (6, 6, 6, 2, 259.98)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (7, 7, 15, 3, 149.97)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (8, 8, 3, 4, 239.92)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (9, 9, 8, 1, 49.99)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (10, 10, 5, 2, 219.98)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (11, 11, 2, 3, 149.97)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (12, 12, 10, 4, 359.96)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (13, 13, 30, 1, 149.96)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (14, 14, 19, 2, 199.96)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (15, 15, 12, 3, 299.97)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (16, 16, 20, 4, 359.96)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (17, 17, 18, 1, 99.99)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (18, 18, 11, 2, 199.98)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (19, 19, 27, 3, 269.91)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (20, 20, 24, 4, 359.96)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (21, 21, 29, 1, 159.97)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (22, 22, 14, 2, 219.98)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (23, 23, 22, 3, 329.97)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (24, 24, 23, 4, 459.96)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (25, 25, 21, 1, 69.99)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (26, 26, 4, 2, 199.98)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (27, 27, 17, 3, 269.97)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (28, 28, 25, 4, 479.96)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (29, 29, 28, 1, 129.99)
INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (30, 30, 9, 2, 139.98)
SELECT * FROM dual;


--INSERT STATEMENTS FOR ImP_inventory
INSERT ALL
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (6, 16, 51)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (22, 5, 61)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (25, 1, 71)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (15, 20, 37)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (29, 14, 79)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (8, 18, 73)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (30, 13, 47)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (13, 9, 61)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (9, 10, 53)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (24, 6, 71)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (11, 8, 57)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (16, 19, 41)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (21, 11, 71)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (12, 7, 79)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (28, 17, 31)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (26, 4, 77)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (17, 15, 67)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (3, 12, 81)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (23, 3, 71)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (20, 2, 57)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (14, 16, 31)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (1, 2, 67)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (19, 20, 41)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (5, 15, 51)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (4, 18, 59)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (7, 10, 37)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (18, 13, 77)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (27, 11, 71)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (10, 3, 51)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (2, 6, 57)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (30, 8, 61)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (3, 19, 41)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (22, 1, 71)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (28, 9, 47)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (25, 15, 67)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (16, 20, 73)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (1, 5, 41)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (26, 14, 37)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (15, 2, 47)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (11, 16, 73)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (17, 7, 59)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (24, 4, 43)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (6, 12, 67)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (12, 17, 53)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (7, 13, 71)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (8, 9, 59)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (14, 8, 43)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (9, 11, 31)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (13, 3, 71)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (29, 18, 79)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (4, 13, 69)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (5, 10, 71)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (19, 6, 53)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (23, 17, 31)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (10, 8, 69)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (27, 2, 61)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (12, 10, 35)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (17, 4, 65)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (20, 9, 45)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (23, 7, 70)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (28, 3, 55)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (4, 6, 40)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (10, 2, 75)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (15, 13, 50)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (19, 15, 60)
INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (25, 8, 55)
SELECT * FROM dual;



-- CONSTRAINT TESTING


-- Constraint Test 1
-- Description: Confirm primary key constraint on product_id column in ImP_products table
-- Expected result: Insert fails with unique constraint error
-- Action
INSERT INTO ImP_products VALUES (1, 'BO2002', 'Spk02', 'IronWorks', 'IronWorks Stainless Steel Iron', 'Dry', 49.99, 4.3, 'Black', 5, NULL);
--ORA-00001: unique constraint (WKSP_LCOW2408.IMP_PRODUCTS_PK) violated


-- Constraint Test 2
-- Description: Confirm primary key constraint on region_id column in ImP__regions table
-- Expected result: Insert fails with unique constraint error
-- Action
INSERT INTO ImP_regions VALUES (1, 'Ottawa', 'Ontario', 'K1G 4A7');
-- Result:
-- ORA-00001: unique constraint (WKSP_LCOW2408.IMP_REGIONS_PK) violated


-- Constraint Test 3
-- Description: Confirm primary key constraint on location_id column in ImP_locations table
-- Expected result: Insert fails with Unique constraint key error
-- Action
 INSERT INTO ImP_locations VALUES (1, 'India', 1);
-- Result:
-- ORA-00001: unique constraint (WKSP_LCOW2408.IMP_LOCATIONS_PK) violated

-- Constraint Test 4
-- Description: Confirm primary key constraint on warehouse_id column in ImP_warehouses table
-- Expected result: Insert fails with Unique constraint key error
-- Action
 INSERT INTO ImP_warehouses VALUES (1, 4, 'M4W 2L4', 'Lycee');
-- Result:
-- ORA-00001: unique constraint (WKSP_LCOW2408.IMP_WAREHOUSES_PK) violated


-- Constraint Test 5
-- Description: Confirm primary key constraint on customer_id column in ImP_customers table
-- Expected result: Insert fails with Unique contraint key error
-- Action
 INSERT INTO ImP_customers VALUES (1, 'Jon', 'Mooney','jmooney@gmail.com', NULL);
-- ORA-00001: unique constraint (WKSP_LCOW2408.IMP_CUSTOMERS_PK) violated


-- Constraint Test 6
-- Description: Confirm primary key constraint on employee_id column in ImP_employees table
-- Expected result: Insert fails with Unique contraint key error
-- Action
 INSERT INTO ImP_employees VALUES (2, 'Mariyah', 'Espinosa',777645321, '2012-05-23', 95000.00, null);
-- Result:
-- ORA-00001: unique constraint (WKSP_LCOW2408.IMP_EMPLOYEES_PK) violated


-- Constraint Test 7
-- Description: Confirm primary key constraint on order_id column in ImP_orders table
-- Expected result: Insert fails with Unique contraint key error
-- Action
INSERT INTO ImP_orders VALUES(1, 3, 59.99, '2023-03-01', 8)
-- Result:
-- ORA-00001: unique constraint (WKSP_LCOW2408.IMP_ORDERS_PK) violated



-- Constraint Test 8
-- Description: Confirm primary key constraint on order_id column in ImP_order_lines table
-- Expected result: Insert fails with Unique contraint key error
-- Action
 INSERT INTO ImP_order_lines (order_line_id, order_id, product_id, quantity, price) VALUES (1, 1, 7, 1, 59.99);
-- Result:
-- ORA-00001: unique constraint (WKSP_LCOW2408.IMP_ORDER_LINES_PK) violated


-- Constraint Test 9
-- Description: Confirm primary key constraint on product_id column in ImP_inventory table
-- Expected result: Insert fails with Unique contraint key error
-- Action
INSERT INTO ImP_inventory (product_id, warehouse_id, quantity) VALUES (6, 16, 5);
-- Result:
-- ORA-00001: unique constraint (WKSP_LCOW2408.IMP_INVENTORY_PK) violated


-- Constraint Test 9
-- Description: Confirm foreign key constraint on manager_id column in ImP_employees table
-- Expected result: Insert fails, operation not allowed
-- Action
INSERT INTO ImP_employees VALUES (99, 'John', 'Doe', 123456789, '2022-01-15', 60000.00, 33)
-- Result:
-- ORA-02291: integrity constraint (WKSP_LCOW2408.IMP_EMPLOYEES_MANAGER_ID_FK) violated - parent key not found

-- Constraint Test 10
-- Description: Confirm check constraint on soc_sec_no column in jbi_employees table
-- Expected result: Insert fails with check constraint error
-- Action
INSERT INTO ImP_employees VALUES (16, 'John', 'Doe', 1, '2022-01-15', 60000.00, Null);
-- Result:
-- ORA-02290: check constraint (WKSP_LCOW2408.IMP_EMPLOYEES_SOC_SEC_NO_CK) violated


-- Constraint Test 11
-- Description: Confirm unique constraint on soc_sec_no column in ImP_employees table
-- Expected result: Insert fails with Unique contrain error
-- Action
 INSERT INTO ImP_employees VALUES (56, 'John', 'Doe', 123456789, '2022-01-15', 60000.00, NULL)
-- Result:
-- ORA-00001: unique constraint (WKSP_LCOW2408.IMP_EMPLOYEES_SOC_SEC_NO_UK) violated

-- Constraint Test 12
-- Description: Confirm check constraint on soc_sec_no column in jbi_employees table
-- Expected result: Insert fails with check constraint error
-- Action
INSERT INTO ImP_employees VALUES (17, 'John', 'Doe', 123456789100, '2022-01-15', 60000.00, Null);
-- Result:
-- ORA-02290: check constraint (WKSP_LCOW2408.IMP_EMPLOYEES_SOC_SEC_NO_CK) violated

-- Constraint Test 13
-- Description: Confirm Not_null constraint on soc_sec_no column in ImP_employees table
-- Expected result: Insert fails with Null value error
-- Action
 INSERT INTO ImP_employees VALUES (56, 'John', 'Doe', NULL, '2022-01-15', 60000.00, NULL)
-- Result:
-- ORA-01400: cannot insert NULL into ("WKSP_LCOW2408"."IMP_EMPLOYEES"."SOC_SEC_NO")


-- Constraint Test 14
-- Description: Confirm Default constraint DATE column in ImP_employees table
-- Expected result: Insert will execute by entering the current date
-- Action
INSERT INTO ImP_employees VALUES (17, 'John', 'Doe', 122456799, default, 60000.00, NULL)
-- Result: 1 row(s) inserted
--passed

-- Constraint Test 15
-- Description: Confirm datatype constraint employee_id column in ImP_employees table
-- Expected result: Insert will fail with invalid error
-- Action
INSERT INTO ImP_employees VALUES ( 'twenty one', 'John', 'Doe', 122499009, default, 60000.00, NULL);
-- Result: ORA-01722: invalid number


-- Constraint Test 16
-- Description: Confirm datatype constraint hire_date column in ImP_employees table
-- Expected result: Insert will fail with invalid date error
-- Action
INSERT INTO ImP_employees VALUES ( 21, 'John', 'Doe', 122499009, 1234, 60000.00, NULL);
-- Result: Error at line 1/66: ORA-00932: inconsistent datatypes: expected DATE got NUMBER

