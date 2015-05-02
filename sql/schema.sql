-- Schema of the database
-- /!\ Separate each command with 5 hyphens.

create table db_version (
    version integer not null
);

-----

insert into db_version (version) values (1);

-----

create table user (
    id serial primary key,
    login varchar(255) unique not null
);

-----

create table repository (
    id serial primary key,
    name varchar(255) unique not null
);

-----

create table user_repository (
    user_id integer references user(id),
    repository_id integer references repository(id),
    primary key(user_id, repository_id)
);
