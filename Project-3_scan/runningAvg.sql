-- the script
\pset pager off

-- create table stream
\echo 
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

-- ======== ----

-- composite type that has float and boolean flag
\echo
DROP type if EXISTS intRec cascade;
CREATE TYPE intRec as (number float, restart BOOLEAN);                      -- the average result

-- stateCnt : composite type with two ints from stata and i value 
\echo
DROP type if exists stateCnt cascade;
CREATE TYPE stateCnt as (state float, cnt int);

-- runningAvgState -> accumalator function
\echo
DROP function if exists runningAvgState(stateCnt, intRec) cascade;
create function runningAvgState(stateCnt, intRec) 
    returns stateCnt language plpgsql as $f$                                    -- return of the func
declare i alias for $1;                                                     -- declare fields 
declare a alias for $2;
declare j stateCnt;
    begin 
        if a.restart or i is null then 
            j.state := a.number;
            j.cnt := 1; 
        elseif a.number is null then 
            j.state := i.state;
            j.cnt := 1;
        else 
            j.cnt := i.cnt + 1;
            j.state := i.state + (a.number - i.state) / j.cnt;              -- the avg calc
        end if;
        return j;
    end 
$f$;


-- runningAvgFinal -> returns the aggregate value
\echo
DROP function if exists runningAvgFinal(stateCnt) cascade;
create function runningAvgFinal(stateCnt) returns intRec language sql as $f$;
SELECT CAST(($1.state, false) as intRec);                                   -- casting of value occurs here
$f$;


-- runningAvg -> aggregate function
\echo
DROP aggregate if exists runningAvg(intRec) cascade;
create aggregate runningAvg(intRec) (
    sfunc = runningAvgState,
    stype = stateCnt,
    finalfunc = runningAvgFinal
);


-- pipeline
\echo 
WITH
    -- check the neighbour tuple to the left to get grp valus 
    cellLeft(id, grp, measure, lft) AS (
        SELECT id, grp, measure, coalesce(
            max(grp) over (ORDER BY id rows BETWEEN 1 preceding and 1 preceding), -1)
        FROM stream
    ),

    -- determine if current tuple is start of a group
    cellStart(id, grp, measure, start) as (
        SELECT id, grp, measure, CAST(
            case
                when grp = lft then 0
                else 1 
            end as boolean
        )
        from cellLeft
    ),

    -- bundle the measure and start-flag into intRC
    cellFlag(id, grp, intRC) as (
        SELECT id, grp, CAST((measure, start) as intRec)
        FROM cellStart
    ),

    -- all the runningAvg aggregagtor 
    cellRun(id, grp, measure, runningRC) as (
        SELECT id, grp, (intRC).number, runningAvg(intRC) over(ORDER BY id)
        FROM cellFlag
    ),

    -- extract the running sum from the composite 
    cellAggr(id, grp, measure, average) as (
        SELECT id, grp, measure, (runningRC).number
        FROM cellRun
    )

-- report (final sql representation)
SELECT id, grp, measure, average
FROM cellAggr ORDER BY id;
