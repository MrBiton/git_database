create table roles (
    id  serial primary key,
    name varchar(20) not null
    );
create table workshops(
    id serial primary key,
    name varchar(50) not null
);
create table brigades (
    id serial primary key,
    name varchar(40) not null,
    specialization varchar(40) not null
);
create table brigades_x_workshop(
    id serial primary key,
    id_workshop int not null references workshops(id) on delete cascade,
    id_brigades int not null references brigades(id) on delete cascade
);
create table users(
    id serial primary key,
    email varchar(30) not null,
    phone varchar(20) not null,
    surname varchar(20) not null,
    name varchar(15) not null,
    middle_name varchar(20) not null,
    date_of_register date default current_date,
    status bool not  null,
    id_workshop int not null references workshops(id) on delete set null,
    id_brigades int not null references brigades(id) on delete set null,
    hash_password varchar(255) not null 
 );
create table equipment(
    equipment_number varchar(35) primary key,
    name varchar(40) not null,
    model varchar(20) not null,
    zavod_number varchar(30) not null,
    commission_date date,
    work_date date,
    workshop_id int not null references workshops(id) on delete restrict,
    status varchar(20) check (status in('в работе','в ремонте','в простое','выведено из эксплуатации')),
    passport_link varchar(50) not null,
    creator varchar(30) not null,
    garantia_date date,
    created_at timestamp not null default current_timestamp
);
create table types_TO(
    code varchar(40) not null,
    name varchar(20) not null,
    description varchar(100) not null,
    periods integer,
    time_of_work integer,
    need_or_not bool not null
 );
create table request( 
    id serial primary key,
    types varchar(20) check (types in ('плановая', 'аварийная', 'текущая')),
    prioritet varchar(20) check (prioritet in ('низкий', 'средний', 'высокий', 'критический')),
    brigades_id integer not null references workshops(id) on delete restrict,
    users_id integer not null references users(id) on delete restrict,
    description varchar(50) not null,
    reason varchar(30) not null,
    date_of_start date,
    date_of_end date,
    real_date_of_start date,
    real_date_of_end date,
    report varchar(60) not null,
    time_of_nichego date
);
create table materials(
    id_materisals serial primary key,
    name varchar(25) not null,
    units varchar(20) not null,
    balance_on_store int not null,
    min_balance_on_store int not null,
    point varchar(30) not null,
    cost_per_one int not null,
    postavshik varchar(50) not null
);
create table journal (
   id_users int not null references users(id) on delete restrict,
   type_of_entity varchar(40) not null,
   type_of_action varchar(30) check (type_of_action in('создание','обновление','удаление','изменение статуса')),
   previous_znachenie varchar(30),
   new_znachenie varchar(25),
   date_and_time_operation timestamp not null default current_timestamp
)






