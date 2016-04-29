--Initial login settings
define _editor=vim
set sqlprompt '@|red  _user@_connect_identifier > |@'
set sqlformat ansiconsole
set pagesize 25
set editfile /tmp/sqlclbuf.sql
set nohistory SET, SHOW, HISTORY, CLEAR

-- Aliases
alias plan=select * from table(dbms_xplan.display_cursor);
alias fuzzy=select owner, object_name, object_type from dba_objects where object_name like :name order by 1,2,3 fetch first 10 rows only;
alias alert=select to_char(originating_timestamp, 'DD-MON-YYYY HH24:MI:SSxFF') time_entry, substr(message_text, 0, 75) || '...' abbr_message_text from x$dbgalertext order by originating_timestamp desc fetch first 10 rows only;
