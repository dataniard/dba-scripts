-- sin v$sql
set lin 300 pages 2000
col event_aas format a15
col sid format 999999
col sidserial format a15
col ses.sid||','||ses.serial# format a12
col machine format a15
col event format a16
col wait_class format a12	
col HORA_LOGIN format a20
col client_identifier format a10
col hora_ini format a10
col H_LOGON format a10
col texto format a30
col status format a1
col ET format 999999
col ss_wait format 999999
col program format a17
col osuser format a12
col ospid format a8
col process format a8
col I format 9
col username format a15
col module format a15
col srv format a10
col status format a8
--select 'alter system kill session '''||ses.sid||','||ses.serial#||',@'||ses.inst_id||''' immediate;'
--select 'alter system kill session '''||ses.sid||','||ses.serial#||''' immediate;'
select ses.sid||','||ses.serial#||',@'||ses.inst_id as sidserial,
	   ses.inst_id I,
	   p.spid ospid, -- Esta SI
	   ses.process,  -- Esta SI
	   ses.username,
		ses.machine,  -- Esta SI
	   ses.program, -- Esta SI
	   ses.osuser,
	   ses.client_identifier, -- Esta SI
	   ses.wait_class,
	   ses.event,
	   decode(ses.state,'WAITING',ses.wait_class,'CPU') event_aas, 
   substr(ses.status,0,1) status, -- Esta SI
	   to_char(sysdate-(ses.last_call_et/24/60/60),'YYYY/MM/DD HH24:MI:SS') as hora_ini,
	   seconds_in_wait as ss_wait,
	   last_call_et ET,
--       substr((select sql_text from gv$sql vsql where vsql.sql_id=ses.sql_id and vsql.inst_id = ses.inst_id and vsql.child_number = ses.sql_child_number and rownum = 1),0,150) texto, -- ESTA SI
--	 substr(sq.sql_text,0,150) texto,
	 service_name as srv, -- Esta SI
	 ses.sql_id
  from gv$session ses 
--  left outer join gv$sql sq on (ses.sql_id = sq.sql_id and sq.inst_id = ses.inst_id and sq.child_number = ses.sql_child_number) 
--  left outer join gv$process p on (p.addr = ses.paddr and p.inst_id = ses.inst_id)
  ,gv$process p
--  where p.addr = ses.paddr
--  where p.inst_id = ses.inst_id
  where p.addr = ses.paddr
  and p.inst_id = ses.inst_id
--  and ses.inst_id = 3
  and ses.type <> 'BACKGROUND' -- Esta SI
  --and ses.osuser = 'garciamrj'
--  and ses.machine like '%SUMMA3CCUW016%'
--  and ses.status <> 'INACTIVE' -- Esta SI
--where ses.status <> 'INACTIVE'
--and ses.sid  in (547)
--and ses.username = 'BBOOETL5_D'
--and ses.PROGRAM like '%sqlplu%'
 and (ses.WAIT_CLASS <> 'Idle' -- Esta SI
 or ses.PROGRAM like '%(J%'
 or ses.PROGRAM like '%(D%'
 or ses.PROGRAM like '%(P%'
 ) -- Esta SI
--and ses.username = 'HORUS'
--and ses.sql_id = 'g38td6tdrvm8q'
--and ses.sid in ('183','127')
--	and ses.program like 'rman%'
--and last_call_et > 200
 order by last_call_et;
