-- busca_detail_sessions
-- Resumen sesiones/maquina

col username format a20
col machine format a30
col program format a50
col module format a35
col process format a20
col service_name format a25
col osuser format a17
col client_identifier format a15
col min_h_logon format a25
col max_h_logon format a25
select inst_id,
username,machine--,terminal
,program
--,status
--,client_identifier
,
service_name,
to_char(min(logon_time),'YYYY/MM/DD HH24:MI:SS') as min_h_logon,
to_char(max(logon_time),'YYYY/MM/DD HH24:MI:SS') as max_h_logon,
--to_char(sysdate-(last_call_et/24/60/60),'YYYY/MM/DD') as hora_ini,
--,module
--osuser,--process,
--status,
count(*) 
from gv$session
--where machine like '%dgpeplpos7v01%'
--where upper(machine) not like '%DBOR%'
--where username = 'INFOPAL'
where username is not null
group by inst_id,
username,machine--,terminal
,program
--,client_identifier
--,status
,service_name
--,to_char(logon_time,'YYYY/MM/DD HH24:MI:SS')
--,to_char(sysdate-(last_call_et/24/60/60),'YYYY/MM/DD')
--,module
--,osuser--,process
--,status
order by service_name,username,machine,program;

col username format a15
col machine format a35
col program format a50
col module format a35
col process format a20
col osuser format a17
col service_name format a30
col min_h_logon format a25
col max_h_logon format a25
select inst_id,service_name--,username
--,machine,
username,
--machine,status,
to_char(min(logon_time),'YYYY/MM/DD HH24:MI:SS') as min_h_logon,
to_char(max(logon_time),'YYYY/MM/DD HH24:MI:SS') as max_h_logon,
--to_char(sysdate-(last_call_et/24/60/60),'YYYY/MM/DD') as hora_ini,
--,module,osuser,--process,
count(*) 
from gv$session
--where upper(machine) like '%APPS%'
--where upper(machine) not like '%DBOR%'
--where username = 'APMADRID'
group by inst_id,service_name,username
--,machine
--,status
--username
--,machine
--,status
--,to_char(sysdate-(last_call_et/24/60/60),'YYYY/MM/DD')--,module,osuser--,process
order by 2,3;

col username format a20
col machine format a30
col program format a50
col module format a35
col process format a20
col service_name format a20
col osuser format a17
col client_identifier format a15
col min_h_logon format a25
col max_h_logon format a25
select --inst_id,
username,
--machine,--,terminal
--,status
--client_identifier,
service_name,
--to_char(min(logon_time),'YYYY/MM/DD HH24:MI:SS') as min_h_logon,
--to_char(max(logon_time),'YYYY/MM/DD HH24:MI:SS') as max_h_logon,
--to_char(sysdate-(last_call_et/24/60/60),'YYYY/MM/DD') as hora_ini,
--,module
--osuser,--process,
count(*) 
from gv$session
--where machine like 'H12APPS250VX%'
--where upper(machine) like '%APPS%'
--where upper(machine) not like '%DBOR%'
--where username in ('RELEC','RECETA')
--where username is not null
group by --inst_id,
username,
--machine
--,client_identifier--,terminal
--,client_identifier
--,status
service_name
--,to_char(logon_time,'YYYY/MM/DD HH24:MI:SS')
--,to_char(sysdate-(last_call_et/24/60/60),'YYYY/MM/DD')--,module
--,osuser--,process
order by 3 desc;
inst_id,client_identifier,
inst_id,machine;

-- Por inst_id, servicio
col username format a20
col machine format a30
col program format a50
col module format a35
col process format a20
col service_name format a20
col osuser format a17
col client_identifier format a15
col min_h_logon format a25
col max_h_logon format a25
select inst_id,
service_name,--username,
--status,
to_char(min(logon_time),'YYYY/MM/DD HH24:MI:SS') as min_h_logon,
to_char(max(logon_time),'YYYY/MM/DD HH24:MI:SS') as max_h_logon,
count(*) 
from gv$session
group by inst_id,
service_name--,username,
--status
order by 
service_name,inst_id;


col username format a20
col machine format a40
col program format a50
col module format a35
col process format a20
col osuser format a17
select inst_id,
username,--machine,--status,
--to_char(sysdate-(last_call_et/24/60/60),'YYYY/MM/DD') as hora_ini,
--,module,osuser,--process,
count(*) 
from gv$session --as of timestamp (sysdate-(5/24))
--where upper(machine) like '%APPS%'
--where upper(machine) not like '%DBOR%'
--where username = 'APMADRID'
group by --inst_id,
username--,machine--,status
--,to_char(sysdate-(last_call_et/24/60/60),'YYYY/MM/DD')--,module,osuser--,process
order by 1;

col username format a15
col machine format a35
col program format a50
col module format a35
col process format a20
col status format a9
col osuser format a17
col service_name format a15
col MAX_HORA_LAST_CALL format a20
col MIN_HORA_LAST_CALL format a20
col MIN_H_LOGON format a20
col MAX_H_LOGON format a20
select --inst_id,
username,machine,status
,osuser,service_name,
to_char(sysdate-(max(last_call_et)/24/60/60),'YYYY/MM/DD HH24:MI:SS') as max_hora_last_call,
to_char(sysdate-(min(last_call_et)/24/60/60),'YYYY/MM/DD HH24:MI:SS') as min_hora_last_call,
to_char(min(logon_time),'YYYY/MM/DD HH24:MI:SS') as min_h_logon,
to_char(max(logon_time),'YYYY/MM/DD HH24:MI:SS') as max_h_logon,
count(*) 
from gv$session
--where machine = 'h12apps017vx'
--where upper(machine) not like '%DBOR%'
--where username = 'CIBELES'
--and osuser = 'oraias'
--and module is not null
group by --inst_id,
username,machine,status
,module,osuser,service_name
order by 1 asc;


col username format a13
col machine format a35
col program format a50
col service_name format a20
col module format a40
col max_logon format a25
col min_logon format a25
select --inst_id,
--username,
machine,
--program,--module,
SERVICE_NAME,
--to_char(max(logon_time),'DD/MM/YYYY HH24:MI') max_logon,
--to_char(min(logon_time),'DD/MM/YYYY HH24:MI') min_logon, 
count(*) total_sess
from gv$session
--where upper(machine) like '%APPS%'
where upper(machine) not like '%DBOR%'
--and username like 'AP%'
group by 
--inst_id,
--username,
machine,
--program,
SERVICE_NAME
--module
order by 1;

col machine format a35
col program format a50
col module format a35
col service_name format a35
select 
--inst_id,
username,
machine
,service_name
,--program,module,
count(*) 
from gv$session
--where upper(machine) like '%APPS%'
--where upper(machine) not like '%DBOR%'
--where username = 'APMADRID'
group by 
--inst_id,
username,machine,service_name
--,program,module
order by 1;

--

col username format a15		
col machine format a25
col service_name format a15
select 
username,
service_name
,machine
--,to_char(logon_time,'DD/MM/YYYY HH24:MI:SS') hlogon
--,to_char(sysdate-(last_call_et/24/60/60),'YYYY/MM/DD HH24:MI:SS') HINI_actv
--,round(((sysdate-(last_call_et/24/60/60))-logon_time)*24*60,2) hdiff
,count(*)
--program,module,
from v$session
--where upper(machine) like '%APPS%'
--where upper(machine) not like '%DBOR%'
--where username = 'RELEC'
group by username,service_name,machine
order by 1 desc;
