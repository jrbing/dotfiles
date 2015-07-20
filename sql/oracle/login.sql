--Initial login settings
set linesize 32767
set trimspool on
set trimout on
set wrap off
set termout on
set pagesize 50000
-- set pagesize 0
set long 5000
define _editor=vim
set sqlprompt '[0;31m&_user@&_connect_identifier[0;31m > [0;49m'
set editfile /tmp/afiedt.buf
