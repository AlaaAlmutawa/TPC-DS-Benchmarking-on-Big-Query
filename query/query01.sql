-- start query 1 in stream 0 using template query1.tpl
with customer_total_return 
as(select sr_customer_sk as ctr_customer_sk
         ,sr_store_sk as ctr_store_sk
         ,sum(SR_RETURN_AMT) as ctr_total_return
    from store_returns
        ,date_dim
    where sr_returned_date_sk = d_date_sk
        and d_year =2000
    group by sr_customer_sk
            ,sr_store_sk), 

high_return as (
    select ctr_store_sk,avg(ctr_total_return)*1.2 as limit_return
    from customer_total_return ctr2
    group by ctr_store_sk
)

select c_customer_id
from customer_total_return ctr1
    ,store
    ,customer
    ,high_return
where ctr1.ctr_total_return > high_return.limit_return
    and s_store_sk = ctr1.ctr_store_sk
    and s_state = 'TN'
    and ctr1.ctr_customer_sk = c_customer_sk
    and ctr1.ctr_store_sk = high_return.ctr_store_sk
order by c_customer_id
limit 100
;

-- end query 1 in stream 0 using template query1.tpl