-- Schema of the database

create table db_version (
    version integer not null
);

-----

insert into db_version (version) values (1);
