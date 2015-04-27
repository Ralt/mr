-- Gets the schema version

create or replace function schema_version() returns int as $$
declare
    ret integer;
begin
    select version into ret from db_version;
    return ret;
end; $$
language plpgsql;
