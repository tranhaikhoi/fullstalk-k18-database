CREATE TABLE categories (
    cat_id   INT PRIMARY KEY,
    cat_name VARCHAR(100)
);

CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(100),
    cat_id       INT,
    price        DECIMAL(12,0),
    FOREIGN KEY (cat_id) REFERENCES categories(cat_id)
);

CREATE TABLE employees (
    emp_id     INT PRIMARY KEY,
    emp_name   VARCHAR(100),
    department VARCHAR(50)
);

CREATE TABLE sales (
    sale_id    INT PRIMARY KEY,
    product_id INT,
    emp_id     INT,
    quantity   INT,
    sale_date  DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (emp_id)     REFERENCES employees(emp_id)
);

INSERT INTO categories VALUES
(1, 'Dien thoai'),
(2, 'Laptop'),
(3, 'Phu kien'),
(4, 'May tinh bang');

INSERT INTO products VALUES
(1,  'iPhone 15',         1, 22000000),
(2,  'Samsung Galaxy S24',1, 18000000),
(3,  'MacBook Air M2',    2, 32000000),
(4,  'Dell XPS 13',       2, 28000000),
(5,  'AirPods Pro',       3,  6000000),
(6,  'Cap sac nhanh',     3,   500000),
(7,  'iPad Pro',          4, 25000000),
(8,  'Samsung Tab S9',    4, 18000000),
(9,  'Xiaomi 14',         1, 12000000),
(10, 'Asus VivoBook',     2, 15000000);

INSERT INTO employees VALUES
(1, 'Nguyen Van An',   'Sales'),
(2, 'Tran Thi Bich',  'Sales'),
(3, 'Le Van Cuong',   'Sales'),
(4, 'Pham Thi Dung',  'Marketing'),
(5, 'Hoang Van Em',   'Sales'),
(6, 'Vu Thi Phuong',  'Marketing');

INSERT INTO sales VALUES
(1,  1,  1, 5,  '2024-01-10'),
(2,  1,  2, 3,  '2024-01-15'),
(3,  2,  1, 4,  '2024-02-05'),
(4,  2,  3, 6,  '2024-02-10'),
(5,  3,  2, 2,  '2024-01-20'),
(6,  3,  1, 3,  '2024-03-01'),
(7,  4,  3, 4,  '2024-02-15'),
(8,  4,  5, 2,  '2024-03-10'),
(9,  5,  1, 10, '2024-01-25'),
(10, 5,  2, 8,  '2024-02-20'),
(11, 6,  3, 20, '2024-01-30'),
(12, 6,  5, 15, '2024-02-25'),
(13, 7,  2, 3,  '2024-03-05'),
(14, 7,  1, 2,  '2024-01-12'),
(15, 8,  3, 4,  '2024-02-08'),
(16, 8,  5, 3,  '2024-03-15'),
(17, 9,  1, 6,  '2024-01-18'),
(18, 9,  2, 5,  '2024-02-22'),
(19, 10, 3, 3,  '2024-03-20'),
(20, 10, 5, 4,  '2024-01-28'),
(21, 1,  3, 2,  '2024-04-01'),
(22, 2,  5, 3,  '2024-04-05'),
(23, 5,  1, 7,  '2024-04-10'),
(24, 6,  2, 12, '2024-04-15'),
(25, 3,  5, 1,  '2024-04-20');

--Câu 3.1: Tính tổng doanh thu theo từng danh mục sản phẩm. Chỉ hiển thị danh mục có doanh thu > 50,000,000.
select categories.cat_name, sum(products.price * sales.quantity)
    from categories
    join products on categories.cat_id = products.cat_id
    join sales on products.product_id = sales.product_id
    group by categories.cat_id, categories.cat_name
    having sum(products.price * sales.quantity) > 50000000

--Câu 3.2: Thống kê nhân viên phòng 'Sales' bán được bao nhiêu loại sản phẩm và tổng số lượng. Chỉ lấy nhân viên bán từ 3 loại sản phẩm trở lên.
select employees.emp_name, count(distinct sales.product_id) as product_count, sum(sales.quantity) as total_quantity
    from employees
    join sales on sales.emp_id = employees.emp_id
    where employees.department ='Sales'
    group by employees.emp_id, employees.emp_name
    having count(distinct sales.product_id) >= 3

--Câu 3.3: Lấy top 3 sản phẩm bán chạy nhất năm 2024, kèm tên danh mục.
select products.product_name, sum(sales.quantity), categories.cat_name
    from categories
    join products on categories.cat_id = products.cat_id
    join sales on products.product_id = sales.product_id
    where sales.sale_date >= '2024-01-01' and sales.sale_date < '2025-01-01'
    group by products.product_id, products.product_name, categories.cat_name 
    order by sum(sales.quantity) desc
    limit 3
