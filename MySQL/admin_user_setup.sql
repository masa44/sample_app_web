create table admin_user(
    user_id int(9) zerofill not null auto_increment primary key,
    name1 varchar(255) not null,
    name2 varchar(255) not null,
    kana1 varchar(255) not null,
    kana2 varchar(255) not null,
    sex tinyint not null,
    email varchar(255) not null,
    group_list varchar(255) ,
    remarks text
) CHARACTER SET utf8;

