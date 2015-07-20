whenever sqlerror exit failure;

--Run the dbms_stats job
execute dbms_stats.gather_system_stats;
