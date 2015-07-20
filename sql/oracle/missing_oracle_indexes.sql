-- Identify indexes that are defined in Oracle, but not in Application Designer
-- Taken from:  http://peoplesoft.wikidot.com/managing-indexes

whenever sqlerror exit failure;

select
    DI.OWNER,
    DI.TABLE_NAME,
    DI.INDEX_NAME,
    DI.INDEX_TYPE as DB_INDEXTYPE,
    DI.UNIQUENESS,
    DI.STATUS,
    DI.NUM_ROWS,
    DI.LAST_ANALYZED,
    nvl(R.RECNAME, 'Not Found in Application Designer') as RECNAME
from
    DBA_INDEXES DI left outer join PSRECDEFN R
    on replace(DI.TABLE_NAME, 'PS_', '') = R.RECNAME
where
    DI.OWNER = 'SYSADM'
    and not exists (
        select  1
        from    PSINDEXDEFN
        where   'PS' || INDEXID || RECNAME = DI.INDEX_NAME
    )
order by
    DI.OWNER, DI.TABLE_NAME
;
