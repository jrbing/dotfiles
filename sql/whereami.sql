--Return information about the current Oracle environment
select instance_number "INSTANCE #"
 , substr(instance_name,1,10) instance
 , substr(host_name,1,15) host
 , version
 , status
 , to_char(sysdate,'YYYY/MM/DD HH:MI:SS') "DATE       TIME"
from v$instance;
