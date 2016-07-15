drop table image;
drop table gallery;
drop table role;
drop table user1;
drop table myaudit;


-- Creating table user where primary key is user_id
-- and role_id is foreign key

create table user1
	(
		user_id number(10) not null,
		name varchar(20),
		password number(12)
		);

--role table has role_id as primary key

create table role
	(
		role_id number(5) not null,
		user_id number(10) not null 
		);

/* gallery table has gallery_id as primary key
and role_id as foreign key*/

create table gallery
	(
		gallery_id number(10) not null,
		name varchar(10),
		user_id number(10) not null,
		role_id number(2) not null 
		);


/* image table has primary key image_id. user_id
 and gallery_id are foreign key.*/

create table image
	(
		gallery_id number(10) not null,
		user_id number(10) not null,
		image_id number(10) not null,
		filename varchar(15),
		description varchar(30),
		upload_date date
		);


-- This section creates primary keys
-- primary key section starts here

alter table user1 add constraint user1PKey
primary key(user_id);

alter table image add constraint imagePKey
primary key(image_id);

alter table gallery add constraint galleryPKey
primary key(gallery_id);

alter table role add constraint rolePKey
primary key(role_id);

-- primary key section ends here

-- This section creates foreign keys
-- foreign key section starts here

alter table role add constraint roleFKey1
foreign key(user_id) references user1(user_id) on delete cascade;

alter table gallery add constraint galleryFKey1
foreign key(role_id) references role(role_id) on delete cascade;

alter table gallery add constraint galleryFKey2
foreign key(user_id) references user1(user_id) on delete cascade;

alter table image add constraint imageFKey1
foreign key(user_id) references user1(user_id) on delete cascade;

alter table image add constraint imageFKey2
foreign key(gallery_id) references gallery(gallery_id) on delete cascade;

--foreign key section ends here

-- Some sample value inserted in this section
-- sample value insertion section starts here

insert into user1 values(1,'Akash',11111);
insert into user1 values(2,'Swad',11112);
insert into user1 values(3,'Rashik',11113);
insert into user1 values(4,'Abir',11114);
insert into user1 values(5,'Rafi',11115);
insert into user1 values(6,'Tanmoy',11116);
insert into user1 values(19,'Alvi',111119);
insert into user1 values(22,'Mazid',111122);

insert into role values(01,1);
insert into role values(02,2);
insert into role values(03,3);
insert into role values(14,4);
insert into role values(05,5);
insert into role values(16,6);
insert into role values(019,19);
insert into role values(022,22);


insert into gallery values(2221,'Carmichael',1,01);
insert into gallery values(2222,'Carmichael',2,02);
insert into gallery values(2223,'ThirdLine',3,03);
insert into gallery values(2224,'Carmichael',4,14);
insert into gallery values(2225,'FecalFace',5,05);
insert into gallery values(2226,'ThirdLine',6,16);
insert into gallery values(2227,'FecalFace',19,019);
insert into gallery values(2228,'ThirdLine',22,022);


insert into image values(2221,1,3331,'profPic','Just a profile pic','19-JUNE-2016');
insert into image values(2222,2,3332,'rand','Just a random pic','20-JUNE-2016');
insert into image values(2223,3,3333,'userPic','none','19-JUNE-2016');
insert into image values(2224,4,3334,'stubborn','Just for fun','28-JUNE-2016');
insert into image values(2225,5,3335,'clever','Just having fun','1-JUNE-2016');
insert into image values(2226,6,3336,'programmer','#Respect','17-JUNE-2016');
insert into image values(2227,19,3337,'eater','Only Like','19-JUNE-2016');
insert into image values(2228,22,3338,'dope','none','17-JUNE-2016');

-- sample value insert section ends here


-- Example of Aggregate functions applied to the project


-- Intuition of Aggregate function starts here


--using of count function on user1 table counts the number of users
select count(user_id) from user1;

select count(gallery_id) from gallery where gallery_id>=2224; -- count on gallery

--using of sum function on image table sum up the values of gallery_id
select sum(gallery_id) as gallerySum from image;

--using of avg function on role table finds the avg value of user_id

select avg(user_id) from role;

--using of min and max functions on user1 table finds the maximum and minimum values of user_id respectively

select max(user_id) from user1;
select min(user_id) from user1;

-- Intuition of Aggregate function ends here



-- SET OPERATION EXAMPLE ON PROJECT
-- Set operation section starts here

-- Example of Union all function. Basically union all unions data without eliminating duplication

select u.user_id,u.name from user1 u union all select g.user_id,g.name from gallery g where g.user_id in(select user_id from role where role_id>=14);

-- Example of Union function. Union function eliminates the duplicates

select u.user_id,u.name from user1 u union select g.user_id,g.name from gallery g where g.user_id in(select user_id from role where role_id>=14);

-- Example of Intersect funtion. it selects data which are common on both table

select u.user_id,u.name from user1 u intersect select g.user_id,g.name from gallery g where g.user_id in(select user_id from role where role_id>=14);

-- Example of Minus function. It selects data from the first table excluding common data in second table

select u.user_id,u.name from user1 u minus select g.user_id,g.name from gallery g where g.user_id in(select user_id from role where role_id>=14);


-- The following section gives intuition on join. The join section starts here.

-- The simple join. inner join and simple join are same

select u.name,r.role_id from user1 u join role r on u.user_id=r.user_id;

-- here on is used

