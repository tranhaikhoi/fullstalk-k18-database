CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name        VARCHAR(100),
    city        VARCHAR(50),
    join_date   DATE
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT,
    total_amount DECIMAL(12,0),
    order_date   DATE,
    status       VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'Nguyen Van An',   'Ha Noi',    '2022-01-10'),
(2, 'Tran Thi Bich',  'HCM',       '2022-03-15'),
(3, 'Le Van Cuong',   'Da Nang',   '2022-06-20'),
(4, 'Pham Thi Dung',  'Ha Noi',    '2023-01-05'),
(5, 'Hoang Van Em',   'Can Tho',   '2023-04-18'),
(6, 'Vu Thi Phuong',  'HCM',       '2023-07-22'),
(7, 'Dang Van Giang', 'Hue',       '2023-09-30'),
(8, 'Bui Thi Hoa',    'Ha Noi',    '2024-02-14');

INSERT INTO orders VALUES
(101, 1, 750000,  '2024-01-05', 'completed'),
(102, 1, 300000,  '2024-02-10', 'completed'),
(103, 1, 450000,  '2024-03-15', 'cancelled'),
(104, 2, 1200000, '2024-01-20', 'completed'),
(105, 2, 800000,  '2024-02-25', 'completed'),
(106, 3, 200000,  '2024-01-08', 'completed'),
(107, 3, 150000,  '2024-03-01', 'pending'),
(108, 4, 600000,  '2024-02-14', 'completed'),
(109, 4, 900000,  '2024-03-20', 'completed'),
(110, 5, 1500000, '2024-01-30', 'completed'),
(111, 5, 400000,  '2024-02-05', 'cancelled'),
(112, 6, 350000,  '2024-03-10', 'completed'),
(113, 7, 550000,  '2024-01-15', 'completed'),
(114, 7, 700000,  '2024-02-28', 'completed'),
(115, 8, 100000,  '2024-03-05', 'pending');

--Cau 1.1: Lấy danh sách đơn hàng có status = 'completed' và total_amount > 500000

select * from orders where status = 'completed' and total_amount > 500000;

--Cau 1.2: Thống kê số đơn và tổng chi tiêu theo từng khách hàng.Chỉ lấy khách hàng có tổng chi tiêu > 1,000,000.
 select customers.name, count(orders.order_id),
        sum(orders.total_amount)
        from customers
        join orders on orders.customer_id = customers.customer_id
        group by customers.customer_id, customers.name
        having sum(orders.total_amount)>1000000;

--Câu 1.3: Hiển thị tên khách hàng và số đơn hàng. Lấy ra top 5.
select customers.name, count(orders.order_id)
    from customers
    join orders on orders.customer_id = customers.customer_id
    group by customers.customer_id, customers.name
    order by count(orders.order_id) desc
    limit 5;
