-- Usage: @stale_stats
-- Summary: Display stale database statistics

col table_name for a30

select owner
     , table_name
     , num_rows
     , last_analyzed
  from dba_tab_statistics
 where stale_stats = 'YES'
 order by table_name;
