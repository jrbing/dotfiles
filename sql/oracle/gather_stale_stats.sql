-- Usage: @gather_stale_stats
-- Summary: Collect statistics for stale database objects

exec dbms_stats.gather_database_stats(options=>'gather stale');
