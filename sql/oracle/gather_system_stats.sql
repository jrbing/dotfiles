-- Usage: @gather_system_stats
-- Summary: Runs the dbms_stats.gather_system_stats job with default parameters

whenever sqlerror exit failure;

--Run the dbms_stats job
execute dbms_stats.gather_system_stats;
