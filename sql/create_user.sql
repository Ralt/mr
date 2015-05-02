-- Creates a user

create or replace function create_user(p_login varchar(255)) returns void as $$
    insert into user (login) values (p_login);
end; $$
language sql;
