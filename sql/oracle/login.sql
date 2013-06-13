--Initial login settings
-- set term off
set linesize 190
define _editor=vim
set serveroutput on size 1000000 format wrapped
set long 5000
set linesize 131
set trimspool on
set pagesize 9999
set sqlprompt '[0;31m&_user@&_connect_identifier[0;31m > [0;49m'
set editfile /tmp/afiedt.buf