select u.name,r.role_id from user1 u join role r using (user_id);

-- here using is used

-- The natural join also acts as join but it compares all the same column and there is no need of condition

select u.name,i.filename from user1 u natural join image i;

-- The cross join results in cartesian product of two table contents

select u.name,g.name from user1 u cross join gallery g;

-- Outer Join
-- left outer join

select g.name,i.filename from gallery g left outer join image i on g.gallery_id = i.gallery_id;

-- right outer join

select g.name,i.filename from gallery g right outer join image i on g.gallery_id = i.gallery_id;

-- full outer join

select g.name,i.filename from gallery g full outer join image i on g.gallery_id = i.gallery_id;

-- Example of plsql on project
-- One Thing to remeber use proper indentation in plsql else you may see errors
-- The plsql section starts here

-- Example of userid and name checking

set serveroutput on;
declare   
-- variable of user_id type from user1 table is declared and initialized with value
u_id1  user1.user_id%type:=1;
-- variable of name type from user1 table is declared and initialized with value
u_name user1.name%type:='Akash'; 
-- variable of user_id type from user1 table is declared and initialized with value
u_id2 user1.user_id%type;
begin
-- query of user_id where initialized u_name is equivalent to user1 tables one of the name
-- if the name is found then u_id2 will contain the corresponding user_id
select user_id into u_id2 from user1 where name=u_name;
-- checking if u_id1 and u_id2 is equal if equal
if u_id1=u_id2 then
             dbms_output.put_line('User found in database');
else
    dbms_output.put_line('User not found in database');
end if;
end;
/
show errors;


-- pl sql to show image filename of a gallery using loop
set serveroutput on
declare
-- Here a row of gallery is selected by gallery_cur which contains gallery name 'Carmichael'
cursor gallery_cur is select gallery_id from gallery where name='Carmichael';
-- To store a particular row a gallery_pointer of gallery_cur is declared
gallery_pointer gallery_cur%rowtype;
fname image.filename%type;
up_date image.upload_date%type;
begin
open gallery_cur;
-- By the loop each time a filename and upload date of an image is selected of current gallery id which is collected by gallery pointer
loop
fetch gallery_cur into gallery_pointer;
select filename,upload_date into fname,up_date from image where image.gallery_id=gallery_pointer.gallery_id;

dbms_output.put_line('The '||gallery_pointer.gallery_id||' contains '||fname||' uploaded in '||up_date);
exit when gallery_cur%rowcount>2;
end loop;
close gallery_cur;
end;
/
show errors;

-- Example of Trigger in PL/SQL used in project
-- The reference for trigger: http://www.rebellionrider.com/pl-sql-tutorials/triggers-in-oracle-database/table-auditing-using-dml-triggers-in-oracle-database.htm#.V4iqCrh97IU
-- Table Auditing using DML TRIGGER
-- Creation of audit table
create table myaudit
	(
		new_name varchar2(30),
		old_name varchar2(30),
		user_name varchar2(30),
		entry_date varchar2(30),
		operation varchar2(30)
		);

-- Trigger for user1 table
set serveroutput on
CREATE OR REPLACE TRIGGER user1audit
BEFORE INSERT OR DELETE OR UPDATE ON user1
FOR EACH ROW  

BEGIN 

  IF INSERTING THEN
  INSERT INTO myaudit (new_name,old_name, user_name, entry_date, operation) VALUES(:NEW.NAME, Null , user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'), 'Insert');
  ELSIF DELETING THEN
  INSERT INTO myaudit (new_name,old_name, user_name, entry_date, operation) VALUES(NULL,:OLD.NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') , 'Delete');
  ELSIF UPDATING THEN
  INSERT INTO myaudit (new_name,old_name, user_name, entry_date, operation) VALUES(:NEW.NAME, :OLD.NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'),'Update');
  END IF;
END;
 /


-- Trigger for gallery table
set serveroutput on
CREATE OR REPLACE TRIGGER galleryaudit
BEFORE INSERT OR DELETE OR UPDATE ON gallery
FOR EACH ROW  

BEGIN 

  IF INSERTING THEN
  INSERT INTO myaudit (new_name,old_name, user_name, entry_date, operation) VALUES(:NEW.NAME, Null , user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'), 'Insert');
  ELSIF DELETING THEN
  INSERT INTO myaudit (new_name,old_name, user_name, entry_date, operation) VALUES(NULL,:OLD.NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') , 'Delete');
  ELSIF UPDATING THEN
  INSERT INTO myaudit (new_name,old_name, user_name, entry_date, operation) VALUES(:NEW.NAME, :OLD.NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'),'Update');
  END IF;
END;
 /

 -- Trigger for image table
 set serveroutput on
CREATE OR REPLACE TRIGGER imageaudit
BEFORE INSERT OR DELETE OR UPDATE ON image
FOR EACH ROW  

BEGIN 

  IF INSERTING THEN
  INSERT INTO myaudit (new_name,old_name, user_name, entry_date, operation) VALUES(:NEW.FILENAME, Null , user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'), 'Insert');
  ELSIF DELETING THEN
  INSERT INTO myaudit (new_name,old_name, user_name, entry_date, operation) VALUES(NULL,:OLD.FILENAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') , 'Delete');
  ELSIF UPDATING THEN
  INSERT INTO myaudit (new_name,old_name, user_name, entry_date, operation) VALUES(:NEW.FILENAME, :OLD.FILENAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'),'Update');
  END IF;
END;
 /

