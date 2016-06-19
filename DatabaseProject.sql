drop table image;
drop table gallery;
drop table user1;
drop table role;

-- Creating table user where primary key is user_id
-- and role_id is foreign key

create table user1
	(
		user_id number(10) not null,
		name varchar(20),
		password number(12),
		role_id number(2) not null check(role_id>-1 and role_id<2)
		);

/* image table has primary key image_id.user_id
 and gallery_id are foreign key.*/

create table image
	(
		image_id number(10) not null,
		user_id number(10) not null,
		gallery_id number(10) not null,
		filename varchar(15),
		description varchar(30),
		upload_date date
		);

/* gallery table has gallery_id as primary key
and role_id as foreign key*/

create table gallery
	(
		gallery_id number(10) not null,
		name varchar(10),
		role_id number(2) not null check(role_id>-1 and role_id<2)
		);

--role table has role_id as primary key

create table role
	(
		role_id number(2) not null check(role_id>-1 and role_id<2),
		user_num number(20) 
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

alter table user1 add constraint user1FKey1
foreign key(role_id) references role(role_id) on delete cascade;

alter table image add constraint imageFKey1
foreign key(user_id) references user1(user_id) on delete cascade;

alter table image add constraint imageFKey2
foreign key(gallery_id) references gallery(gallery_id) on delete cascade;

alter table gallery add constraint galleryFKey1
foreign key(role_id) references role(role_id) on delete cascade;

--foreign key section ends here

