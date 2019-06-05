-- 9i

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
col p1 format a20
col p2 format a16
col p3 format a10 
select --'kill -9 '||p.spid
--       ses.inst_id I,
--       p.spid ospid, -- Esta SI
       ses.sid||','||ses.serial# as sidserial,
       ses.process,  -- Esta SI
       ses.username,
        ses.machine,  -- Esta SI
       -- ses.module, -- Esta NO
       ses.program, -- Esta SI
       ses.osuser,
--       ses.client_identifier, -- Esta SI
--       ses.wait_class,
       w.event,
       ses.status, -- Esta SI
	   --to_char(ses.logon_time,'YYYY/MM/DD HH24:MI:SS') as h_logon, -- Esta SI
--       to_char(sysdate-(ses.last_call_et/24/60/60),'YYYY/MM/DD HH24:MI:SS') as hora_ini,
--       seconds_in_wait as ss_wait,
       last_call_et ET,
       substr((select sql_text from v$sqlarea vsql where vsql.HASH_VALUE=ses.SQL_HASH_VALUE and rownum = 1),0,150) texto, -- ESTA SI
--	   substr((select sql_text from gv$sql vsql where vsql.sql_id=ses.prev_sql_id and rownum = 1),0,150) texto_prev, -- ESTA SI
       -- (select sql_text from gv$sql vsql where vsql.sql_id=ses.sql_id and rownum = 1) texto, 
--	   service_name as srv, -- Esta SI
--	   ses.sql_id */
p1text||':'||p1 p1,p2text||':'||p2 p2,p3text||':'||p3 p3,
ses.SQL_HASH_VALUE
  from v$session ses 
--  left outer join gv$sqlarea sq on (ses.sql_id = sq.sql_id and sq.inst_id = ses.inst_id /*and sq.child_number = ses.sql_child_number*/) 
  ,v$process p
  ,v$session_wait w
  where p.addr (+) = ses.paddr
  and w.sid = ses.sid
--  and ses.sid=51
  and ses.username is not null
  and ses.status <> 'INACTIVE'
--  and p.inst_id (+) = ses.inst_id
--and ses.inst_id = 1
  --    and p.spid = 29644
--  and ses.type = 'BACKGROUND' 
--  and ses.type <> 'BACKGROUND' -- Esta SI
--  and ses.WAIT_CLASS <> 'Idle' -- Esta SI
--where ses.program like 'oracle@h12dbor011 (J0%'
--where wait_class = 'Network'
--and ses.USERNAME = 'MGP_RHWEB'
--where program = 'TOAD.exe'
--and osuser = 'fhferrera'
--and sql_id = '8cs6vc51annmt'
-- and ses.machine like '%h12dbor005vx%'
--  and ses.inst_id = 4
 -- and ses.username like ('DBA_DW_ESCILA_%')
  -- and sid = 141
--  and ses.sql_id = 'ckj9hdhhvr5gq'
   -- and ses.sql_id = 'cxcfxbjrh78tx'
--    and ses.sql_id = '81dzchms9x0p5'
  --and ses.logon_time < to_date('02/02/2013 13:00','DD/MM/YYYY HH24:MI')
--  and wait_class <> 'Cluster'
--  and ses.last_call_et > 500
-- and sid in (772)
--and event = 'SQL*Net message from client'
-- and ses.username = 'YUNSM'
--  and ses.sql_id = 'gj3dd70q61pkt'
-- and p.spid in ('462')
-- and ses.inst_id = 3
-- and ses.status <> 'INACTIVE' -- Esta SI
 order by last_call_et;
