-- Gets a single user

create or replace function user_by_login(p_login varchar(255)) returns integer as $$
    select id
    from users
    where login = p_login;
$$
language sql;
