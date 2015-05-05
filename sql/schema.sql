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
    name varchar(255) not null,
    path varchar(255) not null,
    origin_id integer references remotes(id)
);

-----

create table user_repository (
    user_id integer references users(id) not null,
    remote_id integer references remotes(id) not null,
    primary key(user_id, remote_id)
);

-----

create table remotes (
    id serial primary key,
    url varchar(255) unique not null,
    repository_id integer references repositories(id) not null
);

-----

create type review_status as enum ('opened', 'rejected', 'closed');

-----

create table reviews (
    id serial primary key,
    owner integer references users(id) not null,
    status review_status not null
);

-----

create table review_comments (
    id serial primary key,
    owner integer references users(id) not null,
    text text not null
);

-----

create table diffs (
    id serial primary key,
    review_id integer references reviews(id) not null,
    repository_id integer references repositories(id) not null,
    base_remote_id integer references remotes(id) not null,
    fork_remote_id integer references remotes(id) not null,
    base_remote_branch varchar(255) not null,
    fork_remote_branch varchar(255) not null
);

-----

create table line_notes (
    id serial primary key,
    diff_id integer references(id),
    filename varchar(255) not null,
    line_number integer not null,
    commit_hash varchar(40) not null,
    owner integer references users(id),
    text text not null
);
