set echo on;
set serveroutput on;
whenever sqlerror exit failure;

-- Purge the dba recyclebin
purge dba_recyclebin;
