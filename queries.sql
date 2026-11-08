CREATE DATABASE retail_analytics;

show search_path;
create schema retail_analytics;
set search_path to retail_analytics;

CREATE TABLE IF NOT EXISTS customers (
    customer_id        INTEGER      PRIMARY KEY,
    customer_name      VARCHAR(100) NOT NULL,
    gender             VARCHAR(10)  CHECK (gender IN ('Male', 'Female')),
    city               VARCHAR(50),
    registration_date  DATE,
    customer_segment   VARCHAR(20)  CHECK (customer_segment IN ('Retail', 'Corporate', 'VIP'))
);

CREATE TABLE IF NOT EXISTS orders (
    order_id          INTEGER       PRIMARY KEY,
    customer_id       INTEGER       NOT NULL REFERENCES customers (customer_id),
    order_date        DATE          NOT NULL,
    product_name      VARCHAR(100),
    product_category  VARCHAR(50),
    quantity          INTEGER       CHECK (quantity > 0),
    unit_price        NUMERIC(12,2) CHECK (unit_price >= 0),
    cost_price        NUMERIC(12,2) CHECK (cost_price >= 0),
    discount          NUMERIC(5,2)  DEFAULT 0 CHECK (discount BETWEEN 0 AND 100),
    payment_method    VARCHAR(30)   CHECK (payment_method IN ('M-Pesa', 'Cash', 'Card', 'Bank Transfer')),
    order_status      VARCHAR(20)   CHECK (order_status IN ('Completed', 'Pending', 'Cancelled'))
);

-- Joins and date filters are the bread and butter of this project; these keep them quick.
CREATE INDEX IF NOT EXISTS idx_orders_customer ON orders (customer_id);
CREATE INDEX IF NOT EXISTS idx_orders_date ON orders (order_date);

INSERT INTO customers (customer_id, customer_name, gender, city, registration_date, customer_segment) VALUES
(1, 'Caroline Wambui', 'Male', 'Meru', '2026-06-09', 'VIP'),
(2, 'Victor Wekesa', 'Female', 'Thika', '2026-07-15', 'Retail'),
(3, 'Grace Mwangi', 'Female', 'Nyeri', '2025-04-24', 'Retail'),
(4, 'Zawadi Omondi', 'Female', 'Nairobi', '2025-08-04', 'VIP'),
(5, 'Joy Gitau', 'Male', 'Thika', '2026-06-10', 'Retail'),
(6, 'Purity Kimani', 'Female', 'Nairobi', '2024-05-12', 'Corporate'),
(7, 'Kevin Muthoni', 'Female', 'Meru', '2026-02-13', 'Retail'),
(8, 'Tabitha Omondi', 'Female', 'Meru', '2026-06-22', 'Retail'),
(9, 'Nancy Ndungu', 'Male', 'Thika', '2025-01-26', 'Corporate'),
(10, 'Agnes Ndungu', 'Female', 'Kisumu', '2025-04-16', 'Retail'),
(11, 'Felix Nduta', 'Female', 'Thika', '2026-04-13', 'VIP'),
(12, 'Purity Achieng', 'Female', 'Nyeri', '2025-11-12', 'Retail'),
(13, 'Esther Kimani', 'Male', 'Nairobi', '2025-01-10', 'VIP'),
(14, 'Mwangi Gitau', 'Female', 'Machakos', '2026-05-17', 'Retail'),
(15, 'Njeri Muthoni', 'Female', 'Nakuru', '2026-05-25', 'VIP'),
(16, 'Irene Wambui', 'Female', 'Eldoret', '2025-04-11', 'Corporate'),
(17, 'Otieno Achieng', 'Female', 'Meru', '2025-07-07', 'Retail'),
(18, 'Anne Nyambura', 'Female', 'Nairobi', '2024-11-11', 'Corporate'),
(19, 'Lucy Njoroge', 'Male', 'Nairobi', '2025-01-15', 'Retail'),
(20, 'Brian Maina', 'Male', 'Eldoret', '2025-09-11', 'Corporate'),
(21, 'Hassan Barasa', 'Male', 'Nairobi', '2026-01-01', 'Corporate'),
(22, 'Samuel Atieno', 'Male', 'Nakuru', '2026-05-19', 'Retail'),
(23, 'Collins Maina', 'Female', 'Nairobi', '2026-06-01', 'Corporate'),
(24, 'Collins Gitau', 'Female', 'Mombasa', '2025-11-10', 'Retail'),
(25, 'Esther Chebet', 'Female', 'Meru', '2024-04-24', 'Retail'),
(26, 'Joy Nyambura', 'Male', 'Kisumu', '2025-01-27', 'Retail'),
(27, 'Ian Muthoni', 'Female', 'Kiambu', '2024-05-02', 'Retail'),
(28, 'Diana Njoroge', 'Female', 'Eldoret', '2025-07-31', 'Retail'),
(29, 'Felix Barasa', 'Female', 'Nairobi', '2026-07-15', 'Retail'),
(30, 'Edwin Otieno', 'Female', 'Meru', '2025-02-19', 'Retail'),
(31, 'Nancy Korir', 'Male', 'Eldoret', '2025-01-21', 'Retail'),
(32, 'Peter Njoroge', 'Female', 'Nairobi', '2024-06-04', 'Retail'),
(33, 'Brian Chebet', 'Male', 'Nairobi', '2024-08-24', 'Retail'),
(34, 'Lucy Kimani', 'Female', 'Kisumu', '2025-11-30', 'Retail'),
(35, 'Peter Gitau', 'Male', 'Nairobi', '2024-04-18', 'VIP'),
(36, 'Mwangi Nyambura', 'Male', 'Kiambu', '2026-07-13', 'Retail'),
(37, 'Diana Odhiambo', 'Male', 'Nairobi', '2026-07-06', 'Corporate'),
(38, 'Rose Atieno', 'Female', 'Nakuru', '2025-08-08', 'Corporate'),
(39, 'Collins Kiprop', 'Female', 'Nairobi', '2025-04-09', 'Corporate'),
(40, 'Joy Mohamed', 'Female', 'Nairobi', '2025-04-19', 'Corporate'),
(41, 'Diana Achieng', 'Female', 'Meru', '2024-03-08', 'VIP'),
(42, 'George Kiplagat', 'Male', 'Nairobi', '2025-02-28', 'Retail'),
(43, 'Beatrice Barasa', 'Female', 'Nyeri', '2025-12-25', 'Retail'),
(44, 'Wafula Korir', 'Female', 'Nakuru', '2026-02-18', 'Retail'),
(45, 'Moses Barasa', 'Female', 'Mombasa', '2026-01-19', 'VIP'),
(46, 'Joy Otieno', 'Male', 'Nairobi', '2026-03-24', 'Retail'),
(47, 'Caroline Kimani', 'Male', 'Nakuru', '2025-11-23', 'Retail'),
(48, 'Rose Otieno', 'Male', 'Nakuru', '2025-04-26', 'Retail'),
(49, 'Collins Ndungu', 'Male', 'Mombasa', '2025-11-06', 'Retail'),
(50, 'Lucy Chebet', 'Male', 'Nyeri', '2026-03-08', 'Retail'),
(51, 'Achieng Barasa', 'Female', 'Meru', '2026-07-09', 'Corporate'),
(52, 'Felix Mwangi', 'Female', 'Mombasa', '2024-12-03', 'VIP'),
(53, 'Collins Nyambura', 'Male', 'Eldoret', '2025-07-03', 'VIP'),
(54, 'Otieno Rotich', 'Female', 'Nairobi', '2024-11-22', 'Corporate'),
(55, 'Wanjiru Kariuki', 'Male', 'Machakos', '2025-08-16', 'VIP'),
(56, 'Linda Korir', 'Female', 'Mombasa', '2025-08-27', 'Retail'),
(57, 'Joy Muthoni', 'Female', 'Nairobi', '2026-05-01', 'Retail'),
(58, 'Dennis Omondi', 'Female', 'Nyeri', '2025-12-29', 'Retail'),
(59, 'Brian Kimani', 'Male', 'Thika', '2025-09-29', 'Retail'),
(60, 'Achieng Wekesa', 'Female', 'Nakuru', '2024-12-24', 'VIP'),
(61, 'Kamau Wekesa', 'Male', 'Kiambu', '2026-06-13', 'Retail'),
(62, 'Dennis Mohamed', 'Female', 'Mombasa', '2026-07-15', 'Corporate'),
(63, 'Yusuf Gitau', 'Female', 'Nakuru', '2024-07-28', 'Retail'),
(64, 'Kamau Mutua', 'Female', 'Machakos', '2025-01-10', 'Retail'),
(65, 'Purity Ochieng', 'Male', 'Mombasa', '2025-01-31', 'Retail'),
(66, 'Achieng Kiprop', 'Female', 'Nairobi', '2025-01-03', 'Retail'),
(67, 'Purity Njoroge', 'Male', 'Nairobi', '2025-09-12', 'Retail'),
(68, 'Beatrice Nduta', 'Female', 'Nairobi', '2025-03-16', 'Retail'),
(69, 'Caroline Odhiambo', 'Male', 'Nakuru', '2026-05-26', 'Retail'),
(70, 'Joy Barasa', 'Male', 'Nairobi', '2025-12-20', 'VIP'),
(71, 'Njeri Atieno', 'Male', 'Mombasa', '2024-06-24', 'Retail'),
(72, 'Janet Wambui', 'Female', 'Mombasa', '2026-05-21', 'Retail'),
(73, 'Mwangi Kariuki', 'Female', 'Mombasa', '2025-12-23', 'Corporate'),
(74, 'Dennis Muthoni', 'Female', 'Nairobi', '2025-05-11', 'Corporate'),
(75, 'James Achieng', 'Female', 'Nairobi', '2026-04-01', 'Retail'),
(76, 'Felix Wambui', 'Female', 'Nairobi', '2025-05-07', 'Retail'),
(77, 'Linda Chebet', 'Female', 'Mombasa', '2024-08-16', 'Corporate'),
(78, 'Njeri Barasa', 'Male', 'Mombasa', '2026-07-14', 'Retail'),
(79, 'Alex Chebet', 'Female', 'Nakuru', '2025-01-11', 'Retail'),
(80, 'Janet Jeptoo', 'Female', 'Meru', '2026-03-01', 'Retail'),
(81, 'Amina Otieno', 'Female', 'Mombasa', '2025-05-04', 'Corporate'),
(82, 'Mwangi Ndungu', 'Male', 'Nakuru', '2024-09-06', 'Retail'),
(83, 'Amina Kiprop', 'Female', 'Nairobi', '2024-06-21', 'Corporate'),
(84, 'Agnes Kimani', 'Male', 'Nairobi', '2024-09-30', 'Retail'),
(85, 'Lucy Otieno', 'Male', 'Kiambu', '2024-11-18', 'VIP'),
(86, 'Yusuf Barasa', 'Female', 'Nakuru', '2025-12-22', 'Retail'),
(87, 'James Rotich', 'Male', 'Nairobi', '2024-11-06', 'Corporate'),
(88, 'George Rotich', 'Female', 'Nairobi', '2025-07-23', 'Corporate'),
(89, 'Linda Kimani', 'Female', 'Meru', '2024-03-28', 'Corporate'),
(90, 'Wafula Barasa', 'Female', 'Kiambu', '2026-06-30', 'Retail'),
(91, 'Otieno Ndungu', 'Female', 'Eldoret', '2026-05-16', 'Retail'),
(92, 'Anne Wekesa', 'Female', 'Kiambu', '2025-06-28', 'VIP'),
(93, 'Peter Ndungu', 'Male', 'Nairobi', '2025-04-19', 'Retail'),
(94, 'Moses Ndungu', 'Male', 'Nyeri', '2025-05-10', 'Retail'),
(95, 'Agnes Omondi', 'Female', 'Kiambu', '2024-08-14', 'Retail'),
(96, 'Victor Mohamed', 'Male', 'Thika', '2025-06-05', 'Retail'),
(97, 'Yusuf Jeptoo', 'Female', 'Nyeri', '2024-03-18', 'VIP'),
(98, 'Edwin Njoroge', 'Female', 'Nairobi', '2024-12-02', 'Retail'),
(99, 'Abdi Otieno', 'Female', 'Eldoret', '2025-06-07', 'Retail'),
(100, 'Purity Mwangi', 'Female', 'Meru', '2024-11-19', 'Retail'),
(101, 'Zawadi Mohamed', 'Male', 'Thika', '2025-11-29', 'Retail'),
(102, 'Beatrice Odhiambo', 'Female', 'Thika', '2025-09-21', 'Retail'),
(103, 'Esther Nduta', 'Female', 'Nairobi', '2026-03-09', 'Corporate'),
(104, 'Grace Kariuki', 'Male', 'Mombasa', '2026-05-22', 'Retail'),
(105, 'Moses Mohamed', 'Male', 'Kiambu', '2026-01-07', 'Retail'),
(106, 'Mercy Wekesa', 'Male', 'Thika', '2025-04-04', 'Retail'),
(107, 'Brian Odhiambo', 'Male', 'Nairobi', '2025-06-11', 'Retail'),
(108, 'Esther Kiplagat', 'Female', 'Nairobi', '2024-05-14', 'Retail'),
(109, 'Amina Omondi', 'Female', 'Kisumu', '2025-10-07', 'Retail'),
(110, 'Dennis Wekesa', 'Female', 'Mombasa', '2024-08-31', 'Retail'),
(111, 'Alex Korir', 'Female', 'Kiambu', '2025-12-01', 'Retail'),
(112, 'Mwangi Odhiambo', 'Male', 'Nyeri', '2026-06-23', 'Retail'),
(113, 'Brian Jeptoo', 'Female', 'Nakuru', '2024-11-26', 'Retail'),
(114, 'Wafula Gitau', 'Female', 'Nakuru', '2026-04-13', 'Retail'),
(115, 'James Njoroge', 'Male', 'Nairobi', '2024-09-17', 'Corporate'),
(116, 'Achieng Otieno', 'Male', 'Thika', '2025-03-14', 'Corporate'),
(117, 'Janet Korir', 'Male', 'Mombasa', '2024-10-28', 'VIP'),
(118, 'Abdi Kariuki', 'Female', 'Mombasa', '2026-06-11', 'Retail'),
(119, 'Tabitha Ochieng', 'Female', 'Nakuru', '2025-04-27', 'Retail'),
(120, 'Achieng Omondi', 'Male', 'Kisumu', '2026-01-29', 'Corporate'),
(121, 'Irene Kariuki', 'Female', 'Thika', '2025-11-18', 'Corporate'),
(122, 'Sharon Mwangi', 'Male', 'Kiambu', '2026-06-17', 'Retail'),
(123, 'Kevin Gitau', 'Male', 'Kisumu', '2024-04-08', 'Corporate'),
(124, 'Beatrice Gitau', 'Male', 'Nairobi', '2026-02-15', 'Retail'),
(125, 'Diana Ndungu', 'Male', 'Nairobi', '2024-09-08', 'VIP'),
(126, 'Akinyi Mutua', 'Female', 'Nakuru', '2025-04-29', 'Retail'),
(127, 'Abdi Muthoni', 'Male', 'Kiambu', '2026-06-12', 'VIP'),
(128, 'Esther Nyambura', 'Male', 'Nairobi', '2026-05-09', 'Retail'),
(129, 'Anne Achieng', 'Male', 'Kisumu', '2024-07-25', 'Retail'),
(130, 'Abdi Mohamed', 'Male', 'Kisumu', '2026-07-15', 'Retail'),
(131, 'Joy Kariuki', 'Male', 'Nairobi', '2026-04-21', 'Retail'),
(132, 'Brian Muthoni', 'Male', 'Nairobi', '2025-07-02', 'Retail'),
(133, 'Otieno Atieno', 'Male', 'Kisumu', '2025-10-13', 'Retail'),
(134, 'Anne Mohamed', 'Male', 'Nyeri', '2026-06-14', 'Retail'),
(135, 'Abdi Njoroge', 'Male', 'Kisumu', '2025-11-27', 'Retail'),
(136, 'Amina Rotich', 'Female', 'Eldoret', '2026-05-25', 'Retail'),
(137, 'Joy Wanjiku', 'Female', 'Nairobi', '2025-01-22', 'Retail'),
(138, 'Grace Kimani', 'Female', 'Thika', '2025-07-03', 'Retail'),
(139, 'Achieng Wambui', 'Female', 'Nakuru', '2025-06-29', 'Retail'),
(140, 'Nancy Atieno', 'Female', 'Nairobi', '2026-05-30', 'Retail'),
(141, 'Victor Ndungu', 'Female', 'Nairobi', '2024-09-25', 'Retail'),
(142, 'Dennis Chebet', 'Female', 'Nakuru', '2025-01-06', 'Retail'),
(143, 'James Muthoni', 'Female', 'Kisumu', '2026-01-30', 'Retail'),
(144, 'Ian Achieng', 'Female', 'Nairobi', '2026-02-25', 'Retail'),
(145, 'Diana Kiprop', 'Male', 'Nairobi', '2025-02-01', 'Corporate'),
(146, 'Agnes Atieno', 'Female', 'Nairobi', '2025-08-19', 'Retail'),
(147, 'Kamau Njoroge', 'Female', 'Nairobi', '2026-07-04', 'Retail'),
(148, 'Purity Wekesa', 'Female', 'Meru', '2025-09-27', 'Retail'),
(149, 'Edwin Ndungu', 'Female', 'Nairobi', '2024-06-09', 'Retail'),
(150, 'Sharon Njoroge', 'Female', 'Eldoret', '2026-01-20', 'Retail')
ON CONFLICT (customer_id) DO NOTHING;


