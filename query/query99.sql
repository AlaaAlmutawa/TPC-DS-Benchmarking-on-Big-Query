-- start query 99 in stream 0 using template query99.tpl

/*
For catalog sales, create a report showing the counts of orders shipped 
  within 30 days, 
  from 31 to 60 days, 
  from 61 to 90 days, 
  from 91 to 120 days and 
  over 120 days 
within a given year, grouped by warehouse, call center and shipping mode.
*/

select 
   substr(w_warehouse_name,1,20) w_w_name
  ,sm_type
  ,cc_name
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk <= 30 ) then 1 else 0 end)  as days_30 
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk > 30) and 
                 (cs_ship_date_sk - cs_sold_date_sk <= 60) then 1 else 0 end )  as days_31_60 
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk > 60) and 
                 (cs_ship_date_sk - cs_sold_date_sk <= 90) then 1 else 0 end)  as days_61_90 
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk > 90) and
                 (cs_ship_date_sk - cs_sold_date_sk <= 120) then 1 else 0 end)  as days_91_120 
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk  > 120) then 1 else 0 end)  as days_gt_120
from
   catalog_sales
  ,warehouse
  ,ship_mode
  ,call_center
  ,date_dim
where
    d_month_seq between 1200 and 1200 + 11
and cs_ship_date_sk   = d_date_sk
and cs_warehouse_sk   = w_warehouse_sk
and cs_ship_mode_sk   = sm_ship_mode_sk
and cs_call_center_sk = cc_call_center_sk
group by
   w_w_name
  ,sm_type
  ,cc_name
order by w_w_name
        ,sm_type
        ,cc_name
limit 100
;

-- end query 99 in stream 0 using template query99.tpl