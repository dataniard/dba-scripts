-- asm_diskgroup_space.sql

BREAK on "DSKGRP_NO:DISKGROUP:FREE MB" skip 1 on report
COMPUTE SUM OF TOTAL_MB on "DSKGRP_NO:DISKGROUP:FREE MB"
COMPUTE SUM OF TOTAL_MB on report
COMPUTE SUM OF FREE_MB on "DSKGRP_NO:DISKGROUP:FREE MB"

col PATH format a40
col REDUNDANCY_TYPE format a10
col "DSKGRP_NO:DISKGROUP:FREE MB" format a30
col FAILURE_GROUP format a20
col "DSK_NO:DISK" format a25
col b.USABLE_FILE_MB format 9G999G999G999
set pages 2000 lines 300
select
           b.GROUP_NUMBER || ':' || b.NAME || ':' ||b.USABLE_FILE_MB as "DSKGRP_NO:DISKGROUP:FREE MB",
           a.FAILGROUP as FAILURE_GROUP,
           a.DISK_NUMBER || ':' || a.NAME as "DSK_NO:DISK",
           a.TOTAL_MB as TOTAL_MB,
           a.FREE_MB as FREE_MB,
		   round((1-nvl(a.FREE_MB/a.TOTAL_MB))*100,2) PCT_USED,
           a.PATH,
		   b.TYPE as REDUNDANCY_TYPE,
		   a.MOUNT_STATUS as MOUNT,
		   a.HEADER_STATUS as HEADER_STATUS
from v$asm_disk a
join v$asm_diskgroup b
on a.GROUP_NUMBER = b.GROUP_NUMBER
where a.NAME like '%&DG%'
order by 
			b.GROUP_NUMBER || ':' || b.NAME || ':' ||b.USABLE_FILE_MB,
			a.FAILGROUP,
			a.NAME,
			b.NAME
/

CLEAR BREAKS
CLEAR COMPUTES

