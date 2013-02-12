--Initial login settings
-- set term off
set linesize 190
define _editor=vim
set serveroutput on size 1000000 format wrapped
set long 5000
set linesize 131
set trimspool on
set pagesize 9999
set sqlprompt "_user'@'_connect_identifier > "

-- set timing on
-- set term on
-- set sqlprompt ^[[32;47m&_user@&_connect_identifier^[[30m>^[[0;49m

-- set termout off
-- set timing off
-- COLUMN  host_cmd_col  NEW_VALUE host_cmd

-- SELECT  ( CASE 
          -- when sys_context('USERENV', 'DB_NAME')
          -- in (  'PROD', 'IPROD', 'KPROD',     -- rac instances
                -- 'PA', 'PALP', 'PP2', 'BPROD', -- db server 1
                -- 'ERP', 'QPROD', 'PR4',        -- db2 server
                -- 'HR', 'HTA'                   -- db3 server
             -- )
  -- THEN 'COLOR 0E'
  -- else 'COLOR 70'
        -- END) host_cmd_col
-- FROM dual;

-- HOST  &host_cmd

/*
COLOR [attr]

attr        Specifies color attribute of console output

Color attributes are specified by TWO hex digits -- the first corresponds to the
background; the second the foreground. Each digit can be any of the below values.

0 = Black    8 = Gray
1 = Blue     9 = Light Blue
2 = Green    A = Light Green
3 = Aqua     B = Light Aqua
4 = Red      C = Light Red
5 = Purple   D = Light Purple
6 = Yellow   E = Light Yellow
7 = White    F = Bright White
*/

-- set termout on
-- set timing on
