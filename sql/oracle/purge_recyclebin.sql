set echo on;
whenever sqlerror exit failure;

-- Purge the dba recyclebin
purge dba_recyclebin;

set echo off;