INSERT INTO orders (order_id, customer_id, order_date, product_name, product_category, quantity, unit_price, cost_price, discount, payment_method, order_status) VALUES
(1001, 141, '2025-01-01', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 5.00, 'M-Pesa', 'Completed'),
(1002, 33, '2025-01-09', 'Sony Soundbar', 'Electronics', 3, 32500.00, 26400.00, 25.00, 'M-Pesa', 'Completed'),
(1003, 83, '2025-01-09', 'Oraimo Earbuds', 'Accessories', 3, 2999.00, 1400.00, 0.00, 'Cash', 'Completed'),
(1004, 35, '2025-01-11', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 5.00, 'M-Pesa', 'Cancelled'),
(1005, 84, '2025-01-13', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'Bank Transfer', 'Completed'),
(1006, 19, '2025-01-16', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'Bank Transfer', 'Completed'),
(1007, 60, '2025-01-17', 'Logitech Wireless Mouse', 'Accessories', 4, 1899.00, 950.00, 10.00, 'M-Pesa', 'Completed'),
(1008, 97, '2025-01-27', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 5.00, 'M-Pesa', 'Completed'),
(1009, 83, '2025-01-28', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 10.00, 'Bank Transfer', 'Completed'),
(1010, 141, '2025-01-28', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 5.00, 'Cash', 'Completed'),
(1011, 98, '2025-01-31', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 10.00, 'M-Pesa', 'Completed'),
(1012, 64, '2025-02-02', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1013, 145, '2025-02-04', 'Infinix Hot 40', 'Mobile Phones', 3, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1014, 129, '2025-02-05', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 5.00, 'M-Pesa', 'Completed'),
(1015, 129, '2025-02-05', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 20.00, 'Card', 'Completed'),
(1016, 60, '2025-02-06', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 10.00, 'Card', 'Pending'),
(1017, 60, '2025-02-07', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 5.00, 'M-Pesa', 'Completed'),
(1018, 64, '2025-02-07', 'Samsung Galaxy A15', 'Mobile Phones', 2, 21500.00, 17800.00, 5.00, 'M-Pesa', 'Completed'),
(1019, 66, '2025-02-07', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 10.00, 'Cash', 'Cancelled'),
(1020, 31, '2025-02-11', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'Cash', 'Completed'),
(1021, 65, '2025-02-13', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1022, 141, '2025-02-16', 'Anker 20W Charger', 'Accessories', 2, 2499.00, 1200.00, 15.00, 'Cash', 'Completed'),
(1023, 65, '2025-02-17', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'Card', 'Completed'),
(1024, 98, '2025-02-20', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 0.00, 'M-Pesa', 'Cancelled'),
(1025, 65, '2025-02-23', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 15.00, 'M-Pesa', 'Completed'),
(1026, 63, '2025-02-26', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 10.00, 'M-Pesa', 'Cancelled'),
(1027, 19, '2025-02-27', 'Oraimo Earbuds', 'Accessories', 2, 2999.00, 1400.00, 5.00, 'Bank Transfer', 'Completed'),
(1028, 66, '2025-02-27', 'Oraimo Earbuds', 'Accessories', 2, 2999.00, 1400.00, 0.00, 'Cash', 'Completed'),
(1029, 110, '2025-03-01', 'Samsung 55in Smart TV', 'Electronics', 3, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Cancelled'),
(1030, 98, '2025-03-03', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'Cash', 'Completed'),
(1031, 66, '2025-03-06', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Completed'),
(1032, 85, '2025-03-06', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 15.00, 'M-Pesa', 'Completed'),
(1033, 60, '2025-03-07', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 10.00, 'Card', 'Completed'),
(1034, 60, '2025-03-07', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Completed'),
(1035, 110, '2025-03-07', 'JBL Flip 6 Speaker', 'Electronics', 4, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Completed'),
(1036, 25, '2025-03-09', 'Anker 20W Charger', 'Accessories', 6, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1037, 85, '2025-03-12', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 10.00, 'M-Pesa', 'Completed'),
(1038, 64, '2025-03-13', 'HP 250 G9 Laptop', 'Computing', 3, 62999.00, 54200.00, 10.00, 'Bank Transfer', 'Completed'),
(1039, 141, '2025-03-13', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Card', 'Completed'),
(1040, 33, '2025-03-14', 'Mika Blender', 'Home Appliances', 4, 5499.00, 3900.00, 20.00, 'Card', 'Completed'),
(1041, 35, '2025-03-14', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 10.00, 'M-Pesa', 'Completed'),
(1042, 13, '2025-03-15', 'Hisense 43in Smart TV', 'Electronics', 2, 38999.00, 35200.00, 10.00, 'M-Pesa', 'Pending'),
(1043, 64, '2025-03-16', 'Anker 20W Charger', 'Accessories', 2, 2499.00, 1200.00, 0.00, 'Cash', 'Completed'),
(1044, 141, '2025-03-17', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 10.00, 'M-Pesa', 'Completed'),
(1045, 66, '2025-03-21', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 5.00, 'Card', 'Cancelled'),
(1046, 6, '2025-03-22', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1047, 149, '2025-03-22', 'Logitech Wireless Mouse', 'Accessories', 3, 1899.00, 950.00, 10.00, 'Card', 'Completed'),
(1048, 31, '2025-03-25', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 5.00, 'M-Pesa', 'Completed'),
(1049, 145, '2025-03-26', 'Infinix Hot 40', 'Mobile Phones', 2, 17499.00, 13900.00, 20.00, 'M-Pesa', 'Completed'),
(1050, 33, '2025-03-28', 'Dell 24in Monitor', 'Computing', 3, 21999.00, 16800.00, 5.00, 'M-Pesa', 'Completed'),
(1051, 141, '2025-03-28', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 0.00, 'Cash', 'Completed'),
(1052, 149, '2025-03-29', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Pending'),
(1053, 95, '2025-04-03', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 15.00, 'Cash', 'Completed'),
(1054, 108, '2025-04-03', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 15.00, 'M-Pesa', 'Cancelled'),
(1055, 68, '2025-04-04', 'JBL Flip 6 Speaker', 'Electronics', 2, 16500.00, 12100.00, 0.00, 'Bank Transfer', 'Completed'),
(1056, 110, '2025-04-07', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 20.00, 'Card', 'Completed'),
(1057, 145, '2025-04-09', 'Infinix Hot 40', 'Mobile Phones', 2, 17499.00, 13900.00, 10.00, 'Bank Transfer', 'Completed'),
(1058, 33, '2025-04-11', 'Sony Soundbar', 'Electronics', 2, 32500.00, 26400.00, 0.00, 'M-Pesa', 'Completed'),
(1059, 52, '2025-04-18', 'JBL Flip 6 Speaker', 'Electronics', 5, 16500.00, 12100.00, 10.00, 'M-Pesa', 'Completed'),
(1060, 142, '2025-04-18', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 20.00, 'M-Pesa', 'Completed'),
(1061, 141, '2025-04-20', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 25.00, 'Card', 'Completed'),
(1062, 63, '2025-04-22', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Card', 'Completed'),
(1063, 141, '2025-04-22', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 20.00, 'M-Pesa', 'Cancelled'),
(1064, 63, '2025-04-24', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 15.00, 'M-Pesa', 'Completed'),
(1065, 48, '2025-04-26', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 10.00, 'Card', 'Cancelled'),
(1066, 93, '2025-04-26', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 20.00, 'Bank Transfer', 'Completed'),
(1067, 39, '2025-04-27', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 5.00, 'Card', 'Completed'),
(1068, 125, '2025-04-27', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 15.00, 'M-Pesa', 'Completed'),
(1069, 66, '2025-04-28', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1070, 39, '2025-04-29', 'Logitech Wireless Mouse', 'Accessories', 4, 1899.00, 950.00, 10.00, 'Cash', 'Cancelled'),
(1071, 115, '2025-04-29', 'Ramtons Microwave', 'Home Appliances', 6, 11999.00, 9400.00, 5.00, 'M-Pesa', 'Completed'),
(1072, 85, '2025-04-30', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 10.00, 'Card', 'Completed'),
(1073, 85, '2025-05-02', 'Samsung 55in Smart TV', 'Electronics', 2, 79999.00, 72800.00, 5.00, 'Cash', 'Completed'),
(1074, 60, '2025-05-03', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 5.00, 'Cash', 'Pending'),
(1075, 19, '2025-05-04', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 10.00, 'M-Pesa', 'Completed'),
(1076, 83, '2025-05-05', 'Infinix Hot 40', 'Mobile Phones', 5, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Pending'),
(1077, 64, '2025-05-06', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1078, 66, '2025-05-08', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1079, 93, '2025-05-08', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 15.00, 'M-Pesa', 'Completed'),
(1080, 6, '2025-05-11', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 25.00, 'M-Pesa', 'Completed'),
(1081, 82, '2025-05-14', 'HP 250 G9 Laptop', 'Computing', 2, 62999.00, 54200.00, 25.00, 'Bank Transfer', 'Completed'),
(1082, 149, '2025-05-15', 'Von Electric Kettle', 'Home Appliances', 4, 3299.00, 2100.00, 0.00, 'Bank Transfer', 'Completed'),
(1083, 149, '2025-05-16', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 0.00, 'Cash', 'Completed'),
(1084, 39, '2025-05-17', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Pending'),
(1085, 60, '2025-05-17', 'Ramtons Microwave', 'Home Appliances', 2, 11999.00, 9400.00, 0.00, 'Bank Transfer', 'Completed'),
(1086, 25, '2025-05-20', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1087, 64, '2025-05-20', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 10.00, 'Card', 'Pending'),
(1088, 116, '2025-05-20', 'Infinix Hot 40', 'Mobile Phones', 2, 17499.00, 13900.00, 10.00, 'M-Pesa', 'Completed'),
(1089, 35, '2025-05-23', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 10.00, 'Card', 'Completed'),
(1090, 41, '2025-05-23', 'HP LaserJet Printer', 'Computing', 3, 28500.00, 22900.00, 10.00, 'M-Pesa', 'Completed'),
(1091, 68, '2025-05-26', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'Bank Transfer', 'Completed'),
(1092, 149, '2025-05-26', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Completed'),
(1093, 31, '2025-05-27', 'Sony WH-CH520 Headphones', 'Accessories', 2, 7999.00, 5100.00, 5.00, 'M-Pesa', 'Cancelled'),
(1094, 85, '2025-05-28', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 10.00, 'M-Pesa', 'Completed'),
(1095, 85, '2025-05-31', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 10.00, 'Card', 'Completed'),
(1096, 39, '2025-06-05', 'Infinix Hot 40', 'Mobile Phones', 6, 17499.00, 13900.00, 20.00, 'M-Pesa', 'Completed'),
(1097, 63, '2025-06-06', 'Infinix Hot 40', 'Mobile Phones', 3, 17499.00, 13900.00, 0.00, 'Bank Transfer', 'Completed'),
(1098, 100, '2025-06-06', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'M-Pesa', 'Completed'),
(1099, 79, '2025-06-08', 'Dell 24in Monitor', 'Computing', 2, 21999.00, 16800.00, 20.00, 'M-Pesa', 'Completed'),
(1100, 145, '2025-06-08', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 15.00, 'M-Pesa', 'Completed'),
(1101, 81, '2025-06-12', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'M-Pesa', 'Completed'),
(1102, 81, '2025-06-15', 'iPhone 13', 'Mobile Phones', 2, 89999.00, 78500.00, 5.00, 'M-Pesa', 'Completed'),
(1103, 141, '2025-06-15', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 15.00, 'Cash', 'Completed'),
(1104, 145, '2025-06-15', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'M-Pesa', 'Completed'),
(1105, 145, '2025-06-15', 'Von Electric Kettle', 'Home Appliances', 3, 3299.00, 2100.00, 0.00, 'M-Pesa', 'Completed'),
(1106, 129, '2025-06-20', 'Ramtons Microwave', 'Home Appliances', 5, 11999.00, 9400.00, 0.00, 'M-Pesa', 'Completed'),
(1107, 64, '2025-06-23', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Cancelled'),
(1108, 68, '2025-06-24', 'Logitech Wireless Keyboard', 'Accessories', 4, 3499.00, 1900.00, 5.00, 'Card', 'Completed'),
(1109, 129, '2025-06-24', 'HP LaserJet Printer', 'Computing', 2, 28500.00, 22900.00, 5.00, 'M-Pesa', 'Completed'),
(1110, 99, '2025-06-25', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Completed'),
(1111, 149, '2025-06-25', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'M-Pesa', 'Cancelled'),
(1112, 19, '2025-06-26', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Bank Transfer', 'Completed'),
(1113, 60, '2025-06-26', 'Lenovo IdeaPad 3', 'Computing', 2, 58500.00, 49900.00, 20.00, 'M-Pesa', 'Pending'),
(1114, 107, '2025-06-28', 'Infinix Hot 40', 'Mobile Phones', 2, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1115, 31, '2025-06-29', 'Mika Blender', 'Home Appliances', 6, 5499.00, 3900.00, 5.00, 'M-Pesa', 'Completed'),
(1116, 141, '2025-06-29', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'M-Pesa', 'Completed'),
(1117, 6, '2025-07-01', 'Von Electric Kettle', 'Home Appliances', 4, 3299.00, 2100.00, 15.00, 'M-Pesa', 'Cancelled'),
(1118, 125, '2025-07-02', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 15.00, 'M-Pesa', 'Cancelled'),
(1119, 19, '2025-07-03', 'iPhone 13', 'Mobile Phones', 2, 89999.00, 78500.00, 10.00, 'Bank Transfer', 'Completed'),
(1120, 65, '2025-07-03', 'HP 250 G9 Laptop', 'Computing', 2, 62999.00, 54200.00, 10.00, 'M-Pesa', 'Completed'),
(1121, 95, '2025-07-03', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Pending'),
(1122, 119, '2025-07-03', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 10.00, 'M-Pesa', 'Pending'),
(1123, 65, '2025-07-08', 'Ramtons Microwave', 'Home Appliances', 3, 11999.00, 9400.00, 0.00, 'Card', 'Completed'),
(1124, 83, '2025-07-08', 'Mika Blender', 'Home Appliances', 6, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Cancelled'),
(1125, 145, '2025-07-09', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Completed'),
(1126, 115, '2025-07-10', 'Infinix Hot 40', 'Mobile Phones', 9, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1127, 139, '2025-07-12', 'JBL Flip 6 Speaker', 'Electronics', 4, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Completed'),
(1128, 110, '2025-07-13', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 20.00, 'M-Pesa', 'Completed'),
(1129, 60, '2025-07-14', 'Infinix Hot 40', 'Mobile Phones', 3, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1130, 93, '2025-07-15', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'Card', 'Completed'),
(1131, 95, '2025-07-15', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'M-Pesa', 'Completed'),
(1132, 117, '2025-07-16', 'Dell 24in Monitor', 'Computing', 2, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1133, 93, '2025-07-17', 'Hisense 43in Smart TV', 'Electronics', 3, 38999.00, 35200.00, 10.00, 'M-Pesa', 'Completed'),
(1134, 99, '2025-07-17', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'Card', 'Cancelled'),
(1135, 97, '2025-07-19', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 10.00, 'M-Pesa', 'Completed'),
(1136, 76, '2025-07-20', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 5.00, 'Cash', 'Completed'),
(1137, 108, '2025-07-20', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'Cash', 'Completed'),
(1138, 129, '2025-07-20', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 10.00, 'M-Pesa', 'Completed'),
(1139, 68, '2025-07-21', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 5.00, 'M-Pesa', 'Pending'),
(1140, 81, '2025-07-21', 'Infinix Hot 40', 'Mobile Phones', 3, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Cancelled'),
(1141, 53, '2025-07-22', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 10.00, 'M-Pesa', 'Completed'),
(1142, 65, '2025-07-22', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 0.00, 'Cash', 'Completed'),
(1143, 95, '2025-07-22', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 10.00, 'M-Pesa', 'Cancelled'),
(1144, 65, '2025-07-24', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 0.00, 'Bank Transfer', 'Pending'),
(1145, 117, '2025-07-24', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 10.00, 'Cash', 'Completed'),
(1146, 66, '2025-07-25', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 0.00, 'M-Pesa', 'Pending'),
(1147, 32, '2025-07-26', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 25.00, 'Card', 'Completed'),
(1148, 117, '2025-07-26', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 20.00, 'Card', 'Pending'),
(1149, 81, '2025-07-28', 'Logitech Wireless Mouse', 'Accessories', 3, 1899.00, 950.00, 0.00, 'Bank Transfer', 'Completed'),
(1150, 41, '2025-07-29', 'JBL Flip 6 Speaker', 'Electronics', 5, 16500.00, 12100.00, 10.00, 'Cash', 'Completed'),
(1151, 83, '2025-07-29', 'Sony Soundbar', 'Electronics', 2, 32500.00, 26400.00, 5.00, 'Card', 'Completed'),
(1152, 85, '2025-07-29', 'Logitech Wireless Mouse', 'Accessories', 3, 1899.00, 950.00, 0.00, 'M-Pesa', 'Cancelled'),
(1153, 66, '2025-07-31', 'Von Electric Kettle', 'Home Appliances', 3, 3299.00, 2100.00, 5.00, 'M-Pesa', 'Completed'),
(1154, 52, '2025-08-01', 'Hotpoint Refrigerator', 'Home Appliances', 3, 54999.00, 49800.00, 10.00, 'Card', 'Completed'),
(1155, 64, '2025-08-01', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 5.00, 'M-Pesa', 'Completed'),
(1156, 68, '2025-08-01', 'Tecno Spark 20', 'Mobile Phones', 2, 15999.00, 12400.00, 0.00, 'Bank Transfer', 'Completed'),
(1157, 149, '2025-08-01', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Card', 'Pending'),
(1158, 35, '2025-08-02', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Card', 'Completed'),
(1159, 145, '2025-08-03', 'Anker 20W Charger', 'Accessories', 7, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1160, 64, '2025-08-04', 'Anker 20W Charger', 'Accessories', 2, 2499.00, 1200.00, 0.00, 'Card', 'Completed'),
(1161, 52, '2025-08-05', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 10.00, 'Card', 'Pending'),
(1162, 95, '2025-08-05', 'Oraimo Earbuds', 'Accessories', 2, 2999.00, 1400.00, 0.00, 'Card', 'Completed'),
(1163, 68, '2025-08-07', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 15.00, 'M-Pesa', 'Completed'),
(1164, 35, '2025-08-09', 'JBL Flip 6 Speaker', 'Electronics', 5, 16500.00, 12100.00, 10.00, 'Cash', 'Pending'),
(1165, 35, '2025-08-09', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 15.00, 'Bank Transfer', 'Completed'),
(1166, 85, '2025-08-09', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 10.00, 'M-Pesa', 'Completed'),
(1167, 35, '2025-08-10', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 10.00, 'Card', 'Cancelled'),
(1168, 141, '2025-08-11', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'Card', 'Completed'),
(1169, 129, '2025-08-12', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1170, 149, '2025-08-12', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'Card', 'Completed'),
(1171, 95, '2025-08-13', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 15.00, 'M-Pesa', 'Cancelled'),
(1172, 98, '2025-08-14', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 10.00, 'M-Pesa', 'Completed'),
(1173, 17, '2025-08-15', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'M-Pesa', 'Completed'),
(1174, 141, '2025-08-15', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 10.00, 'M-Pesa', 'Cancelled'),
(1175, 39, '2025-08-17', 'Ramtons Microwave', 'Home Appliances', 4, 11999.00, 9400.00, 5.00, 'Bank Transfer', 'Completed'),
(1176, 93, '2025-08-18', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'Cash', 'Completed'),
(1177, 81, '2025-08-19', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Completed'),
(1178, 129, '2025-08-19', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 0.00, 'Bank Transfer', 'Completed'),
(1179, 85, '2025-08-20', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 5.00, 'M-Pesa', 'Cancelled'),
(1180, 60, '2025-08-23', 'Ramtons Microwave', 'Home Appliances', 4, 11999.00, 9400.00, 10.00, 'Cash', 'Cancelled'),
(1181, 39, '2025-08-24', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 15.00, 'Bank Transfer', 'Cancelled'),
(1182, 64, '2025-08-24', 'Mika Blender', 'Home Appliances', 4, 5499.00, 3900.00, 10.00, 'Bank Transfer', 'Completed'),
(1183, 116, '2025-08-24', 'Infinix Hot 40', 'Mobile Phones', 6, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1184, 145, '2025-08-24', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Pending'),
(1185, 68, '2025-08-26', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'Card', 'Completed'),
(1186, 33, '2025-08-27', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 10.00, 'Cash', 'Completed'),
(1187, 3, '2025-08-30', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Completed'),
(1188, 65, '2025-08-30', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'Bank Transfer', 'Pending'),
(1189, 110, '2025-08-30', 'iPhone 13', 'Mobile Phones', 3, 89999.00, 78500.00, 15.00, 'M-Pesa', 'Cancelled'),
(1190, 110, '2025-08-31', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'M-Pesa', 'Completed'),
(1191, 141, '2025-08-31', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1192, 25, '2025-09-01', 'Von Electric Kettle', 'Home Appliances', 6, 3299.00, 2100.00, 0.00, 'M-Pesa', 'Completed'),
(1193, 39, '2025-09-01', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Cancelled'),
(1194, 81, '2025-09-01', 'Anker 20W Charger', 'Accessories', 4, 2499.00, 1200.00, 0.00, 'Cash', 'Completed'),
(1195, 53, '2025-09-03', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 5.00, 'M-Pesa', 'Completed'),
(1196, 110, '2025-09-04', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Completed'),
(1197, 116, '2025-09-04', 'Mika Blender', 'Home Appliances', 9, 5499.00, 3900.00, 20.00, 'Card', 'Completed'),
(1198, 96, '2025-09-05', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'Cash', 'Pending'),
(1199, 81, '2025-09-06', 'Logitech Wireless Keyboard', 'Accessories', 2, 3499.00, 1900.00, 0.00, 'Bank Transfer', 'Completed'),
(1200, 64, '2025-09-07', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 20.00, 'M-Pesa', 'Completed'),
(1201, 13, '2025-09-08', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 10.00, 'Bank Transfer', 'Completed'),
(1202, 33, '2025-09-08', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Pending'),
(1203, 6, '2025-09-09', 'Tecno Spark 20', 'Mobile Phones', 2, 15999.00, 12400.00, 0.00, 'M-Pesa', 'Completed'),
(1204, 19, '2025-09-09', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Completed'),
(1205, 63, '2025-09-13', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 0.00, 'Cash', 'Cancelled'),
(1206, 83, '2025-09-14', 'Anker 20W Charger', 'Accessories', 3, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1207, 149, '2025-09-14', 'Hisense 43in Smart TV', 'Electronics', 2, 38999.00, 35200.00, 0.00, 'Cash', 'Cancelled'),
(1208, 48, '2025-09-15', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 10.00, 'Card', 'Completed'),
(1209, 68, '2025-09-16', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'M-Pesa', 'Completed'),
(1210, 3, '2025-09-17', 'Mika Blender', 'Home Appliances', 3, 5499.00, 3900.00, 5.00, 'Card', 'Pending'),
(1211, 110, '2025-09-17', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 10.00, 'Cash', 'Completed'),
(1212, 129, '2025-09-18', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 0.00, 'Card', 'Pending'),
(1213, 13, '2025-09-19', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 15.00, 'M-Pesa', 'Completed'),
(1214, 68, '2025-09-19', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'M-Pesa', 'Completed'),
(1215, 85, '2025-09-20', 'Anker 20W Charger', 'Accessories', 2, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1216, 65, '2025-09-24', 'Sony WH-CH520 Headphones', 'Accessories', 2, 7999.00, 5100.00, 15.00, 'Bank Transfer', 'Completed'),
(1217, 83, '2025-09-24', 'Ramtons Microwave', 'Home Appliances', 5, 11999.00, 9400.00, 0.00, 'Card', 'Completed'),
(1218, 3, '2025-09-25', 'Infinix Hot 40', 'Mobile Phones', 4, 17499.00, 13900.00, 10.00, 'M-Pesa', 'Completed'),
(1219, 125, '2025-09-25', 'iPhone 13', 'Mobile Phones', 3, 89999.00, 78500.00, 10.00, 'M-Pesa', 'Completed'),
(1220, 63, '2025-09-27', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Card', 'Cancelled'),
(1221, 85, '2025-09-27', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 10.00, 'Card', 'Completed'),
(1222, 33, '2025-09-28', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'Card', 'Completed'),
(1223, 65, '2025-09-28', 'Von Electric Kettle', 'Home Appliances', 4, 3299.00, 2100.00, 0.00, 'M-Pesa', 'Completed'),
(1224, 6, '2025-09-29', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Completed'),
(1225, 60, '2025-09-30', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 15.00, 'M-Pesa', 'Completed'),
(1226, 146, '2025-09-30', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'Bank Transfer', 'Pending'),
(1227, 6, '2025-10-01', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'M-Pesa', 'Completed'),
(1228, 93, '2025-10-01', 'Mika Blender', 'Home Appliances', 5, 5499.00, 3900.00, 10.00, 'Bank Transfer', 'Completed'),
(1229, 67, '2025-10-04', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'Card', 'Completed'),
(1230, 95, '2025-10-04', 'JBL Flip 6 Speaker', 'Electronics', 2, 16500.00, 12100.00, 0.00, 'Cash', 'Completed'),
(1231, 141, '2025-10-04', 'Logitech Wireless Keyboard', 'Accessories', 3, 3499.00, 1900.00, 0.00, 'Card', 'Pending'),
(1232, 99, '2025-10-06', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'Card', 'Pending'),
(1233, 9, '2025-10-07', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1234, 81, '2025-10-07', 'Infinix Hot 40', 'Mobile Phones', 2, 17499.00, 13900.00, 20.00, 'M-Pesa', 'Completed'),
(1235, 85, '2025-10-08', 'Ramtons Microwave', 'Home Appliances', 5, 11999.00, 9400.00, 15.00, 'M-Pesa', 'Completed'),
(1236, 145, '2025-10-08', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 10.00, 'Bank Transfer', 'Completed'),
(1237, 6, '2025-10-10', 'Mika Blender', 'Home Appliances', 5, 5499.00, 3900.00, 0.00, 'Cash', 'Completed'),
(1238, 39, '2025-10-10', 'Mika Blender', 'Home Appliances', 6, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Completed'),
(1239, 25, '2025-10-11', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 5.00, 'M-Pesa', 'Completed'),
(1240, 65, '2025-10-15', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 0.00, 'M-Pesa', 'Completed'),
(1241, 33, '2025-10-16', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 0.00, 'Cash', 'Completed'),
(1242, 19, '2025-10-17', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1243, 65, '2025-10-18', 'Sony WH-CH520 Headphones', 'Accessories', 4, 7999.00, 5100.00, 5.00, 'M-Pesa', 'Completed'),
(1244, 95, '2025-10-18', 'Logitech Wireless Keyboard', 'Accessories', 4, 3499.00, 1900.00, 5.00, 'Bank Transfer', 'Completed'),
(1245, 63, '2025-10-19', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 5.00, 'Bank Transfer', 'Pending'),
(1246, 63, '2025-10-22', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'Bank Transfer', 'Completed'),
(1247, 92, '2025-10-22', 'iPhone 13', 'Mobile Phones', 2, 89999.00, 78500.00, 5.00, 'Card', 'Completed'),
(1248, 39, '2025-10-23', 'Tecno Spark 20', 'Mobile Phones', 3, 15999.00, 12400.00, 0.00, 'Card', 'Completed'),
(1249, 6, '2025-10-24', 'Logitech Wireless Mouse', 'Accessories', 5, 1899.00, 950.00, 0.00, 'M-Pesa', 'Completed'),
(1250, 115, '2025-10-24', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 5.00, 'Card', 'Completed'),
(1251, 145, '2025-10-24', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 5.00, 'M-Pesa', 'Completed'),
(1252, 19, '2025-10-26', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Cancelled'),
(1253, 113, '2025-10-26', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Cancelled'),
(1254, 145, '2025-10-26', 'Logitech Wireless Mouse', 'Accessories', 4, 1899.00, 950.00, 0.00, 'M-Pesa', 'Completed'),
(1255, 66, '2025-10-27', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'Cash', 'Cancelled'),
(1256, 85, '2025-10-27', 'Logitech Wireless Keyboard', 'Accessories', 4, 3499.00, 1900.00, 0.00, 'Cash', 'Completed'),
(1257, 141, '2025-10-27', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Completed'),
(1258, 60, '2025-10-29', 'Infinix Hot 40', 'Mobile Phones', 2, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1259, 64, '2025-10-29', 'Hotpoint Refrigerator', 'Home Appliances', 2, 54999.00, 49800.00, 10.00, 'M-Pesa', 'Completed'),
(1260, 149, '2025-10-29', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1261, 31, '2025-10-30', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 15.00, 'M-Pesa', 'Completed'),
(1262, 65, '2025-10-31', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 10.00, 'M-Pesa', 'Completed'),
(1263, 129, '2025-10-31', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 5.00, 'M-Pesa', 'Completed'),
(1264, 97, '2025-11-02', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 10.00, 'Card', 'Completed'),
(1265, 31, '2025-11-03', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 10.00, 'Card', 'Completed'),
(1266, 60, '2025-11-03', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 5.00, 'M-Pesa', 'Pending'),
(1267, 102, '2025-11-03', 'JBL Flip 6 Speaker', 'Electronics', 2, 16500.00, 12100.00, 15.00, 'Cash', 'Pending'),
(1268, 31, '2025-11-04', 'JBL Flip 6 Speaker', 'Electronics', 5, 16500.00, 12100.00, 0.00, 'Card', 'Completed'),
(1269, 117, '2025-11-04', 'Samsung Galaxy A15', 'Mobile Phones', 2, 21500.00, 17800.00, 10.00, 'Card', 'Completed'),
(1270, 117, '2025-11-04', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 10.00, 'M-Pesa', 'Completed'),
(1271, 38, '2025-11-05', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 10.00, 'Card', 'Completed'),
(1272, 66, '2025-11-05', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'Cash', 'Completed'),
(1273, 89, '2025-11-05', 'Logitech Wireless Keyboard', 'Accessories', 7, 3499.00, 1900.00, 15.00, 'M-Pesa', 'Completed'),
(1274, 53, '2025-11-06', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 5.00, 'M-Pesa', 'Completed'),
(1275, 66, '2025-11-06', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 25.00, 'M-Pesa', 'Completed'),
(1276, 4, '2025-11-07', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 5.00, 'M-Pesa', 'Completed'),
(1277, 149, '2025-11-07', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'M-Pesa', 'Completed'),
(1278, 20, '2025-11-09', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 20.00, 'Card', 'Completed'),
(1279, 33, '2025-11-09', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 10.00, 'M-Pesa', 'Cancelled'),
(1280, 93, '2025-11-09', 'Hisense 43in Smart TV', 'Electronics', 2, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1281, 31, '2025-11-10', 'Mika Blender', 'Home Appliances', 4, 5499.00, 3900.00, 15.00, 'M-Pesa', 'Completed'),
(1282, 95, '2025-11-10', 'Oraimo Earbuds', 'Accessories', 2, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Completed'),
(1283, 117, '2025-11-10', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 5.00, 'M-Pesa', 'Completed'),
(1284, 65, '2025-11-11', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 10.00, 'Cash', 'Completed'),
(1285, 4, '2025-11-12', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 10.00, 'M-Pesa', 'Completed'),
(1286, 19, '2025-11-12', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 10.00, 'Cash', 'Cancelled'),
(1287, 129, '2025-11-13', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 15.00, 'M-Pesa', 'Completed'),
(1288, 33, '2025-11-14', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 10.00, 'M-Pesa', 'Completed'),
(1289, 95, '2025-11-14', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 10.00, 'M-Pesa', 'Completed'),
(1290, 49, '2025-11-15', 'Tecno Spark 20', 'Mobile Phones', 2, 15999.00, 12400.00, 5.00, 'M-Pesa', 'Completed'),
(1291, 64, '2025-11-15', 'Ramtons Microwave', 'Home Appliances', 2, 11999.00, 9400.00, 0.00, 'Bank Transfer', 'Completed'),
(1292, 66, '2025-11-16', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 10.00, 'M-Pesa', 'Completed'),
(1293, 59, '2025-11-18', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 10.00, 'Cash', 'Completed'),
(1294, 117, '2025-11-18', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 15.00, 'M-Pesa', 'Completed'),
(1295, 117, '2025-11-18', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'M-Pesa', 'Completed'),
(1296, 85, '2025-11-19', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 10.00, 'M-Pesa', 'Completed'),
(1297, 82, '2025-11-20', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Completed'),
(1298, 116, '2025-11-20', 'JBL Flip 6 Speaker', 'Electronics', 2, 16500.00, 12100.00, 0.00, 'Cash', 'Pending'),
(1299, 145, '2025-11-21', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 0.00, 'Cash', 'Completed'),
(1300, 60, '2025-11-23', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 0.00, 'Card', 'Completed'),
(1301, 63, '2025-11-23', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 20.00, 'Bank Transfer', 'Completed'),
(1302, 95, '2025-11-23', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 0.00, 'Cash', 'Completed'),
(1303, 121, '2025-11-24', 'HP LaserJet Printer', 'Computing', 2, 28500.00, 22900.00, 5.00, 'M-Pesa', 'Completed'),
(1304, 41, '2025-11-25', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 5.00, 'M-Pesa', 'Completed'),
(1305, 145, '2025-11-25', 'Tecno Spark 20', 'Mobile Phones', 5, 15999.00, 12400.00, 5.00, 'Card', 'Pending'),
(1306, 3, '2025-11-26', 'Dell 24in Monitor', 'Computing', 2, 21999.00, 16800.00, 20.00, 'Cash', 'Pending'),
(1307, 68, '2025-11-27', 'Tecno Spark 20', 'Mobile Phones', 2, 15999.00, 12400.00, 0.00, 'Cash', 'Completed'),
(1308, 42, '2025-11-29', 'Oraimo Earbuds', 'Accessories', 2, 2999.00, 1400.00, 15.00, 'M-Pesa', 'Completed'),
(1309, 64, '2025-11-29', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 0.00, 'M-Pesa', 'Completed'),
(1310, 68, '2025-11-29', 'Oraimo Earbuds', 'Accessories', 3, 2999.00, 1400.00, 0.00, 'Card', 'Completed'),
(1311, 135, '2025-11-29', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 10.00, 'M-Pesa', 'Completed'),
(1312, 148, '2025-11-30', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 5.00, 'Card', 'Completed'),
(1313, 6, '2025-12-01', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 10.00, 'Bank Transfer', 'Completed'),
(1314, 65, '2025-12-02', 'Infinix Hot 40', 'Mobile Phones', 2, 17499.00, 13900.00, 10.00, 'M-Pesa', 'Completed'),
(1315, 110, '2025-12-02', 'Von Electric Kettle', 'Home Appliances', 3, 3299.00, 2100.00, 5.00, 'Bank Transfer', 'Completed'),
(1316, 39, '2025-12-03', 'JBL Flip 6 Speaker', 'Electronics', 5, 16500.00, 12100.00, 15.00, 'Card', 'Completed'),
(1317, 48, '2025-12-03', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 10.00, 'M-Pesa', 'Completed'),
(1318, 59, '2025-12-03', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'Cash', 'Completed'),
(1319, 83, '2025-12-03', 'Logitech Wireless Mouse', 'Accessories', 5, 1899.00, 950.00, 0.00, 'M-Pesa', 'Completed'),
(1320, 17, '2025-12-04', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Bank Transfer', 'Pending'),
(1321, 68, '2025-12-04', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 0.00, 'Cash', 'Completed'),
(1322, 39, '2025-12-05', 'Sony Soundbar', 'Electronics', 3, 32500.00, 26400.00, 10.00, 'M-Pesa', 'Cancelled'),
(1323, 102, '2025-12-05', 'Tecno Spark 20', 'Mobile Phones', 2, 15999.00, 12400.00, 0.00, 'Card', 'Completed'),
(1324, 68, '2025-12-06', 'Mika Blender', 'Home Appliances', 3, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Completed'),
(1325, 81, '2025-12-06', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 10.00, 'Cash', 'Pending'),
(1326, 116, '2025-12-07', 'Logitech Wireless Mouse', 'Accessories', 4, 1899.00, 950.00, 15.00, 'M-Pesa', 'Completed'),
(1327, 116, '2025-12-07', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Completed'),
(1328, 117, '2025-12-07', 'Logitech Wireless Mouse', 'Accessories', 3, 1899.00, 950.00, 0.00, 'Cash', 'Completed'),
(1329, 35, '2025-12-08', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 10.00, 'Bank Transfer', 'Completed'),
(1330, 117, '2025-12-08', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1331, 33, '2025-12-09', 'Samsung 55in Smart TV', 'Electronics', 3, 79999.00, 72800.00, 10.00, 'Cash', 'Completed'),
(1332, 42, '2025-12-09', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'M-Pesa', 'Completed'),
(1333, 83, '2025-12-09', 'JBL Flip 6 Speaker', 'Electronics', 5, 16500.00, 12100.00, 10.00, 'M-Pesa', 'Completed'),
(1334, 108, '2025-12-09', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'M-Pesa', 'Completed'),
(1335, 19, '2025-12-10', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Card', 'Completed'),
(1336, 68, '2025-12-10', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Cash', 'Completed'),
(1337, 16, '2025-12-11', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Completed'),
(1338, 93, '2025-12-11', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 20.00, 'Card', 'Completed'),
(1339, 55, '2025-12-12', 'Infinix Hot 40', 'Mobile Phones', 2, 17499.00, 13900.00, 10.00, 'M-Pesa', 'Cancelled'),
(1340, 110, '2025-12-12', 'Mika Blender', 'Home Appliances', 4, 5499.00, 3900.00, 5.00, 'Card', 'Completed'),
(1341, 4, '2025-12-13', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 10.00, 'M-Pesa', 'Completed'),
(1342, 66, '2025-12-13', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 10.00, 'Cash', 'Completed'),
(1343, 117, '2025-12-13', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 0.00, 'Card', 'Completed'),
(1344, 64, '2025-12-14', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Completed'),
(1345, 129, '2025-12-14', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 5.00, 'M-Pesa', 'Completed'),
(1346, 141, '2025-12-14', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 5.00, 'Cash', 'Pending'),
(1347, 31, '2025-12-15', 'Oraimo Earbuds', 'Accessories', 5, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Cancelled'),
(1348, 83, '2025-12-16', 'Von Electric Kettle', 'Home Appliances', 6, 3299.00, 2100.00, 0.00, 'M-Pesa', 'Completed'),
(1349, 60, '2025-12-18', 'Mika Blender', 'Home Appliances', 5, 5499.00, 3900.00, 10.00, 'M-Pesa', 'Completed'),
(1350, 111, '2025-12-18', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 0.00, 'Card', 'Completed'),
(1351, 95, '2025-12-19', 'Logitech Wireless Mouse', 'Accessories', 3, 1899.00, 950.00, 0.00, 'Card', 'Cancelled'),
(1352, 3, '2025-12-20', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Completed'),
(1353, 66, '2025-12-20', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 20.00, 'M-Pesa', 'Completed'),
(1354, 110, '2025-12-20', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Cancelled'),
(1355, 129, '2025-12-20', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 15.00, 'Bank Transfer', 'Completed'),
(1356, 52, '2025-12-21', 'Samsung Galaxy A15', 'Mobile Phones', 2, 21500.00, 17800.00, 10.00, 'M-Pesa', 'Completed'),
(1357, 81, '2025-12-21', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Card', 'Completed'),
(1358, 145, '2025-12-21', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 20.00, 'M-Pesa', 'Completed'),
(1359, 117, '2025-12-22', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1360, 149, '2025-12-22', 'Infinix Hot 40', 'Mobile Phones', 6, 17499.00, 13900.00, 15.00, 'M-Pesa', 'Completed'),
(1361, 3, '2025-12-23', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 5.00, 'M-Pesa', 'Completed'),
(1362, 117, '2025-12-23', 'Infinix Hot 40', 'Mobile Phones', 6, 17499.00, 13900.00, 20.00, 'M-Pesa', 'Completed'),
(1363, 65, '2025-12-24', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 0.00, 'M-Pesa', 'Completed'),
(1364, 149, '2025-12-24', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 10.00, 'Cash', 'Completed'),
(1365, 35, '2025-12-25', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 20.00, 'Cash', 'Completed'),
(1366, 43, '2025-12-25', 'Sony WH-CH520 Headphones', 'Accessories', 2, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Completed'),
(1367, 116, '2025-12-25', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 15.00, 'M-Pesa', 'Completed'),
(1368, 116, '2025-12-25', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'Cash', 'Completed'),
(1369, 125, '2025-12-25', 'Anker 20W Charger', 'Accessories', 3, 2499.00, 1200.00, 10.00, 'M-Pesa', 'Completed'),
(1370, 100, '2025-12-26', 'Anker 20W Charger', 'Accessories', 4, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Pending'),
(1371, 117, '2025-12-26', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 0.00, 'M-Pesa', 'Completed'),
(1372, 117, '2025-12-26', 'Sony WH-CH520 Headphones', 'Accessories', 2, 7999.00, 5100.00, 10.00, 'M-Pesa', 'Completed'),
(1373, 3, '2025-12-27', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 5.00, 'Cash', 'Completed'),
(1374, 6, '2025-12-28', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'Card', 'Completed'),
(1375, 95, '2025-12-28', 'Sony Soundbar', 'Electronics', 2, 32500.00, 26400.00, 10.00, 'Card', 'Completed'),
(1376, 81, '2025-12-29', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Card', 'Completed'),
(1377, 20, '2025-12-31', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1378, 34, '2025-12-31', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 20.00, 'M-Pesa', 'Completed'),
(1379, 55, '2025-12-31', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1380, 85, '2025-12-31', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Bank Transfer', 'Pending'),
(1381, 116, '2025-12-31', 'Tecno Spark 20', 'Mobile Phones', 3, 15999.00, 12400.00, 5.00, 'M-Pesa', 'Completed'),
(1382, 66, '2026-01-02', 'HP LaserJet Printer', 'Computing', 2, 28500.00, 22900.00, 10.00, 'Card', 'Completed'),
(1383, 31, '2026-01-03', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1384, 33, '2026-01-04', 'HP 250 G9 Laptop', 'Computing', 2, 62999.00, 54200.00, 0.00, 'Cash', 'Cancelled'),
(1385, 35, '2026-01-04', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 0.00, 'M-Pesa', 'Pending'),
(1386, 63, '2026-01-06', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 15.00, 'M-Pesa', 'Completed'),
(1387, 109, '2026-01-06', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 10.00, 'Card', 'Pending'),
(1388, 93, '2026-01-09', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Completed'),
(1389, 94, '2026-01-09', 'HP 250 G9 Laptop', 'Computing', 2, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Cancelled'),
(1390, 93, '2026-01-10', 'Sony WH-CH520 Headphones', 'Accessories', 3, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Cancelled'),
(1391, 117, '2026-01-16', 'Infinix Hot 40', 'Mobile Phones', 4, 17499.00, 13900.00, 10.00, 'Cash', 'Pending'),
(1392, 43, '2026-01-17', 'HP LaserJet Printer', 'Computing', 2, 28500.00, 22900.00, 5.00, 'Card', 'Completed'),
(1393, 4, '2026-01-21', 'JBL Flip 6 Speaker', 'Electronics', 3, 16500.00, 12100.00, 10.00, 'M-Pesa', 'Pending'),
(1394, 145, '2026-01-21', 'Logitech Wireless Keyboard', 'Accessories', 5, 3499.00, 1900.00, 5.00, 'M-Pesa', 'Completed'),
(1395, 68, '2026-01-22', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 5.00, 'M-Pesa', 'Completed'),
(1396, 141, '2026-01-22', 'Sony WH-CH520 Headphones', 'Accessories', 2, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Completed'),
(1397, 64, '2026-01-23', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 15.00, 'M-Pesa', 'Cancelled'),
(1398, 3, '2026-01-25', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Bank Transfer', 'Cancelled'),
(1399, 33, '2026-01-26', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 0.00, 'Card', 'Cancelled'),
(1400, 39, '2026-01-26', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 15.00, 'Card', 'Cancelled'),
(1401, 60, '2026-01-26', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 10.00, 'M-Pesa', 'Completed'),
(1402, 93, '2026-01-26', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 0.00, 'Card', 'Completed'),
(1403, 115, '2026-01-26', 'Mika Blender', 'Home Appliances', 4, 5499.00, 3900.00, 10.00, 'M-Pesa', 'Completed'),
(1404, 85, '2026-01-29', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Completed'),
(1405, 102, '2026-01-31', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 0.00, 'Card', 'Completed'),
(1406, 117, '2026-01-31', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 5.00, 'Card', 'Completed'),
(1407, 19, '2026-02-01', 'Anker 20W Charger', 'Accessories', 6, 2499.00, 1200.00, 5.00, 'Cash', 'Completed'),
(1408, 95, '2026-02-02', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 5.00, 'M-Pesa', 'Completed'),
(1409, 143, '2026-02-03', 'Logitech Wireless Keyboard', 'Accessories', 6, 3499.00, 1900.00, 10.00, 'Cash', 'Completed'),
(1410, 27, '2026-02-04', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'Cash', 'Completed'),
(1411, 54, '2026-02-04', 'Samsung Galaxy A15', 'Mobile Phones', 2, 21500.00, 17800.00, 0.00, 'M-Pesa', 'Completed'),
(1412, 110, '2026-02-04', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 0.00, 'Bank Transfer', 'Completed'),
(1413, 21, '2026-02-05', 'Logitech Wireless Keyboard', 'Accessories', 6, 3499.00, 1900.00, 0.00, 'Cash', 'Pending'),
(1414, 39, '2026-02-07', 'Logitech Wireless Keyboard', 'Accessories', 5, 3499.00, 1900.00, 5.00, 'M-Pesa', 'Completed'),
(1415, 65, '2026-02-07', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 5.00, 'Card', 'Completed'),
(1416, 53, '2026-02-09', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Pending'),
(1417, 6, '2026-02-12', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 10.00, 'Cash', 'Completed'),
(1418, 31, '2026-02-12', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 5.00, 'M-Pesa', 'Completed'),
(1419, 63, '2026-02-12', 'HP LaserJet Printer', 'Computing', 2, 28500.00, 22900.00, 10.00, 'Cash', 'Completed'),
(1420, 68, '2026-02-12', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 10.00, 'Card', 'Completed'),
(1421, 93, '2026-02-14', 'Lenovo IdeaPad 3', 'Computing', 3, 58500.00, 49900.00, 20.00, 'Card', 'Completed'),
(1422, 60, '2026-02-15', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 15.00, 'Cash', 'Completed'),
(1423, 19, '2026-02-16', 'Infinix Hot 40', 'Mobile Phones', 4, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Pending'),
(1424, 71, '2026-02-16', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Completed'),
(1425, 93, '2026-02-16', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'Card', 'Completed'),
(1426, 126, '2026-02-16', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'Cash', 'Completed'),
(1427, 145, '2026-02-16', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Cash', 'Completed'),
(1428, 3, '2026-02-17', 'Oraimo Earbuds', 'Accessories', 3, 2999.00, 1400.00, 0.00, 'Card', 'Cancelled'),
(1429, 119, '2026-02-17', 'Infinix Hot 40', 'Mobile Phones', 4, 17499.00, 13900.00, 5.00, 'M-Pesa', 'Completed'),
(1430, 149, '2026-02-17', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 0.00, 'Bank Transfer', 'Cancelled'),
(1431, 4, '2026-02-18', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 20.00, 'M-Pesa', 'Completed'),
(1432, 31, '2026-02-19', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1433, 68, '2026-02-19', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Completed'),
(1434, 81, '2026-02-19', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 0.00, 'Cash', 'Completed'),
(1435, 92, '2026-02-20', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 10.00, 'Cash', 'Cancelled'),
(1436, 150, '2026-02-20', 'Tecno Spark 20', 'Mobile Phones', 2, 15999.00, 12400.00, 0.00, 'Card', 'Cancelled'),
(1437, 40, '2026-02-21', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 5.00, 'Card', 'Completed'),
(1438, 65, '2026-02-24', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 5.00, 'M-Pesa', 'Completed'),
(1439, 145, '2026-02-25', 'Logitech Wireless Mouse', 'Accessories', 2, 1899.00, 950.00, 0.00, 'Cash', 'Completed'),
(1440, 19, '2026-02-26', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 0.00, 'M-Pesa', 'Completed'),
(1441, 93, '2026-02-26', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 5.00, 'M-Pesa', 'Completed'),
(1442, 31, '2026-03-01', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 10.00, 'Cash', 'Cancelled'),
(1443, 143, '2026-03-01', 'Oraimo Earbuds', 'Accessories', 4, 2999.00, 1400.00, 15.00, 'M-Pesa', 'Completed'),
(1444, 9, '2026-03-02', 'Oraimo Earbuds', 'Accessories', 2, 2999.00, 1400.00, 0.00, 'Cash', 'Completed'),
(1445, 60, '2026-03-02', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Completed'),
(1446, 142, '2026-03-02', 'Logitech Wireless Mouse', 'Accessories', 2, 1899.00, 950.00, 0.00, 'M-Pesa', 'Completed'),
(1447, 3, '2026-03-03', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'M-Pesa', 'Completed'),
(1448, 19, '2026-03-07', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 10.00, 'M-Pesa', 'Completed'),
(1449, 107, '2026-03-07', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'Card', 'Completed'),
(1450, 39, '2026-03-10', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 20.00, 'Card', 'Completed'),
(1451, 65, '2026-03-11', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 15.00, 'M-Pesa', 'Completed'),
(1452, 31, '2026-03-12', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Cash', 'Completed'),
(1453, 38, '2026-03-12', 'Sony WH-CH520 Headphones', 'Accessories', 7, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Cancelled'),
(1454, 63, '2026-03-12', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 10.00, 'M-Pesa', 'Completed'),
(1455, 19, '2026-03-14', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 0.00, 'M-Pesa', 'Completed'),
(1456, 35, '2026-03-14', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 10.00, 'M-Pesa', 'Completed'),
(1457, 19, '2026-03-15', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'Card', 'Completed'),
(1458, 60, '2026-03-15', 'Lenovo IdeaPad 3', 'Computing', 3, 58500.00, 49900.00, 10.00, 'Card', 'Completed'),
(1459, 93, '2026-03-15', 'iPhone 13', 'Mobile Phones', 2, 89999.00, 78500.00, 15.00, 'Cash', 'Completed'),
(1460, 150, '2026-03-15', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 20.00, 'M-Pesa', 'Completed'),
(1461, 35, '2026-03-16', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 5.00, 'M-Pesa', 'Completed'),
(1462, 117, '2026-03-16', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 10.00, 'Card', 'Completed'),
(1463, 141, '2026-03-16', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Cancelled'),
(1464, 64, '2026-03-19', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'Cash', 'Completed'),
(1465, 3, '2026-03-20', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 5.00, 'M-Pesa', 'Completed'),
(1466, 34, '2026-03-21', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 25.00, 'Card', 'Completed'),
(1467, 84, '2026-03-23', 'JBL Flip 6 Speaker', 'Electronics', 3, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Pending'),
(1468, 20, '2026-03-25', 'Logitech Wireless Keyboard', 'Accessories', 5, 3499.00, 1900.00, 5.00, 'Cash', 'Cancelled'),
(1469, 6, '2026-03-28', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Cancelled'),
(1470, 139, '2026-03-29', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 0.00, 'M-Pesa', 'Completed'),
(1471, 28, '2026-03-30', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 20.00, 'Cash', 'Completed'),
(1472, 80, '2026-03-31', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 20.00, 'M-Pesa', 'Completed'),
(1473, 33, '2026-04-02', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 15.00, 'M-Pesa', 'Cancelled'),
(1474, 65, '2026-04-02', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 5.00, 'M-Pesa', 'Completed'),
(1475, 124, '2026-04-02', 'Sony Soundbar', 'Electronics', 2, 32500.00, 26400.00, 15.00, 'M-Pesa', 'Completed'),
(1476, 146, '2026-04-02', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 5.00, 'M-Pesa', 'Completed'),
(1477, 95, '2026-04-03', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 5.00, 'Card', 'Completed'),
(1478, 31, '2026-04-07', 'Hisense 43in Smart TV', 'Electronics', 2, 38999.00, 35200.00, 0.00, 'Cash', 'Cancelled'),
(1479, 80, '2026-04-07', 'Samsung Galaxy A15', 'Mobile Phones', 2, 21500.00, 17800.00, 10.00, 'M-Pesa', 'Cancelled'),
(1480, 47, '2026-04-08', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Cancelled'),
(1481, 92, '2026-04-08', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 5.00, 'M-Pesa', 'Cancelled'),
(1482, 4, '2026-04-09', 'Dell 24in Monitor', 'Computing', 2, 21999.00, 16800.00, 5.00, 'M-Pesa', 'Completed'),
(1483, 49, '2026-04-09', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 10.00, 'M-Pesa', 'Completed'),
(1484, 65, '2026-04-09', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 10.00, 'Bank Transfer', 'Completed'),
(1485, 138, '2026-04-09', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 10.00, 'Cash', 'Completed'),
(1486, 89, '2026-04-10', 'Oraimo Earbuds', 'Accessories', 5, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Completed'),
(1487, 31, '2026-04-11', 'Tecno Spark 20', 'Mobile Phones', 5, 15999.00, 12400.00, 0.00, 'M-Pesa', 'Completed'),
(1488, 68, '2026-04-11', 'Von Electric Kettle', 'Home Appliances', 3, 3299.00, 2100.00, 5.00, 'M-Pesa', 'Completed'),
(1489, 4, '2026-04-12', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 10.00, 'M-Pesa', 'Completed'),
(1490, 21, '2026-04-13', 'Mika Blender', 'Home Appliances', 3, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Completed'),
(1491, 34, '2026-04-13', 'HP LaserJet Printer', 'Computing', 2, 28500.00, 22900.00, 10.00, 'M-Pesa', 'Completed'),
(1492, 81, '2026-04-13', 'Logitech Wireless Keyboard', 'Accessories', 4, 3499.00, 1900.00, 0.00, 'M-Pesa', 'Completed'),
(1493, 116, '2026-04-13', 'Anker 20W Charger', 'Accessories', 6, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1494, 56, '2026-04-14', 'HP 250 G9 Laptop', 'Computing', 3, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Completed'),
(1495, 45, '2026-04-15', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 0.00, 'Bank Transfer', 'Completed'),
(1496, 50, '2026-04-16', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'Bank Transfer', 'Completed'),
(1497, 109, '2026-04-16', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 10.00, 'M-Pesa', 'Completed'),
(1498, 33, '2026-04-17', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 10.00, 'M-Pesa', 'Completed'),
(1499, 102, '2026-04-17', 'HP 250 G9 Laptop', 'Computing', 2, 62999.00, 54200.00, 5.00, 'M-Pesa', 'Completed'),
(1500, 149, '2026-04-17', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'Cash', 'Pending'),
(1501, 31, '2026-04-18', 'Dell 24in Monitor', 'Computing', 3, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1502, 85, '2026-04-18', 'Mika Blender', 'Home Appliances', 4, 5499.00, 3900.00, 10.00, 'Card', 'Completed'),
(1503, 116, '2026-04-18', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'Card', 'Completed'),
(1504, 30, '2026-04-19', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1505, 65, '2026-04-19', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'M-Pesa', 'Completed'),
(1506, 45, '2026-04-20', 'Logitech Wireless Keyboard', 'Accessories', 2, 3499.00, 1900.00, 10.00, 'Cash', 'Completed'),
(1507, 35, '2026-04-21', 'Mika Blender', 'Home Appliances', 4, 5499.00, 3900.00, 10.00, 'Card', 'Completed'),
(1508, 98, '2026-04-21', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1509, 83, '2026-04-22', 'Logitech Wireless Keyboard', 'Accessories', 3, 3499.00, 1900.00, 0.00, 'Card', 'Cancelled'),
(1510, 11, '2026-04-24', 'Hisense 43in Smart TV', 'Electronics', 2, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1511, 20, '2026-04-24', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 15.00, 'M-Pesa', 'Completed'),
(1512, 33, '2026-04-24', 'JBL Flip 6 Speaker', 'Electronics', 2, 16500.00, 12100.00, 0.00, 'Card', 'Completed'),
(1513, 11, '2026-04-25', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Pending'),
(1514, 31, '2026-04-25', 'Samsung Galaxy A15', 'Mobile Phones', 3, 21500.00, 17800.00, 0.00, 'M-Pesa', 'Cancelled'),
(1515, 35, '2026-04-25', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1516, 67, '2026-04-26', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 15.00, 'Cash', 'Completed'),
(1517, 43, '2026-04-27', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'Cash', 'Completed'),
(1518, 31, '2026-04-29', 'HP 250 G9 Laptop', 'Computing', 2, 62999.00, 54200.00, 10.00, 'Cash', 'Completed'),
(1519, 120, '2026-04-30', 'Samsung Galaxy A15', 'Mobile Phones', 2, 21500.00, 17800.00, 10.00, 'Bank Transfer', 'Completed'),
(1520, 129, '2026-04-30', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'Cash', 'Completed'),
(1521, 145, '2026-04-30', 'Sony WH-CH520 Headphones', 'Accessories', 3, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Completed'),
(1522, 64, '2026-05-01', 'Tecno Spark 20', 'Mobile Phones', 2, 15999.00, 12400.00, 0.00, 'M-Pesa', 'Completed'),
(1523, 6, '2026-05-02', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Completed'),
(1524, 11, '2026-05-02', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 20.00, 'M-Pesa', 'Cancelled'),
(1525, 34, '2026-05-02', 'Sony WH-CH520 Headphones', 'Accessories', 5, 7999.00, 5100.00, 5.00, 'Bank Transfer', 'Completed'),
(1526, 63, '2026-05-02', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 15.00, 'Bank Transfer', 'Completed'),
(1527, 129, '2026-05-07', 'Hotpoint Refrigerator', 'Home Appliances', 2, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1528, 33, '2026-05-08', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Completed'),
(1529, 53, '2026-05-10', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Bank Transfer', 'Completed'),
(1530, 33, '2026-05-11', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 15.00, 'M-Pesa', 'Pending'),
(1531, 70, '2026-05-11', 'Ramtons Microwave', 'Home Appliances', 2, 11999.00, 9400.00, 0.00, 'M-Pesa', 'Completed'),
(1532, 110, '2026-05-12', 'Oraimo Earbuds', 'Accessories', 3, 2999.00, 1400.00, 10.00, 'M-Pesa', 'Completed'),
(1533, 138, '2026-05-13', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 10.00, 'Card', 'Cancelled'),
(1534, 16, '2026-05-14', 'Anker 20W Charger', 'Accessories', 3, 2499.00, 1200.00, 20.00, 'M-Pesa', 'Pending'),
(1535, 19, '2026-05-14', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1536, 41, '2026-05-17', 'JBL Flip 6 Speaker', 'Electronics', 2, 16500.00, 12100.00, 10.00, 'M-Pesa', 'Completed'),
(1537, 22, '2026-05-19', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'Card', 'Completed'),
(1538, 28, '2026-05-19', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 0.00, 'Bank Transfer', 'Completed'),
(1539, 116, '2026-05-19', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1540, 21, '2026-05-20', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 25.00, 'M-Pesa', 'Completed'),
(1541, 129, '2026-05-20', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'M-Pesa', 'Completed'),
(1542, 149, '2026-05-20', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 5.00, 'M-Pesa', 'Completed'),
(1543, 45, '2026-05-21', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 10.00, 'M-Pesa', 'Completed'),
(1544, 103, '2026-05-22', 'Dell 24in Monitor', 'Computing', 2, 21999.00, 16800.00, 10.00, 'Cash', 'Completed'),
(1545, 19, '2026-05-24', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 10.00, 'Cash', 'Completed'),
(1546, 65, '2026-05-25', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Completed'),
(1547, 135, '2026-05-25', 'Sony WH-CH520 Headphones', 'Accessories', 5, 7999.00, 5100.00, 10.00, 'M-Pesa', 'Cancelled'),
(1548, 141, '2026-05-25', 'Logitech Wireless Keyboard', 'Accessories', 5, 3499.00, 1900.00, 0.00, 'M-Pesa', 'Completed'),
(1549, 22, '2026-05-26', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 5.00, 'M-Pesa', 'Completed'),
(1550, 22, '2026-05-26', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 15.00, 'M-Pesa', 'Completed'),
(1551, 15, '2026-05-27', 'Sony WH-CH520 Headphones', 'Accessories', 3, 7999.00, 5100.00, 10.00, 'M-Pesa', 'Completed'),
(1552, 60, '2026-05-27', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'Card', 'Completed'),
(1553, 149, '2026-05-27', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 0.00, 'Card', 'Completed'),
(1554, 85, '2026-05-28', 'Tecno Spark 20', 'Mobile Phones', 3, 15999.00, 12400.00, 10.00, 'Card', 'Completed'),
(1555, 83, '2026-05-30', 'HP LaserJet Printer', 'Computing', 3, 28500.00, 22900.00, 0.00, 'M-Pesa', 'Completed'),
(1556, 103, '2026-05-30', 'JBL Flip 6 Speaker', 'Electronics', 3, 16500.00, 12100.00, 5.00, 'Card', 'Completed'),
(1557, 3, '2026-05-31', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Bank Transfer', 'Completed'),
(1558, 149, '2026-05-31', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'Cash', 'Pending'),
(1559, 88, '2026-06-01', 'Anker 20W Charger', 'Accessories', 4, 2499.00, 1200.00, 0.00, 'Card', 'Completed'),
(1560, 3, '2026-06-02', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 5.00, 'M-Pesa', 'Pending'),
(1561, 22, '2026-06-03', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 15.00, 'M-Pesa', 'Completed'),
(1562, 81, '2026-06-03', 'Oraimo Earbuds', 'Accessories', 3, 2999.00, 1400.00, 0.00, 'Bank Transfer', 'Completed'),
(1563, 93, '2026-06-06', 'Dell 24in Monitor', 'Computing', 2, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1564, 129, '2026-06-06', 'Hisense 43in Smart TV', 'Electronics', 2, 38999.00, 35200.00, 5.00, 'Card', 'Completed'),
(1565, 21, '2026-06-07', 'Infinix Hot 40', 'Mobile Phones', 5, 17499.00, 13900.00, 5.00, 'M-Pesa', 'Completed'),
(1566, 6, '2026-06-08', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 20.00, 'M-Pesa', 'Pending'),
(1567, 117, '2026-06-08', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'M-Pesa', 'Completed'),
(1568, 83, '2026-06-09', 'Mika Blender', 'Home Appliances', 5, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Completed'),
(1569, 127, '2026-06-12', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 15.00, 'Bank Transfer', 'Completed'),
(1570, 57, '2026-06-13', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 15.00, 'Card', 'Completed'),
(1571, 1, '2026-06-14', 'HP LaserJet Printer', 'Computing', 2, 28500.00, 22900.00, 0.00, 'M-Pesa', 'Completed'),
(1572, 55, '2026-06-14', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 10.00, 'M-Pesa', 'Pending'),
(1573, 101, '2026-06-14', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1574, 11, '2026-06-16', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'M-Pesa', 'Completed'),
(1575, 150, '2026-06-16', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'Card', 'Completed'),
(1576, 34, '2026-06-17', 'Lenovo IdeaPad 3', 'Computing', 3, 58500.00, 49900.00, 5.00, 'M-Pesa', 'Completed'),
(1577, 145, '2026-06-17', 'Hotpoint Refrigerator', 'Home Appliances', 2, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1578, 110, '2026-06-18', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1579, 6, '2026-06-19', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 5.00, 'M-Pesa', 'Pending'),
(1580, 64, '2026-06-19', 'Mika Blender', 'Home Appliances', 3, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Completed'),
(1581, 68, '2026-06-19', 'Ramtons Microwave', 'Home Appliances', 6, 11999.00, 9400.00, 5.00, 'M-Pesa', 'Completed'),
(1582, 104, '2026-06-19', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 20.00, 'Cash', 'Completed'),
(1583, 11, '2026-06-20', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 10.00, 'Bank Transfer', 'Completed'),
(1584, 23, '2026-06-20', 'JBL Flip 6 Speaker', 'Electronics', 4, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Pending'),
(1585, 64, '2026-06-20', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 5.00, 'M-Pesa', 'Completed'),
(1586, 143, '2026-06-21', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 5.00, 'Cash', 'Completed'),
(1587, 149, '2026-06-21', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 10.00, 'Cash', 'Completed'),
(1588, 33, '2026-06-22', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'Bank Transfer', 'Completed'),
(1589, 35, '2026-06-22', 'Ramtons Microwave', 'Home Appliances', 5, 11999.00, 9400.00, 5.00, 'M-Pesa', 'Pending'),
(1590, 3, '2026-06-23', 'HP LaserJet Printer', 'Computing', 2, 28500.00, 22900.00, 5.00, 'M-Pesa', 'Completed'),
(1591, 41, '2026-06-23', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 10.00, 'Card', 'Pending'),
(1592, 55, '2026-06-23', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 15.00, 'Cash', 'Completed'),
(1593, 89, '2026-06-23', 'Hotpoint Refrigerator', 'Home Appliances', 3, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1594, 24, '2026-06-24', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 20.00, 'M-Pesa', 'Completed'),
(1595, 145, '2026-06-24', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 5.00, 'M-Pesa', 'Completed'),
(1596, 5, '2026-06-26', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 0.00, 'Cash', 'Completed'),
(1597, 73, '2026-06-26', 'Anker 20W Charger', 'Accessories', 6, 2499.00, 1200.00, 0.00, 'Card', 'Cancelled'),
(1598, 102, '2026-06-26', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 0.00, 'Bank Transfer', 'Completed'),
(1599, 129, '2026-06-26', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Pending'),
(1600, 16, '2026-06-27', 'Logitech Wireless Mouse', 'Accessories', 6, 1899.00, 950.00, 10.00, 'M-Pesa', 'Pending'),
(1601, 24, '2026-06-27', 'JBL Flip 6 Speaker', 'Electronics', 2, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Completed'),
(1602, 81, '2026-06-27', 'Ramtons Microwave', 'Home Appliances', 3, 11999.00, 9400.00, 0.00, 'M-Pesa', 'Completed'),
(1603, 93, '2026-06-27', 'Logitech Wireless Mouse', 'Accessories', 2, 1899.00, 950.00, 0.00, 'Bank Transfer', 'Completed'),
(1604, 8, '2026-06-28', 'HP LaserJet Printer', 'Computing', 3, 28500.00, 22900.00, 5.00, 'Cash', 'Completed'),
(1605, 44, '2026-06-28', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 15.00, 'M-Pesa', 'Completed'),
(1606, 57, '2026-06-28', 'Tecno Spark 20', 'Mobile Phones', 2, 15999.00, 12400.00, 0.00, 'M-Pesa', 'Completed'),
(1607, 85, '2026-06-28', 'Hotpoint Refrigerator', 'Home Appliances', 2, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1608, 93, '2026-06-29', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Cancelled'),
(1609, 60, '2026-06-30', 'Infinix Hot 40', 'Mobile Phones', 5, 17499.00, 13900.00, 10.00, 'M-Pesa', 'Completed'),
(1610, 64, '2026-06-30', 'Logitech Wireless Mouse', 'Accessories', 3, 1899.00, 950.00, 5.00, 'Cash', 'Completed'),
(1611, 112, '2026-06-30', 'Ramtons Microwave', 'Home Appliances', 2, 11999.00, 9400.00, 5.00, 'M-Pesa', 'Completed'),
(1612, 113, '2026-06-30', 'Tecno Spark 20', 'Mobile Phones', 3, 15999.00, 12400.00, 5.00, 'Card', 'Cancelled'),
(1613, 136, '2026-06-30', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'M-Pesa', 'Completed'),
(1614, 69, '2026-07-01', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 0.00, 'M-Pesa', 'Completed'),
(1615, 118, '2026-07-02', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'Cash', 'Completed'),
(1616, 121, '2026-07-03', 'Mika Blender', 'Home Appliances', 4, 5499.00, 3900.00, 5.00, 'Card', 'Completed'),
(1617, 18, '2026-07-04', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 5.00, 'Cash', 'Completed'),
(1618, 63, '2026-07-04', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 5.00, 'M-Pesa', 'Completed'),
(1619, 104, '2026-07-05', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 5.00, 'Bank Transfer', 'Completed'),
(1620, 122, '2026-07-05', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 20.00, 'M-Pesa', 'Cancelled'),
(1621, 24, '2026-07-06', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 0.00, 'M-Pesa', 'Cancelled'),
(1622, 31, '2026-07-06', 'Ramtons Microwave', 'Home Appliances', 3, 11999.00, 9400.00, 10.00, 'M-Pesa', 'Completed'),
(1623, 1, '2026-07-07', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 15.00, 'Cash', 'Completed'),
(1624, 141, '2026-07-07', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'Card', 'Completed'),
(1625, 81, '2026-07-08', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'M-Pesa', 'Completed'),
(1626, 3, '2026-07-10', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'Cash', 'Completed'),
(1627, 14, '2026-07-10', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 15.00, 'Card', 'Completed'),
(1628, 46, '2026-07-10', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 5.00, 'Bank Transfer', 'Completed'),
(1629, 51, '2026-07-10', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 10.00, 'Card', 'Completed'),
(1630, 122, '2026-07-11', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 15.00, 'Card', 'Pending'),
(1631, 43, '2026-07-12', 'Oraimo Earbuds', 'Accessories', 4, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Completed'),
(1632, 68, '2026-07-12', 'Von Electric Kettle', 'Home Appliances', 4, 3299.00, 2100.00, 0.00, 'Card', 'Cancelled'),
(1633, 141, '2026-07-12', 'Ramtons Microwave', 'Home Appliances', 2, 11999.00, 9400.00, 5.00, 'Card', 'Pending'),
(1634, 134, '2026-07-13', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 0.00, 'M-Pesa', 'Pending'),
(1635, 7, '2026-07-14', 'Anker 20W Charger', 'Accessories', 3, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1636, 95, '2026-07-14', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 5.00, 'Cash', 'Completed'),
(1637, 36, '2026-07-15', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 15.00, 'Bank Transfer', 'Completed'),
(1638, 46, '2026-07-15', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 0.00, 'Cash', 'Completed'),
(1639, 60, '2026-07-15', 'Oraimo Earbuds', 'Accessories', 4, 2999.00, 1400.00, 5.00, 'Bank Transfer', 'Completed'),
(1640, 141, '2026-07-15', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'Bank Transfer', 'Completed'),
(1641, 150, '2026-07-15', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Cancelled'),
(1642, 7, '2026-07-16', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 0.00, 'M-Pesa', 'Completed'),
(1643, 28, '2026-07-16', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 5.00, 'M-Pesa', 'Completed'),
(1644, 31, '2026-07-16', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'Cash', 'Completed'),
(1645, 35, '2026-07-16', 'Ramtons Microwave', 'Home Appliances', 1, 11999.00, 9400.00, 10.00, 'Card', 'Completed'),
(1646, 116, '2026-07-16', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 25.00, 'Cash', 'Completed'),
(1647, 114, '2026-07-17', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 10.00, 'M-Pesa', 'Completed'),
(1648, 93, '2026-07-18', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'Card', 'Completed'),
(1649, 123, '2026-07-19', 'Sony WH-CH520 Headphones', 'Accessories', 7, 7999.00, 5100.00, 0.00, 'Card', 'Cancelled'),
(1650, 2, '2026-07-20', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Completed'),
(1651, 3, '2026-07-20', 'HP LaserJet Printer', 'Computing', 1, 28500.00, 22900.00, 5.00, 'M-Pesa', 'Completed'),
(1652, 60, '2026-07-20', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Cancelled'),
(1653, 72, '2026-07-20', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 10.00, 'M-Pesa', 'Completed'),
(1654, 39, '2026-07-21', 'Hisense 43in Smart TV', 'Electronics', 2, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1655, 112, '2026-07-21', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 0.00, 'Bank Transfer', 'Completed'),
(1656, 99, '2026-07-23', 'Samsung Galaxy A15', 'Mobile Phones', 2, 21500.00, 17800.00, 0.00, 'Cash', 'Cancelled'),
(1657, 136, '2026-07-23', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 20.00, 'Bank Transfer', 'Completed'),
(1658, 73, '2026-07-24', 'Anker 20W Charger', 'Accessories', 7, 2499.00, 1200.00, 5.00, 'Card', 'Completed'),
(1659, 148, '2026-07-24', 'Oraimo Earbuds', 'Accessories', 2, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Cancelled'),
(1660, 46, '2026-07-25', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 0.00, 'Bank Transfer', 'Completed'),
(1661, 64, '2026-07-25', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 0.00, 'Bank Transfer', 'Completed'),
(1662, 92, '2026-07-25', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1663, 1, '2026-07-26', 'Samsung 55in Smart TV', 'Electronics', 3, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Completed'),
(1664, 3, '2026-07-26', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'Card', 'Completed'),
(1665, 2, '2026-07-27', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Cancelled'),
(1666, 62, '2026-07-27', 'Ramtons Microwave', 'Home Appliances', 4, 11999.00, 9400.00, 0.00, 'M-Pesa', 'Pending'),
(1667, 129, '2026-07-27', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Cash', 'Completed'),
(1668, 14, '2026-07-28', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 5.00, 'Cash', 'Completed'),
(1669, 112, '2026-07-30', 'Samsung Galaxy A15', 'Mobile Phones', 3, 21500.00, 17800.00, 0.00, 'Bank Transfer', 'Completed'),
(1670, 75, '2026-07-31', 'Tecno Spark 20', 'Mobile Phones', 1, 15999.00, 12400.00, 15.00, 'Cash', 'Completed'),
(1671, 140, '2026-07-31', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 5.00, 'M-Pesa', 'Cancelled'),
(1672, 37, '2026-08-01', 'Infinix Hot 40', 'Mobile Phones', 4, 17499.00, 13900.00, 0.00, 'Cash', 'Completed'),
(1673, 53, '2026-08-01', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 10.00, 'Card', 'Completed'),
(1674, 75, '2026-08-01', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 10.00, 'M-Pesa', 'Completed'),
(1675, 30, '2026-08-02', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Completed'),
(1676, 89, '2026-08-02', 'Infinix Hot 40', 'Mobile Phones', 9, 17499.00, 13900.00, 0.00, 'Cash', 'Completed'),
(1677, 93, '2026-08-02', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1678, 4, '2026-08-03', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 0.00, 'Card', 'Completed'),
(1679, 29, '2026-08-03', 'Logitech Wireless Mouse', 'Accessories', 3, 1899.00, 950.00, 10.00, 'M-Pesa', 'Completed'),
(1680, 115, '2026-08-04', 'Anker 20W Charger', 'Accessories', 4, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Cancelled'),
(1681, 129, '2026-08-04', 'Ramtons Microwave', 'Home Appliances', 2, 11999.00, 9400.00, 0.00, 'M-Pesa', 'Completed'),
(1682, 19, '2026-08-05', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 10.00, 'Card', 'Completed'),
(1683, 23, '2026-08-06', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 0.00, 'M-Pesa', 'Completed'),
(1684, 26, '2026-08-06', 'Logitech Wireless Mouse', 'Accessories', 2, 1899.00, 950.00, 0.00, 'M-Pesa', 'Completed'),
(1685, 68, '2026-08-06', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Card', 'Completed'),
(1686, 64, '2026-08-07', 'Sony WH-CH520 Headphones', 'Accessories', 1, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Completed'),
(1687, 122, '2026-08-07', 'Hisense 43in Smart TV', 'Electronics', 2, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1688, 33, '2026-08-08', 'HP 250 G9 Laptop', 'Computing', 2, 62999.00, 54200.00, 10.00, 'M-Pesa', 'Completed'),
(1689, 39, '2026-08-08', 'Hisense 43in Smart TV', 'Electronics', 3, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Pending'),
(1690, 149, '2026-08-08', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 10.00, 'M-Pesa', 'Completed'),
(1691, 34, '2026-08-09', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'Card', 'Completed'),
(1692, 39, '2026-08-09', 'Anker 20W Charger', 'Accessories', 3, 2499.00, 1200.00, 5.00, 'M-Pesa', 'Cancelled'),
(1693, 99, '2026-08-09', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 5.00, 'M-Pesa', 'Completed'),
(1694, 110, '2026-08-09', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 0.00, 'M-Pesa', 'Cancelled'),
(1695, 3, '2026-08-10', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 5.00, 'Cash', 'Completed'),
(1696, 97, '2026-08-10', 'Samsung Galaxy A15', 'Mobile Phones', 2, 21500.00, 17800.00, 10.00, 'Cash', 'Completed'),
(1697, 118, '2026-08-11', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1698, 68, '2026-08-12', 'HP 250 G9 Laptop', 'Computing', 2, 62999.00, 54200.00, 0.00, 'Cash', 'Completed'),
(1699, 116, '2026-08-12', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1700, 122, '2026-08-12', 'Sony WH-CH520 Headphones', 'Accessories', 3, 7999.00, 5100.00, 5.00, 'Card', 'Completed'),
(1701, 7, '2026-08-14', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'M-Pesa', 'Completed'),
(1702, 45, '2026-08-14', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'M-Pesa', 'Completed'),
(1703, 72, '2026-08-14', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 25.00, 'M-Pesa', 'Completed'),
(1704, 22, '2026-08-15', 'Oraimo Earbuds', 'Accessories', 2, 2999.00, 1400.00, 5.00, 'M-Pesa', 'Completed'),
(1705, 65, '2026-08-16', 'Tecno Spark 20', 'Mobile Phones', 2, 15999.00, 12400.00, 0.00, 'Bank Transfer', 'Completed'),
(1706, 29, '2026-08-17', 'JBL Flip 6 Speaker', 'Electronics', 1, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Completed'),
(1707, 105, '2026-08-17', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 10.00, 'M-Pesa', 'Completed'),
(1708, 42, '2026-08-18', 'JBL Flip 6 Speaker', 'Electronics', 3, 16500.00, 12100.00, 0.00, 'Cash', 'Completed'),
(1709, 150, '2026-08-18', 'Von Electric Kettle', 'Home Appliances', 4, 3299.00, 2100.00, 20.00, 'Card', 'Completed'),
(1710, 3, '2026-08-19', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 15.00, 'M-Pesa', 'Completed'),
(1711, 51, '2026-08-19', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Completed'),
(1712, 63, '2026-08-19', 'HP 250 G9 Laptop', 'Computing', 3, 62999.00, 54200.00, 10.00, 'M-Pesa', 'Completed'),
(1713, 102, '2026-08-19', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 10.00, 'Cash', 'Cancelled'),
(1714, 19, '2026-08-20', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 0.00, 'M-Pesa', 'Completed'),
(1715, 75, '2026-08-20', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 5.00, 'Bank Transfer', 'Completed'),
(1716, 85, '2026-08-20', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 5.00, 'Bank Transfer', 'Completed'),
(1717, 104, '2026-08-20', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 10.00, 'M-Pesa', 'Completed'),
(1718, 6, '2026-08-21', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1719, 14, '2026-08-21', 'Oraimo Earbuds', 'Accessories', 3, 2999.00, 1400.00, 20.00, 'Card', 'Completed'),
(1720, 68, '2026-08-21', 'Logitech Wireless Mouse', 'Accessories', 4, 1899.00, 950.00, 10.00, 'Cash', 'Completed'),
(1721, 56, '2026-08-22', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Completed'),
(1722, 78, '2026-08-22', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1723, 85, '2026-08-22', 'Logitech Wireless Mouse', 'Accessories', 3, 1899.00, 950.00, 10.00, 'M-Pesa', 'Pending'),
(1724, 29, '2026-08-23', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1725, 78, '2026-08-24', 'Ramtons Microwave', 'Home Appliances', 2, 11999.00, 9400.00, 25.00, 'M-Pesa', 'Completed'),
(1726, 114, '2026-08-24', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 0.00, 'Bank Transfer', 'Completed'),
(1727, 117, '2026-08-24', 'Logitech Wireless Keyboard', 'Accessories', 2, 3499.00, 1900.00, 10.00, 'M-Pesa', 'Cancelled'),
(1728, 35, '2026-08-25', 'Von Electric Kettle', 'Home Appliances', 3, 3299.00, 2100.00, 10.00, 'Card', 'Pending'),
(1729, 11, '2026-08-26', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 10.00, 'Bank Transfer', 'Completed'),
(1730, 93, '2026-08-26', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 10.00, 'M-Pesa', 'Pending'),
(1731, 1, '2026-08-27', 'iPhone 13', 'Mobile Phones', 2, 89999.00, 78500.00, 15.00, 'Bank Transfer', 'Completed'),
(1732, 86, '2026-08-29', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'Card', 'Completed'),
(1733, 122, '2026-08-29', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 5.00, 'Card', 'Completed'),
(1734, 33, '2026-08-30', 'JBL Flip 6 Speaker', 'Electronics', 3, 16500.00, 12100.00, 0.00, 'Card', 'Completed'),
(1735, 136, '2026-09-01', 'HP 250 G9 Laptop', 'Computing', 3, 62999.00, 54200.00, 0.00, 'M-Pesa', 'Pending'),
(1736, 78, '2026-09-02', 'Samsung 55in Smart TV', 'Electronics', 1, 79999.00, 72800.00, 5.00, 'M-Pesa', 'Completed'),
(1737, 6, '2026-09-03', 'JBL Flip 6 Speaker', 'Electronics', 2, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Completed'),
(1738, 57, '2026-09-03', 'HP 250 G9 Laptop', 'Computing', 2, 62999.00, 54200.00, 10.00, 'M-Pesa', 'Completed'),
(1739, 128, '2026-09-03', 'iPhone 13', 'Mobile Phones', 2, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Completed'),
(1740, 37, '2026-09-04', 'Von Electric Kettle', 'Home Appliances', 2, 3299.00, 2100.00, 15.00, 'Card', 'Completed'),
(1741, 126, '2026-09-04', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'Card', 'Completed'),
(1742, 127, '2026-09-04', 'Ramtons Microwave', 'Home Appliances', 2, 11999.00, 9400.00, 5.00, 'M-Pesa', 'Completed'),
(1743, 116, '2026-09-05', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 10.00, 'Cash', 'Completed'),
(1744, 61, '2026-09-06', 'Von Electric Kettle', 'Home Appliances', 1, 3299.00, 2100.00, 0.00, 'Card', 'Completed'),
(1745, 31, '2026-09-07', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Cancelled'),
(1746, 64, '2026-09-07', 'JBL Flip 6 Speaker', 'Electronics', 4, 16500.00, 12100.00, 15.00, 'M-Pesa', 'Pending'),
(1747, 70, '2026-09-07', 'JBL Flip 6 Speaker', 'Electronics', 3, 16500.00, 12100.00, 0.00, 'Cash', 'Completed'),
(1748, 8, '2026-09-08', 'Oraimo Earbuds', 'Accessories', 3, 2999.00, 1400.00, 0.00, 'Card', 'Completed'),
(1749, 51, '2026-09-08', 'Hisense 43in Smart TV', 'Electronics', 1, 38999.00, 35200.00, 0.00, 'M-Pesa', 'Completed'),
(1750, 89, '2026-09-08', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'M-Pesa', 'Completed'),
(1751, 55, '2026-09-09', 'Mika Blender', 'Home Appliances', 3, 5499.00, 3900.00, 15.00, 'Card', 'Completed'),
(1752, 147, '2026-09-09', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 0.00, 'Card', 'Completed'),
(1753, 149, '2026-09-09', 'Sony WH-CH520 Headphones', 'Accessories', 5, 7999.00, 5100.00, 0.00, 'Card', 'Completed'),
(1754, 5, '2026-09-10', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 10.00, 'Card', 'Completed'),
(1755, 9, '2026-09-10', 'Mika Blender', 'Home Appliances', 5, 5499.00, 3900.00, 0.00, 'Card', 'Completed'),
(1756, 12, '2026-09-10', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 20.00, 'M-Pesa', 'Completed'),
(1757, 64, '2026-09-10', 'Anker 20W Charger', 'Accessories', 1, 2499.00, 1200.00, 0.00, 'M-Pesa', 'Completed'),
(1758, 23, '2026-09-11', 'Lenovo IdeaPad 3', 'Computing', 2, 58500.00, 49900.00, 5.00, 'M-Pesa', 'Cancelled'),
(1759, 120, '2026-09-11', 'Tecno Spark 20', 'Mobile Phones', 5, 15999.00, 12400.00, 0.00, 'M-Pesa', 'Completed'),
(1760, 122, '2026-09-11', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 0.00, 'M-Pesa', 'Pending'),
(1761, 133, '2026-09-11', 'Logitech Wireless Keyboard', 'Accessories', 1, 3499.00, 1900.00, 0.00, 'Bank Transfer', 'Pending'),
(1762, 133, '2026-09-11', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 5.00, 'Card', 'Completed'),
(1763, 46, '2026-09-12', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'M-Pesa', 'Completed'),
(1764, 141, '2026-09-12', 'Infinix Hot 40', 'Mobile Phones', 2, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1765, 24, '2026-09-13', 'Mika Blender', 'Home Appliances', 3, 5499.00, 3900.00, 0.00, 'Bank Transfer', 'Cancelled'),
(1766, 123, '2026-09-13', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 5.00, 'Card', 'Completed'),
(1767, 21, '2026-09-14', 'iPhone 13', 'Mobile Phones', 1, 89999.00, 78500.00, 15.00, 'Cash', 'Completed'),
(1768, 23, '2026-09-14', 'Mika Blender', 'Home Appliances', 8, 5499.00, 3900.00, 0.00, 'Bank Transfer', 'Completed'),
(1769, 46, '2026-09-14', 'Lenovo IdeaPad 3', 'Computing', 3, 58500.00, 49900.00, 5.00, 'Cash', 'Completed'),
(1770, 14, '2026-09-15', 'Mika Blender', 'Home Appliances', 1, 5499.00, 3900.00, 20.00, 'M-Pesa', 'Cancelled'),
(1771, 57, '2026-09-15', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 10.00, 'M-Pesa', 'Completed'),
(1772, 69, '2026-09-15', 'Logitech Wireless Keyboard', 'Accessories', 2, 3499.00, 1900.00, 15.00, 'M-Pesa', 'Completed'),
(1773, 143, '2026-09-15', 'Sony Soundbar', 'Electronics', 1, 32500.00, 26400.00, 0.00, 'Card', 'Pending'),
(1774, 149, '2026-09-16', 'Mika Blender', 'Home Appliances', 2, 5499.00, 3900.00, 15.00, 'Bank Transfer', 'Completed'),
(1775, 8, '2026-09-18', 'Lenovo IdeaPad 3', 'Computing', 1, 58500.00, 49900.00, 0.00, 'Bank Transfer', 'Completed'),
(1776, 103, '2026-09-18', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 10.00, 'Card', 'Completed'),
(1777, 138, '2026-09-18', 'Logitech Wireless Mouse', 'Accessories', 1, 1899.00, 950.00, 0.00, 'M-Pesa', 'Completed'),
(1778, 149, '2026-09-18', 'Anker 20W Charger', 'Accessories', 2, 2499.00, 1200.00, 5.00, 'Card', 'Completed'),
(1779, 98, '2026-09-19', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'Cash', 'Completed'),
(1780, 134, '2026-09-19', 'Infinix Hot 40', 'Mobile Phones', 1, 17499.00, 13900.00, 0.00, 'M-Pesa', 'Completed'),
(1781, 145, '2026-09-19', 'Ramtons Microwave', 'Home Appliances', 6, 11999.00, 9400.00, 15.00, 'M-Pesa', 'Pending'),
(1782, 3, '2026-09-20', 'Anker 20W Charger', 'Accessories', 6, 2499.00, 1200.00, 0.00, 'Card', 'Completed'),
(1783, 36, '2026-09-20', 'Sony WH-CH520 Headphones', 'Accessories', 4, 7999.00, 5100.00, 0.00, 'M-Pesa', 'Pending'),
(1784, 127, '2026-09-20', 'iPhone 13', 'Mobile Phones', 2, 89999.00, 78500.00, 10.00, 'M-Pesa', 'Completed'),
(1785, 149, '2026-09-21', 'Ramtons Microwave', 'Home Appliances', 3, 11999.00, 9400.00, 0.00, 'Cash', 'Completed'),
(1786, 83, '2026-09-22', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 10.00, 'M-Pesa', 'Completed'),
(1787, 91, '2026-09-23', 'Logitech Wireless Keyboard', 'Accessories', 2, 3499.00, 1900.00, 0.00, 'Card', 'Completed'),
(1788, 29, '2026-09-24', 'Lenovo IdeaPad 3', 'Computing', 2, 58500.00, 49900.00, 0.00, 'M-Pesa', 'Completed'),
(1789, 69, '2026-09-24', 'Tecno Spark 20', 'Mobile Phones', 4, 15999.00, 12400.00, 20.00, 'M-Pesa', 'Completed'),
(1790, 97, '2026-09-24', 'JBL Flip 6 Speaker', 'Electronics', 2, 16500.00, 12100.00, 0.00, 'M-Pesa', 'Completed'),
(1791, 105, '2026-09-25', 'Dell 24in Monitor', 'Computing', 1, 21999.00, 16800.00, 0.00, 'Cash', 'Cancelled'),
(1792, 3, '2026-09-27', 'Sony Soundbar', 'Electronics', 2, 32500.00, 26400.00, 0.00, 'M-Pesa', 'Completed'),
(1793, 51, '2026-09-27', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 20.00, 'Card', 'Completed'),
(1794, 64, '2026-09-27', 'Tecno Spark 20', 'Mobile Phones', 4, 15999.00, 12400.00, 10.00, 'Bank Transfer', 'Pending'),
(1795, 69, '2026-09-27', 'HP 250 G9 Laptop', 'Computing', 1, 62999.00, 54200.00, 0.00, 'Cash', 'Completed'),
(1796, 23, '2026-09-28', 'Hotpoint Refrigerator', 'Home Appliances', 1, 54999.00, 49800.00, 0.00, 'Bank Transfer', 'Completed'),
(1797, 150, '2026-09-28', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 0.00, 'M-Pesa', 'Pending'),
(1798, 115, '2026-09-29', 'Samsung Galaxy A15', 'Mobile Phones', 1, 21500.00, 17800.00, 10.00, 'Bank Transfer', 'Completed'),
(1799, 8, '2026-09-30', 'Oraimo Earbuds', 'Accessories', 1, 2999.00, 1400.00, 10.00, 'Cash', 'Completed'),
(1800, 81, '2026-09-30', 'Von Electric Kettle', 'Home Appliances', 6, 3299.00, 2100.00, 5.00, 'Bank Transfer', 'Completed')
ON CONFLICT (order_id) DO NOTHING;

SELECT 'customers'                         AS check_name, COUNT(*)::text AS result, '150' AS expected FROM customers
UNION ALL SELECT 'orders',                   COUNT(*)::text, '800' FROM orders
UNION ALL SELECT 'orders with no customer',  COUNT(*)::text, '0'   FROM orders o LEFT JOIN customers c USING (customer_id) WHERE c.customer_id IS NULL
UNION ALL SELECT 'first order date',         MIN(order_date)::text, '2025-01-..' FROM orders
UNION ALL SELECT 'last order date',          MAX(order_date)::text, '2026-09-..' FROM orders
UNION ALL SELECT 'customers with no orders', COUNT(*)::text, 'more than 0' FROM customers c WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id)
UNION ALL SELECT 'customers with 2+ orders', COUNT(*)::text, 'more than 0' FROM (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(*) >= 2) t
UNION ALL SELECT 'customers with 6+ orders', COUNT(*)::text, 'more than 0' FROM (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(*) > 5) t
UNION ALL SELECT 'categories',               COUNT(DISTINCT product_category)::text, '5' FROM orders
UNION ALL SELECT 'statuses',                 string_agg(DISTINCT order_status, ', '), 'Cancelled, Completed, Pending' FROM orders
UNION ALL SELECT 'orders before registration', COUNT(*)::text, '0' FROM orders o JOIN customers c USING (customer_id) WHERE o.order_date < c.registration_date;

-- Completed-order revenue, cost and profit (see "Business rules" in README.md).
SELECT
    ROUND(SUM(quantity * unit_price * (1 - discount / 100)), 2) AS completed_revenue,
    ROUND(SUM(quantity * cost_price), 2)                         AS completed_cost,
    ROUND(SUM(quantity * unit_price * (1 - discount / 100)) - SUM(quantity * cost_price), 2) AS completed_profit
FROM orders
WHERE order_status = 'Completed';

select * from customers;
select * from orders;

set search_path to retail_analytics;

SELECT * FROM customers LIMIT 5;
SELECT * FROM orders LIMIT 5;
/*Business rules — read these first

Most mistakes in this project come from skipping this section.

| Measure | Formula |
|---|---|
| **Revenue** | `quantity * unit_price * (1 - discount / 100)` |
| **Cost** | `quantity * cost_price` |
| **Profit** | `revenue - cost` |
| **Profit margin %** | `profit / revenue * 100` — use `NULLIF(revenue, 0)` so you never divide by zero |

1. **Money questions use Completed orders only.** Revenue, cost, profit, spending and averages count
   only `order_status = 'Completed'`, unless a question says otherwise. Pending orders are not paid
   yet; cancelled ones never will be.
2. **Order counts include every order**, whatever its status ("how many orders" means all of them).
3. **Customer counts count distinct customers.**
4. **"Today" is the latest `order_date` in the data**, not your computer's date — so everyone gets the
   same answer. Get it with `SELECT MAX(order_date) FROM orders`.
5. **Months** mean year *and* month — January 2025 and January 2026 are different months. Use
   `DATE_TRUNC('month', order_date)`.
6. Round money to 2 decimal places with `ROUND(…, 2)`.
*/

-- SECTION A — SQL FUNDAMENTALS (Q1–Q10)

-- Q1: Retrieve all customer records

select * from customers;

-- Q2: Display customer names, cities, and segments

select customer_name, city, customer_segment
from customers;

-- Q3: Find customers living in Nairobi.
select * from customers
where city = 'Nairobi';

-- Q4: Find customers registered after January 1, 2025.
select * from customers
where registration_date > '2025-01-01'
ORDER BY registration_date;

-- Q5: Display all unique customer cities.
select distinct(city) from customers;

--Q6: Retrieve the 10 most recent orders.
select * from orders o 
order by o.order_date desc 
limiFind customers whose names start with A.t 10;

--Q7: Find orders with unit prices above KSh 10,000.
select * from orders o 
where o.unit_price > 10000;

-- Q8: Find customers whose names start with A.
select * from customers c ;

select customer_id, customer_name
from customers c 
where LEFT(c.customer_name, 1) = 'A';

-- Q9: Retrieve orders with quantities between 2 and 5.
select * from orders o ;
select * from orders o 
where o.quantity between 2 and 5;

-- Q10: Find orders paid through M-Pesa.
select * from orders o 
where o.payment_method = 'M-Pesa';

--SECTION B — AGGREGATION AND GROUPING (Q11–Q20)
/*sql
SELECT group_column, SUM(...) AS total
FROM table WHERE row_condition
GROUP BY group_column
HAVING SUM(...) > 1000;      -- HAVING filters groups; WHERE filters rows
*/
-- Q11 - Count all customers.
select * from customers c ;

select count(*) as total_customers
from customers c ;

-- Q12 - Count all orders.
select count(*) as total_orders
from orders o ;

-- Q13 - Calculate completed-order revenue.

select ROUND(SUM(quantity * unit_price * (1 - discount / 100.0)), 2) AS total_completed_revenue
from  orders
where order_status = 'Completed';

--Q14: Calculate the average completed-order value.
select ROUND(AVG(quantity * unit_price * (1 - discount / 100.0)), 2) AS avg_completed_order_value
from orders
where order_status = 'Completed';

-- Q15: Find the highest and lowest product prices.
select min (unit_price) AS lowest_price, max (unit_price) AS highest_price
from orders;

-- Q16: Calculate revenue by product category.
select product_category, ROUND(SUM(quantity * unit_price * (1 - discount / 100.0)), 2) AS category_revenue
from orders
where order_status = 'Completed'
group by product_category
order by category_revenue DESC;

--Q17: Count customers by city.
select * from customers c ;

select city, count(*) as customer_count_per_city
from customers c 
group by c.city ;

--Q18: Calculate quantity sold by product.
select * from orders o ;
select product_name, sum (quantity) as total_quantity_sold
from orders o 
group by o.product_name ;

--Q19: Find categories generating more than KSh 100,000 in revenue.
select product_category, ROUND(SUM(quantity * unit_price * (1 - discount / 100.0)), 2) AS category_revenue
from orders
where order_status = 'Completed'
group by product_category
having SUM(quantity * unit_price * (1 - discount / 100.0)) > 100000;

-- Q20: Calculate the percentage of cancelled orders.

select count (*) filter (where order_status = 'Cancelled') as cancelled_orders,
    count(*) AS total_orders,
    ROUND (100.0 * COUNT(*) FILTER (WHERE order_status = 'Cancelled') / COUNT(*), 
        2
    ) AS order_cancellation_percentage
from orders;

-- Section C — Joins and customer analytics (Q21–Q28)
/*Concepts:* `INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`

-- sql
SELECT c.customer_name, o.order_id
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id;      -- only customers WITH orders

-- LEFT JOIN keeps every customer; those without orders get NULLs on the orders side
*/

--Q21: Display orders with customer names and cities.
select * from orders o ;
select * from customers c ;

select o.order_id, c.customer_name, c.city 
from orders o 
left join customers c 
on o.customer_id = c.customer_id ;

--Q22: Calculate total spending by customer
select c.customer_name, ROUND(SUM(o.quantity * o.unit_price * (1 - o.discount / 100.0)), 2) AS total_spending
from customers c
join orders o on c.customer_id = o.customer_id
where o.order_status = 'Completed'
group by c.customer_id, c.customer_name;

--Q23: Identify customers who have never ordered.
select c.customer_id, c.customer_name, c.city
from customers c
left join orders o on c.customer_id = o.customer_id
where o.customer_id is null ;

-- Q24: Find the 10 highest-spending customers.
select c.customer_id, c.customer_name, c.city, ROUND(SUM(o.quantity * o.unit_price * (1 - o.discount / 100.0)), 2) AS total_spent
from customers c
join orders o on c.customer_id = o.customer_id
where o.order_status = 'Completed'
group by c.customer_id, c.customer_name, c.city
order by total_spent DESC
limit 10;

--Q25: Calculate revenue by customer city.
select c.city, ROUND(SUM(o.quantity * o.unit_price * (1 - o.discount / 100.0)), 2) AS customer_city_revenue
from customers c
join orders o on c.customer_id = o.customer_id
where o.order_status = 'Completed'
group by c.city;

show search_path;
set search_path to retail_analytics;

--Q26: Identify customers with more than five orders.
select * from customers c ;
select * from orders o ;

select c.customer_name, c.city, COUNT(o.order_id) AS total_orders
from customers c
join orders o ON c.customer_id = o.customer_id
group by c.customer_id, c.customer_name, c.city
having COUNT(o.order_id) > 5;

-- Q27: Calculate average customer spending by segment
select * from customers c ;
select * from orders o ;

with customer_totals as (
    select c.customer_id, c.customer_segment, SUM(o.quantity * o.unit_price * (1 - o.discount / 100.0)) AS total_spent
    from customers c
    join orders o 
    on c.customer_id = o.customer_id
    where o.order_status = 'Completed'
    group by c.customer_id, c.customer_segment
)
select customer_segment, COUNT(customer_id) AS total_customers, ROUND(AVG(total_spent), 2) AS avg_customer_spending
from customer_totals
group by customer_segment;

/* CTE (customer_totals) was used to join customers and orders tables for completed purchases, and calculate the total_spent for every individual customer.

Main SELECT was used to:

COUNT(customer_id) - Track how many customers belong to each segment, as total_customers

AVG(total_spent) - Computes the average spending per customer within that segment, as avg_customer_spending

Groups those individual customer totals by segment.
*/


--28: Identify the most popular category among VIP customers.

select o.product_category, count(distinct o.order_id) AS total_orders, -- COUNT(DISTINCT o.order_id): Measures popularity by Order Frequency - Number of orders made by VIPs
sum(o.quantity) AS total_units_sold, -- SUM(o.quantity): Measures popularity by Units Sold - the total number of items VIPs bought from this category.
round(sum(o.quantity * o.unit_price * (1 - o.discount / 100.0)), 2) as category_revenue
from customers c
join orders o on c.customer_id = o.customer_id
where c.customer_segment = 'VIP' and o.order_status = 'Completed' -- WHERE c.segment = 'VIP': Filters specifically for customers in the VIP segment.
group by o.product_category
order by total_orders DESC, total_units_sold DESC;-- Ranks the categories first by total_orders, then total_units_sold as a tiebreaker.

/*Section D — Subqueries and CTEs (Q29–Q34)

*Concepts:* subqueries, `WITH` (CTEs), nested aggregation

```sql
WITH step_one AS (
    SELECT customer_id, SUM(...) AS total FROM orders GROUP BY customer_id
)
SELECT * FROM step_one WHERE total > (SELECT AVG(total) FROM step_one);
```
*/
--29: Find customers spending above the average total spending per purchasing customer.

with customer_spending as (
    select c.customer_id, c.customer_name,
        sum (o.quantity * o.unit_price * (1 - o.discount / 100.0)) as total_spent
    from customers c
    join orders o 
    on c.customer_id = o.customer_id
    where o.order_status = 'Completed'
    group by c.customer_id, c.customer_name
)
select customer_id, customer_name,
    round (total_spent, 2) AS total_spent,
    round ((SELECT avg(total_spent) from customer_spending), 2) as overall_avg_spending
from customer_spending
where total_spent > (select avg(total_spent) from customer_spending);


--30: Find products priced above the overall average unit price.

select * from orders o ;

select distinct product_name, unit_price
from orders
where unit_price > (
    select avg(unit_price) 
    from orders
);

--31: Use a CTE to identify the three highest-revenue months.

with monthly_revenue as (
    select extract (YEAR FROM order_date) AS order_year,
        extract (MONTH FROM order_date) AS order_month_number,
        sum (quantity * unit_price * (1 - discount / 100.0)) as total_revenue
    from orders
    where order_status = 'Completed'
    group by extract (YEAR FROM order_date), extract (MONTH FROM order_date)
)
select order_year, order_month_number as month,
    round (total_revenue, 2) as revenue
from monthly_revenue
order by revenue DESC
limit 3;

--32: Find customers purchasing from at least three categories.

select c.customer_id, c.customer_name,
    count (distinct o.product_category) as categories_purchased
from customers c
join orders o 
on c.customer_id = o.customer_id
where o.order_status = 'Completed'
group by c.customer_id, c.customer_name
having count (distinct o.product_category) >= 3;

--33: Use a CTE to calculate category revenue, cost, profit, and profit margin.
select * from orders o ;

with category_metrics as (
    select product_category,
        sum (quantity * unit_price * (1 - discount / 100.0)) as total_revenue,
        sum (quantity * cost_price) as total_cost
    from orders
    where order_status = 'Completed'
    group by product_category
)
select product_category,
    round (total_revenue, 2) as revenue,
    round (total_cost, 2) as cost,
    round (total_revenue - total_cost, 2) as profit,
    round (100.0 * (total_revenue - total_cost)/total_revenue, 2) as profit_margin_percent
from category_metrics;


--34: Find customers whose latest completed order is more than 90 days before the latest order date in the dataset.

select c.customer_id, c.customer_name, c.city,
    max (o.order_date) AS latest_completed_date
from customers c
join orders o 	
on c.customer_id = o.customer_id
where o.order_status = 'Completed'
group by c.customer_id, c.customer_name, c.city
having (select max (order_date) from orders) - max (o.order_date) > 90;

/*### Section E — Window functions (Q35–Q42)
 * *Concepts:* `OVER`, `PARTITION BY`, `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `NTILE`

```sql
SELECT customer_id, order_date,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS n
FROM orders;
-- RANK leaves gaps after ties (1,1,3); DENSE_RANK does not (1,1,2)
-- running total:  SUM(x) OVER (ORDER BY month)
-- previous row:   LAG(x) OVER (ORDER BY month)
```*/

--35: Rank customers by spending using `RANK()`.

WITH customer_spending AS (
    -- Step 1: Calculate total spending for each customer
    select c.customer_id, c.customer_name,
        sum (o.quantity * o.unit_price * (1 - o.discount / 100.0)) as total_spent
    from customers c
    join orders o 
    on c.customer_id = o.customer_id
    where o.order_status = 'Completed'
    group by c.customer_id, c.customer_name, c.city
)
select rank () over (order by total_spent desc) as spending_rank,
    customer_id, customer_name,
    ROUND(total_spent, 2) AS total_spent
from customer_spending
order by spending_rank ASC;

--36: Number each customer's orders by recency using `ROW_NUMBER()`.

select c.customer_id, c.customer_name, o.order_id, o.order_date,
    row_number () over (partition by c.customer_id 
        order by o.order_date desc) as order_recency_number
from customers c
join orders o 
on c.customer_id = o.customer_id
where o.order_status = 'Completed'
order by c.customer_id, order_recency_number asc ;

show search_path;

set search_path to retail_analytics;

-- 37: Rank products within categories using `DENSE_RANK()`
select * from customers c ;
select * from orders o ;

with product_performance as (
    select product_category, product_name,
        SUM(quantity * unit_price * (1 - discount / 100.0)) AS total_revenue -- total revenue for each product within its category
    from orders
    where order_status = 'Completed'
    group by product_category, product_name
)
select product_category, product_name,
    round (total_revenue, 2) as total_revenue,
    DENSE_RANK() OVER (PARTITION BY product_category 
        ORDER BY total_revenue DESC
    ) as category_rank
from product_performance
ORDER BY product_category ASC, category_rank ASC;

--38: Calculate cumulative monthly revenue

with monthly_sales as (
      select EXTRACT(YEAR FROM order_date) AS order_year,-- Extract year
        EXTRACT(MONTH FROM order_date) AS order_month, -- Extract month
        SUM(quantity * unit_price * (1 - discount / 100.0)) AS revenue -- calculate revenue
    from orders
    where order_status = 'Completed'
    group by extract(year from order_date), extract(month from order_date)
)
select order_year, order_month,
   ROUND(revenue, 2) AS monthly_revenue,
   ROUND(SUM(revenue) OVER (ORDER BY order_year, order_month), 2) AS cumulative_revenue --  -- Accumulate running total revenue across months and years
from monthly_sales
order by order_year ASC, order_month ASC;

-- 39: Compare monthly revenue using `LAG()`.
WITH monthly_sales AS (
    select EXTRACT(YEAR FROM order_date) AS order_year,-- Extract year
        EXTRACT(MONTH FROM order_date) AS order_month, -- Extract month
        SUM(quantity * unit_price * (1 - discount / 100.0)) AS revenue -- calculate revenue
    from orders
    where order_status = 'Completed'
    group by extract(year from order_date), extract(month from order_date)
)
select order_year, order_month,
    ROUND(revenue, 2) AS current_revenue,-- capture the previous month's revenue chronologically
    ROUND(LAG(revenue, 1) OVER (ORDER BY order_year, order_month), 2) AS previous_revenue,-- Calculate the month-over-month difference
    ROUND(revenue - LAG(revenue, 1) OVER (ORDER BY order_year, order_month), 2) AS revenue_difference
FROM monthly_sales
ORDER BY order_year ASC, order_month ASC;

--40: Calculate month-over-month revenue growth (%).
show search_path;
set search_path to retail_analytics;

WITH monthly_sales AS (
    select EXTRACT(YEAR FROM order_date) AS order_year,-- Extract year
        EXTRACT(MONTH FROM order_date) AS order_month, -- Extract month
        SUM(quantity * unit_price * (1 - discount / 100.0)) AS revenue -- calculate revenue
    from orders
    where order_status = 'Completed'
    group by extract(year from order_date), extract(month from order_date)
)
select order_year, order_month,
    ROUND(revenue, 2) AS current_revenue,
    ROUND(LAG(revenue, 1) OVER (ORDER BY order_year, order_month), 2) AS previous_revenue,
   	ROUND(
    100.0 * (revenue - LAG(revenue, 1) OVER (ORDER BY order_year, order_month)) 
    / LAG(revenue, 1) OVER (ORDER BY order_year, order_month), 
    2) AS month_over_month_growth_percentage
FROM monthly_sales
ORDER BY order_year ASC, order_month ASC;

-- 41: Divide customers into four spending groups using `NTILE(4)`.
with customer_spending as (
    select c.customer_id, c.customer_name,
        sum (o.quantity * o.unit_price * (1 - o.discount / 100.0)) AS total_spent -- total spending for each customer
    from customers c
    join orders o 
    on c.customer_id = o.customer_id
    where o.order_status = 'Completed'
    group by c.customer_id, c.customer_name
)
select customer_id, customer_name,
    ROUND(total_spent, 2) AS total_spent,
    NTILE(4) OVER (ORDER BY total_spent DESC) AS spending_quartile --Divide customers into 4 equal buckets
from customer_spending
order by  spending_quartile ASC, total_spent DESC;

--42: Calculate each category's share of total revenue using window functions.
with category_sales as (
    select product_category,
        SUM(quantity * unit_price * (1 - discount / 100.0)) AS category_revenue
    from orders
    where order_status = 'Completed'
    group by product_category -- Calculate total revenue for each product category
)
select product_category,
    ROUND(category_revenue, 2) AS category_revenue,
    ROUND(100.0 * category_revenue / SUM(category_revenue) over (), 2) AS revenue_share_percentage -- Calculate percentage share using the grand total window function
from category_sales
order by category_revenue desc;

/* Section F — Advanced business intelligence (Q43–Q46)
CREATE OR REPLACE VIEW my_view AS SELECT ...;

CREATE OR REPLACE FUNCTION my_function(p_id INTEGER)
RETURNS NUMERIC LANGUAGE plpgsql AS $$
DECLARE v_result NUMERIC;
BEGIN
    SELECT ... INTO v_result FROM ... WHERE id = p_id;
    RETURN v_result;
END;
$$;
*/

--43: Create a `monthly_sales_summary` view (month, orders, revenue, cost, profit). Then `SELECT` from it.
select * from orders o ;

create or replace view monthly_sales_summary as
select 
    DATE_TRUNC('month', order_date)::date AS order_month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity * unit_price * (1 - discount / 100.0)) AS revenue,
    SUM(quantity * cost_price) AS total_cost,
    SUM((quantity * unit_price * (1 - discount / 100.0)) - (quantity * cost_price)) AS profit
from orders
where order_status = 'Completed'
group by DATE_TRUNC('month', order_date);

select order_month, total_orders,
    ROUND(revenue, 2) AS revenue,
    ROUND(total_cost, 2) AS cost,
    ROUND(profit, 2) AS profit
from monthly_sales_summary
order by order_month desc ;

--44: Create a PostgreSQL function that returns completed-order revenue for a supplied customer ID. Show it working for one customer **and** for an ID that does not exist (it should return 0, not NULL).

create or replace function get_customer_revenue(p_customer_id INTEGER)
returns NUMERIC LANGUAGE sql AS $$
    select COALESCE(SUM(quantity * unit_price * (1 - discount / 100.0)), 0)
    from orders 
    where customer_id = p_customer_id and order_status = 'Completed';
$$;

SELECT get_customer_revenue(105) AS total_revenue; -- Summed revenue for a valid customer, who has completed orders

SELECT get_customer_revenue(10101) AS total_revenue; -- Summed revenue for an ID that does not exist (or has zero completed orders)

--45: Segment customers into High, Medium and Low Value. **Explain why you chose your thresholds** — for example percentiles, or round KSh amounts based on what the data looks like.
WITH customer_spending AS (
    SELECT 
        c.customer_id, c.customer_name,
        SUM(o.quantity * o.unit_price * (1 - o.discount / 100.0)) AS total_spent
    FROM customers c
    JOIN orders o 
    ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
)
SELECT 
    customer_id, customer_name,
    ROUND(total_spent, 2) AS total_spent,
    -- Assign value segments based on defined thresholds
    CASE 
        WHEN total_spent >= 100000 THEN 'High Value'
        WHEN total_spent >= 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_spending
ORDER BY total_spent DESC;

--46:Produce a management report: the top five customers, top five products, the most profitable category, and the lowest-revenue month.

-- ==========================================
-- MANAGEMENT REPORT - RETAIL SALES
-- ==========================================

-- 1. Top 5 Customers by Revenue
WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        SUM(o.quantity * o.unit_price * (1 - o.discount / 100.0)) AS total_revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
)
SELECT 
    customer_id,
    customer_name,
    ROUND(total_revenue, 2) AS total_revenue
FROM customer_revenue
ORDER BY total_revenue DESC
LIMIT 5;


-- 2. Top 5 Products by Revenue

WITH product_revenue AS (
    SELECT 
        product_name,
        SUM(quantity * unit_price * (1 - discount / 100.0)) AS total_revenue
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY product_name
)
SELECT 
    product_name,
    ROUND(total_revenue, 2) AS total_revenue
FROM product_revenue
ORDER BY total_revenue DESC
LIMIT 5;


-- 3. Most Profitable Category

WITH category_profit AS (
    SELECT 
        product_category,
        SUM((quantity * unit_price * (1 - discount / 100.0)) - (quantity * cost_price)) AS total_profit
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY product_category
)
SELECT 
    product_category,
    ROUND(total_profit, 2) AS total_profit
FROM category_profit
ORDER BY total_profit DESC
LIMIT 1;


-- 4. Lowest-Revenue Month

WITH monthly_revenue AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS order_year,
        EXTRACT(MONTH FROM order_date) AS order_month,
        SUM(quantity * unit_price * (1 - discount / 100.0)) AS revenue
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
)
SELECT 
    order_year, order_month,
    ROUND(revenue, 2) AS revenue
FROM monthly_revenue
ORDER BY revenue ASC
LIMIT 1;