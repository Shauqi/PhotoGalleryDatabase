drop table image;
drop table gallery;
drop table user1;
drop table myaudit;


create table user1
	(
		user_id number(10) not null,
		name varchar(20),
		password number(12),
		about varchar(30),
		user_image BLOB,
		role number(2)
		);


create table image
	(
		image_id number(10) not null,
		gallery_id number(10) not null,
		filename varchar(15),
		img BLOB,
		user_id number(10) not null,
		description varchar(30),
		rank number(10) unique,
		upload_date date
		);

create table gallery
	(
		gallery_id number(10) not null,
		gallery_name varchar(20)
		);


alter table user1 add constraint user1PKey
primary key(user_id);

alter table image add constraint imagePKey
primary key(image_id);

alter table gallery add constraint galleryPKey
primary key(gallery_id);

alter table image add constraint imageFKey1
foreign key(user_id) references user1(user_id) on delete cascade;

alter table image add constraint imageFKey2
foreign key(gallery_id) references gallery(gallery_id) on delete cascade;

insert into user1 values(1,'Al-Mamun Akash','5555','Coder,Contest Programmer',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\1akash_prof.jpg'),0);
insert into user1 values(6,'Tanmoy Datta','5689','Coding Guru',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\6Datta_prof.jpg'),0);
insert into user1 values(22,'Rafi Heisenberg','6689','great',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\22Rafi_prof.jpg'),0);
insert into user1 values(60,'Tanmoy Datta','5689','Coding Guru',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\60Ghosh_prof.jpg'),1);


insert into gallery values(1,'Carmichael');
insert into gallery values(2,'Thridline');
insert into gallery values(3,'FecalFace');

insert into image values(1,3,'Akash image 1',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\1akashimg1.jpg'),1,'Akash got pic1',3,'19-JUNE-2016');
insert into image values(2,1,'Akash image 2',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\1akashimg2.jpg'),1,'Akash got pic2',1,'19-JUNE-2016');
insert into image values(3,3,'Akash image 1',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\1akashimg3.jpg'),1,'Akash got pic3',2,'19-JUNE-2016');
insert into image values(4,3,'Datta image 1',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\6Dattaimg1.jpg'),6,'Datta got pic1',5,'21-JUNE-2016');
insert into image values(5,2,'Rafi image 1',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\22Rafiimg1.jpg'),22,'Rafi got pic1',4,'23-JUNE-2016');
insert into image values(6,1,'Ghosh image 1',utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\22Rafiimg1.jpg'),60,'Ghosh got pic1',6,'23-JUNE-2016');


-- for login
set serveroutput on;
declare
u_id user1.user_id%type:=1;
u_name user1.name%type:='Al-Mamun Akash';
u_pass user1.password%type:=5555;
passw user1.password%type;
begin
select password into passw from user1 where user_id=u_id and name=u_name;
if u_pass=passw then
                dbms_output.put_line('Access Accepted');
else
    dbms_output.put_line('Access Denied');
end if;
end;
/


-- Showing images under one gallery
set serveroutput on;
declare
cursor image_cur is select filename,upload_date from image where gallery_id in(select gallery_id from gallery where gallery_name='Carmichael');
img_pointer image_cur%rowtype;
begin
open image_cur;
loop
fetch image_cur into img_pointer;
dbms_output.put_line('The Carmichael contains '||img_pointer.filename||' uploaded in '||img_pointer.upload_date);
exit when image_cur%rowcount>1;
end loop;
close image_cur;
end;
/

-- Showing images by ranking
set serveroutput on;
declare
cursor image_cur is select image_id,description,filename,upload_date,rank from image order by rank;
img_pointer image_cur%rowtype;
begin
open image_cur;
loop
fetch image_cur into img_pointer;
dbms_output.put_line('Rank: '||img_pointer.rank||' img no:'||img_pointer.image_id||' description:'||img_pointer.description||' filename'||img_pointer.filename||' upload_date:'||img_pointer.upload_date);
exit when image_cur%rowcount>5;
end loop;
close image_cur;
end;
/

-- Showing images by particular user
set serveroutput on;
declare
cursor image_cur is select image_id,description,filename,upload_date,rank from image where image.user_id=1;
img_pointer image_cur%rowtype;
u_id user1.user_id%type:=1;
u_name user1.name%type;
begin
select name into u_name from user1 where user_id=u_id;
open image_cur;
loop
fetch image_cur into img_pointer;
dbms_output.put_line( u_name||' got img no:'||img_pointer.image_id||' description:'||img_pointer.description||' filename'||img_pointer.filename||' upload_date:'||img_pointer.upload_date);
exit when image_cur%rowcount>2;
end loop;
close image_cur;
end;
/


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


--Procedure For updating user_image
create or replace procedure update_user_image(
	u_name user1.name%type,
	u_pass user1.password%type,
	img user1.user_image%type,
	rol user1.role%type) IS
begin
  if rol=0 then
    Update user1 set user_image=img where name=u_name and password=u_pass;
  else
    dbms_output.put_line('The user is not admin or user not found in database');
  end if;
end;
/    
show errors


set serveroutput on;
begin
  update_user_image('Al-Mamun Akash',5555,utl_raw.cast_to_raw('E:\Semester 3-1\Database\PhotoGalleryDatabase\code\6Datta_prof.jpg'),0);
end;
/