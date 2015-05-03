-- Schema of the database
-- /!\ Separate each command with 5 hyphens.

create table db_version (
    version integer not null
);

-----

insert into db_version (version) values (1);

-----

create table users (
    id serial primary key,
    login varchar(255) unique not null
);

-----

create table repositories (
    id serial primary key,
    name varchar(255) unique not null
);

-----

create table user_repository (
    user_id integer references users(id),
    repository_id integer references repositories(id),
    primary key(user_id, repository_id)
);
