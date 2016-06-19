drop table image;
drop table gallery;
drop table role;
drop table user1;


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
