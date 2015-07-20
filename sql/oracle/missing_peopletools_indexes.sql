-- Identify indexes that are defined in Application Designer, but not in Oracle
-- Taken from:  http://peoplesoft.wikidot.com/managing-indexes

whenever sqlerror exit failure;

select R.RECNAME
     , R.RECDESCR
     , R.INDEXCOUNT
     , R.SQLTABLENAME
     , 'PS' || I.INDEXID || I.RECNAME as PS_INDEXNAME
     , I.INDEXID
     , (case when I.INDEXTYPE = 1 then 'Key' when I.INDEXTYPE  = 2 then 'User' when I.INDEXTYPE = 3 then 'Alt' when I.INDEXTYPE = 4 then 'User' else 'Unknown' end) as PS_INDEXTYPE
  from PSRECDEFN R
 inner
  join PSINDEXDEFN I
    on R.RECNAME              = I.RECNAME
 where R.RECTYPE              = 0
   and not exists (
    select 1
      from DBA_INDEXES
    where INDEX_NAME             = 'PS' || I.INDEXID || I.RECNAME
       )
 order by R.RECNAME
     , PS_INDEXNAME ;
