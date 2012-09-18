--Initial login settings
set term off
set linesize 190
define _editor=vim
set serveroutput on size 1000000 format wrapped
set long 5000
set linesize 131
set trimspool on
set pagesize 9999
define sql_prompt=idle
column user_sid new_value sql_prompt
select lower(user) || '@' || 
'&_CONNECT_IDENTIFIER' user_sid from dual;
set sqlprompt '&sql_prompt> '
set timing on
set term on
