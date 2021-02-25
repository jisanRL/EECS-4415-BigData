-- the script

-- create table stream
create table Stream (
    id int,
    grp int,
    measure int,
    constraint streamPK primary key (id),
    constraint idNotNeg check (id >= 0),
    constraint grpNotNeg check (grp >= 0)
);

-- insert into stream TABLE
insert into Stream (id, grp, measure)
values
    ( 0, 0,  2),
    ( 1, 0,  3),
    ( 2, 1,  5),
    ( 3, 1,  7),
    ( 4, 1, 11),
    ( 5, 0, 13),
    ( 6, 0, 17),
    ( 7, 0, 19),
    ( 8, 0, 23),
    ( 9, 2, 29),
    (10, 2, 31),
    (11, 2, 37),
    (12, 5, 41),
    (13, 3, 43);

select * from stream;