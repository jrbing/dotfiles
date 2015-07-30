-- Usage: @purge_recyclebin
-- Summary: Purge the dba recyclebin

set echo on;
whenever sqlerror exit failure;

-- Purge the dba recyclebin
purge dba_recyclebin;

set echo off;
