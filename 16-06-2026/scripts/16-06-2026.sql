
-- select * from pg_stat_activity;
create table province (
    id int,
    name text,
    name_eng text
);
create table ward(
    id int,
    province_id int,
    name text,
    name_eng text

);
insert into province (id,name,name_eng) values 
(1,'Thai Binh', 'Thai Binh'),
(2,'Nam Dinh', 'Nam Dinh'),
(3,'Quang Ninh','Quang Ninh');

insert into ward (id,province_id,name,name_eng) values 
(1,1,'Tien Hai', 'Tien Hai'),
(2,1,'Kien Xuong', 'Kien Xuong'),
(3,2,'Hai Hau', 'Hai Hau'),
(4,2,'Xuan Thuy', 'Xuan Thuy'),
(5,3,'Bai Chay','Bai Chay'),
(6,3,'Hai Ha', 'Hai Ha');

update province set name = 'Ha Nam', name_eng = 'Ha Nam' where id =1;
update ward set name = 'Ha Nam', name_eng = 'Ha Nam' where id =2;
delete from province where id=2;
delete from ward where id =6;
