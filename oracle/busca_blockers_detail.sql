-- busca_blockers_detail
-- Detalle bloqueadores

--alter system kill session '1220,114,@1' immediate;
set lin 300 pages 2000
col sidserial format a15
col HORA_LOGIN format a20
col client_identifier format a10
col hora_ini format a10
col h_logon format a10
col texto format a30
col program format a20
col ET format 999999
col ss_wait format 999999
col I format 9
col bi format 9
col bs format 999999
col username format a15
col module format a15
col machine format a15
col srv format a10
col EVENT format a25
col OSUSER format a10
--select 'alter system kill session '''||ses.sid||','||ses.serial#||',@'||ses.inst_id''' immediate;'
select ses.sid||','||ses.serial#||',@'||ses.inst_id as sidserial,
     p.spid ospid,
     ses.process,
	   ses.username,
	   ses.machine,
	   -- ses.module, 
     ses.program, 
     substr(ses.status,0,1) status, -- Esta SI
	   ses.osuser,
	   ses.client_identifier, -- Esta SI
--       ses.wait_class, --Esta SI
     ses.event,
	 	 blocking_instance bi,
		 blocking_session bs,
		 to_char(ses.logon_time,'YYYY/MM/DD HH24:MI:SS') as h_logon,
     to_char(sysdate-(ses.last_call_et/24/60/60),'YYYY/MM/DD HH24:MI:SS') as hora_ini,
--       seconds_in_wait as ss_wait,
	   last_call_et ET,
	   substr((select sql_text from gv$sql vsql where vsql.sql_id=ses.sql_id and rownum = 1),0,150) texto,
--        substr(sq.sql_text,0,150) texto, -- ESTA SI
--        service_name as srv,
		ses.sql_id
  from gv$session ses
  left outer join gv$sql sq on (ses.sql_id = sq.sql_id and sq.inst_id = ses.inst_id and sq.child_number = ses.sql_child_number)
  ,gv$process p
  where p.addr = ses.paddr
  and p.inst_id = ses.inst_id
  -- and p.spid = 25875
   and ses.type <> 'BACKGROUND'
  -- and OSUSER='jboss'
  -- and event like '%enq: TX - row lock conten%'
  -- and ses.WAIT_CLASS <> 'Idle' -- Esta SI
  -- and ses.program like '%PMON%'
  -- and ses.machine like '%ad0apps113%'
  -- and ses.inst_id = 2
  -- and ses.username like ('MONITOR%')
  -- and sid in (1446)
  -- and last_call_et > 100
  -- and ses.sql_id = '4yy7aak5509t3'
  -- and wait_class <> 'Cluster'
  -- and ses.status <> 'INACTIVE' -- Esta SI
  and (ses.inst_id||','||ses.sid in (select blocking_instance||','||blocking_session
		  from gv$session
		  where blocking_session is not null)
  or blocking_session is not null)
order by last_call_et;

