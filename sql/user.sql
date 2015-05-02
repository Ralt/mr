-- Gets a single user

create or replace function user(p_login varchar(255)) returns integer as $$
    select id
    from user
    where login = p_login;
end; $$
language sql;
