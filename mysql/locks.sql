-- about locks
-- https://www.alibabacloud.com/blog/generation-and-handling-of-metadata-locks-on-rds-for-mysql-tables_308797

-- 
select concat('kill ',i.trx_mysql_thread_id,';') from information_schema.innodb_trx i,
  (select 
         id, time
     from
         information_schema.processlist
     where
         time = (select 
                 max(time)
             from
                 information_schema.processlist
             where
                 state = 'Waiting for table metadata lock'
                     and substring(info, 1, 5) in ('alter' , 'optim', 'repai', 'lock ', 'drop ', 'creat'))) p
  where timestampdiff(second, i.trx_started, now()) > p.time
  and i.trx_mysql_thread_id  not in (connection_id(),p.id);

-- si la anterior no funciona...

select 
    concat('kill ', p1.id, ';')
from
    information_schema.processlist p1,
    (select 
        id, time
    from
        information_schema.processlist
    where
        time = (select 
                max(time)
            from
                information_schema.processlist
            where
                state = 'Waiting for table metadata lock'
                    and substring(info, 1, 5) in ('alter' , 'optim', 'repai', 'lock ', 'drop ', 'creat', 'trunc'))) p2
where
    p1.time >= p2.time
        and p1.command in ('Sleep' , 'Query')
        and p1.id not in (connection_id() , p2.id);