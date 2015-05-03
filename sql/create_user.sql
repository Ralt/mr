-- Creates a user

create or replace function create_user(p_login varchar(255)) returns integer as $$
    insert into users (login) values (p_login) returning id;
$$
language sql;
