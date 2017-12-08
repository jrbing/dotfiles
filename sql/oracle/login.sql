--Initial login settings
define _editor=vim
set sqlprompt '@|red  _user@_connect_identifier > |@'
set sqlformat ansiconsole
set pagesize 25
set editfile /tmp/sqlclbuf.sql
--set nohistory SET, SHOW, HISTORY, CLEAR
set encoding UTF8

-- Aliases
alias plan=select * from table(dbms_xplan.display_cursor);
alias fuzzy=select owner, object_name, object_type from dba_objects where object_name like :name order by 1,2,3 fetch first 10 rows only;
alias alert=select to_char(originating_timestamp, 'DD-MON-YYYY HH24:MI:SSxFF') time_entry, substr(message_text, 0, 75) || '...' abbr_message_text from x$dbgalertext order by originating_timestamp desc fetch first 10 rows only;
alias top=select SQL
     , SQL_ID
     , CPU_SECONDS_FORM CPU
     , ELAPSED_SECONDS_FORM ELAPSED
     , DISK_READS
     , BUFFER_GETS
     , EXECUTIONS_FORM EXECS
     , MODULE
     , LAST_ACTIVE_TIME_FORM
  from (
    select D.*
        , ROWNUM ROW#
      from (
        select D.*
          from (
            select substr(SQL_TEXT, 1, 25) as SQL
                , S.CPU_TIME / 1000000 as CPU_SECONDS
                ,
                  case
                  when S.CPU_TIME < 1000 then '< 1 ms'
                  when S.CPU_TIME < 1000000 then TO_CHAR(ROUND(S.CPU_TIME / 1000,1) ) || ' ms'
                  when S.CPU_TIME < 60000000 then TO_CHAR(ROUND(S.CPU_TIME / 1000000,1) ) || ' s'
                  else TO_CHAR(ROUND(S.CPU_TIME / 60000000,1) ) || ' m'
                  end as CPU_SECONDS_FORM
                , DECODE(L.MAX_CPU_TIME,0,0,S.CPU_TIME / L.MAX_CPU_TIME) as CPU_SECONDS_PROP
                , S.ELAPSED_TIME / 1000000 as ELAPSED_SECONDS
                ,
                  case
                  when S.ELAPSED_TIME < 1000 then '< 1 ms'
                  when S.ELAPSED_TIME < 1000000 then TO_CHAR(ROUND(S.ELAPSED_TIME / 1000,1) ) || ' ms'
                  when S.ELAPSED_TIME < 60000000 then
                  TO_CHAR(ROUND(S.ELAPSED_TIME / 1000000,1) ) || ' s'
                  else TO_CHAR(ROUND(S.ELAPSED_TIME / 60000000,1) ) || ' m'
                  end as ELAPSED_SECONDS_FORM
                , DECODE(L.MAX_ELAPSED_TIME,0,0,S.ELAPSED_TIME / L.MAX_ELAPSED_TIME) as ELAPSED_SECONDS_PROP
                , S.DISK_READS as DISK_READS
                ,
                  case
                  when S.DISK_READS < 1000 then TO_CHAR(S.DISK_READS)
                  when S.DISK_READS < 1000000 then TO_CHAR(ROUND(S.DISK_READS / 1000,1) ) || 'K'
                  when S.DISK_READS < 1000000000 then TO_CHAR(ROUND(S.DISK_READS / 1000000,1) ) || 'M'
                  else TO_CHAR(ROUND(S.DISK_READS / 1000000000,1) ) || 'G'
                  end as DISK_READS_FORM
                , DECODE(L.MAX_DISK_READS,0,0,S.DISK_READS / L.MAX_DISK_READS) as DISK_READS_PROP
                , S.BUFFER_GETS as BUFFER_GETS
                ,
                  case
                  when S.BUFFER_GETS < 1000 then TO_CHAR(S.BUFFER_GETS)
                  when S.BUFFER_GETS < 1000000 then TO_CHAR(ROUND(S.BUFFER_GETS / 1000,1) ) || 'K'
                  when S.BUFFER_GETS < 1000000000 then
                  TO_CHAR(ROUND(S.BUFFER_GETS / 1000000,1) ) || 'M'
                  else TO_CHAR(ROUND(S.BUFFER_GETS / 1000000000,1) ) || 'G'
                  end as BUFFER_GETS_FORM
                , DECODE(L.MAX_BUFFER_GETS,0,0,S.BUFFER_GETS / L.MAX_BUFFER_GETS) as BUFFER_GETS_PROP
                , S.EXECUTIONS as EXECUTIONS
                ,
                  case
                  when S.EXECUTIONS < 1000 then TO_CHAR(S.EXECUTIONS)
                  when S.EXECUTIONS < 1000000 then TO_CHAR(ROUND(S.EXECUTIONS / 1000,1) ) || 'K'
                  when S.EXECUTIONS < 1000000000 then TO_CHAR(ROUND(S.EXECUTIONS / 1000000,1) ) || 'M'
                  else TO_CHAR(ROUND(S.EXECUTIONS / 1000000000,1) ) || 'G'
                  end as EXECUTIONS_FORM
                , DECODE(L.MAX_EXECUTIONS,0,0,S.EXECUTIONS / L.MAX_EXECUTIONS) as EXECUTIONS_PROP
                , DECODE(S.MODULE,null,' ',S.MODULE) as MODULE
                , S.LAST_ACTIVE_TIME as LAST_ACTIVE_TIME
                , DECODE(
                    S.LAST_ACTIVE_TIME,
                    null,' ',
                  TO_CHAR(S.LAST_ACTIVE_TIME,'DD-Mon-YYYY HH24:MI:SS')
                  ) as LAST_ACTIVE_TIME_FORM
                , S.SQL_ID as SQL_ID
                , S.CHILD_NUMBER as CHILD_NUMBER
                , S.INST_ID as INST_ID
              from GV$SQL S
                , (
                select MAX(CPU_TIME) as MAX_CPU_TIME
                    , MAX(ELAPSED_TIME) as MAX_ELAPSED_TIME
                    , MAX(DISK_READS) as MAX_DISK_READS
                    , MAX(BUFFER_GETS) as MAX_BUFFER_GETS
                    , MAX(EXECUTIONS) as MAX_EXECUTIONS
              from GV$SQL
              ) L
              ) D
        order by CPU_SECONDS_PROP desc
            , SQL
            , DISK_READS_PROP
            , BUFFER_GETS_PROP
            , EXECUTIONS_PROP
            , ELAPSED_SECONDS_PROP
            , MODULE
        , LAST_ACTIVE_TIME
       ) D
       ) D
 where ROW# >= 1
   and ROW# <= :high;
