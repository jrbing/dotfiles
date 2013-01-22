--Issue the following query to show information about the protection mode,
--the protection level, the role of the database, and switchover status:

select DATABASE_ROLE
     , DB_UNIQUE_NAME INSTANCE
     , OPEN_MODE
     , PROTECTION_MODE
     , PROTECTION_LEVEL
     , SWITCHOVER_STATUS
  from V$DATABASE;

--On the standby database, query the V$ARCHIVED_LOG view to identify
--existing files in the archived redo log.

select SEQUENCE
     , FIRST_TIME
     , NEXT_TIME
  from V$ARCHIVED_LOG
 order by SEQUENCE;

--Or...

select THREAD
     , MAX(SEQUENCE) AS "LAST_APPLIED_LOG"
  from V$LOG_HISTORY
 group by THREAD#;

--On the standby database, query the V$ARCHIVED_LOG view to verify the
--archived redo log files were applied.

select SEQUENCE#
     , APPLIED
  from V$ARCHIVED_LOG
 order by SEQUENCE#;

--Query the physical standby database to monitor Redo Apply and redo
--transport services activity at the standby site.

select PROCESS
     , STATUS
     , THREAD#
     , SEQUENCE#
     , BLOCK#
     , BLOCKS
  from V$MANAGED_STANDBY;

--To determine if real-time apply is enabled, query the RECOVERY_MODE
--column of the V$ARCHIVE_DEST_STATUS view.

select RECOVERY_MODE
  from V$ARCHIVE_DEST_STATUS;

--The V$DATAGUARD_STATUS fixed view displays events that would typically
--be triggered by any message to the alert log or server process trace
--files.

select MESSAGE
  from V$DATAGUARD_STATUS;

--Determining Which Log Files Were Not Received by the Standby Site.

select LOCAL.THREAD#
     , LOCAL.SEQUENCE#
  from (
    select THREAD#
        , SEQUENCE#
      from V$ARCHIVED_LOG
    where DEST_ID = 1
       ) LOCAL
 where LOCAL.SEQUENCE# NOT IN (
    select SEQUENCE#
      from V$ARCHIVED_LOG
    where DEST_ID = 2
      and THREAD# = LOCAL.THREAD#
       );

--If a delayed apply has been specified or an archive log is missing then switchover may take longer than expected.

--Check v$managed_standby

select PROCESS
     , STATUS
     , SEQUENCE#
  from V$MANAGED_STANDBY;

--OR alternatively:

select NAME
     , APPLIED
  from V$ARCHIVED_LOG;

