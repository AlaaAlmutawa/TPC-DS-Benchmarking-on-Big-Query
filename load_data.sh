#!/bin/bash
# Load into BQ - Ref to SOURCE: https://github.com/snithish/tpc-ds_big-query/blob/master/load_data.sh
#this script was adjusted for our use case
#note that the script is expected .dat files (specifically to load store.dat into store table, and customer.dat into customer table)
# usage: ./load_data.sh $SCALE

PROJECT=scale_$1 #this is essentially your dataset name.
LOCATION=$2 #this is the project-id where your dataset resides

GCS_BUCKET="tpc-ds-data-repo/${1}SF" #make sure that this matches your directory setup on google bucket

GS_BASE=$GCS_BUCKET

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "load path: ${GS_BASE}"

echo -e "${RED}Starting to delete Dataset: ${PROJECT}"

bq rm -f --project_id ${LOCATION} $PROJECT

echo -e "${GREEN}Starting to create Dataset: ${PROJECT}"

bq mk --project_id ${LOCATION} $PROJECT

echo -e "${GREEN}Starting data load into Dataset: ${PROJECT} from GCS Path: ${GS_BASE}"

echo -e "${GREEN} Loading data into Table: ${PROJECT}.call_center"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.call_center gs://${GS_BASE}/call_center* \
cc_call_center_sk:integer,\
cc_call_center_id:string,\
cc_rec_start_date:string,\
cc_rec_end_date:string,\
cc_closed_date_sk:integer,\
cc_open_date_sk:integer,\
cc_name:string,\
cc_class:string,\
cc_employees:integer,\
cc_sq_ft:integer,\
cc_hours:string,\
cc_manager:string,\
cc_mkt_id:integer,\
cc_mkt_class:string,\
cc_mkt_desc:string,\
cc_market_manager:string,\
cc_division:integer,\
cc_division_name:string,\
cc_company:integer,\
cc_company_name:string,\
cc_street_number:string,\
cc_street_name:string,\
cc_street_type:string,\
cc_suite_number:string,\
cc_city:string,\
cc_county:string,\
cc_state:string,\
cc_zip:string,\
cc_country:string,\
cc_gmt_offset:float,\
cc_tax_percentage:float

echo -e "${GREEN} Loading data into Table: ${PROJECT}.catalog_page"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.catalog_page gs://${GS_BASE}/catalog_page* \
cp_catalog_page_sk:integer,\
cp_catalog_page_id:string,\
cp_start_date_sk:integer,\
cp_end_date_sk:integer,\
cp_department:string,\
cp_catalog_number:integer,\
cp_catalog_page_number:integer,\
cp_description:string,\
cp_type:string

echo -e "${GREEN} Loading data into Table: ${PROJECT}.catalog_returns"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.catalog_returns gs://${GS_BASE}/catalog_returns* \
cr_returned_date_sk:integer,\
cr_returned_time_sk:integer,\
cr_item_sk:integer,\
cr_refunded_customer_sk:integer,\
cr_refunded_cdemo_sk:integer,\
cr_refunded_hdemo_sk:integer,\
cr_refunded_addr_sk:integer,\
cr_returning_customer_sk:integer,\
cr_returning_cdemo_sk:integer,\
cr_returning_hdemo_sk:integer,\
cr_returning_addr_sk:integer,\
cr_call_center_sk:integer,\
cr_catalog_page_sk:integer,\
cr_ship_mode_sk:integer,\
cr_warehouse_sk:integer,\
cr_reason_sk:integer,\
cr_order_number:integer,\
cr_return_quantity:integer,\
cr_return_amount:float,\
cr_return_tax:float,\
cr_return_amt_inc_tax:float,\
cr_fee:float,\
cr_return_ship_cost:float,\
cr_refunded_cash:float,\
cr_reversed_charge:float,\
cr_store_credit:float,\
cr_net_loss:float

echo -e "${GREEN} Loading data into Table: ${PROJECT}.catalog_sales"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.catalog_sales gs://${GS_BASE}/catalog_sales* \
cs_sold_date_sk:integer,\
cs_sold_time_sk:integer,\
cs_ship_date_sk:integer,\
cs_bill_customer_sk:integer,\
cs_bill_cdemo_sk:integer,\
cs_bill_hdemo_sk:integer,\
cs_bill_addr_sk:integer,\
cs_ship_customer_sk:integer,\
cs_ship_cdemo_sk:integer,\
cs_ship_hdemo_sk:integer,\
cs_ship_addr_sk:integer,\
cs_call_center_sk:integer,\
cs_catalog_page_sk:integer,\
cs_ship_mode_sk:integer,\
cs_warehouse_sk:integer,\
cs_item_sk:integer,\
cs_promo_sk:integer,\
cs_order_number:integer,\
cs_quantity:integer,\
cs_wholesale_cost:float,\
cs_list_price:float,\
cs_sales_price:float,\
cs_ext_discount_amt:float,\
cs_ext_sales_price:float,\
cs_ext_wholesale_cost:float,\
cs_ext_list_price:float,\
cs_ext_tax:float,\
cs_coupon_amt:float,\
cs_ext_ship_cost:float,\
cs_net_paid:float,\
cs_net_paid_inc_tax:float,\
cs_net_paid_inc_ship:float,\
cs_net_paid_inc_ship_tax:float,\
cs_net_profit:float

echo -e "${GREEN} Loading data into Table: ${PROJECT}.customer_address"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.customer_address gs://${GS_BASE}/customer_address* \
ca_address_sk:integer,\
ca_address_id:string,\
ca_street_number:string,\
ca_street_name:string,\
ca_street_type:string,\
ca_suite_number:string,\
ca_city:string,\
ca_county:string,\
ca_state:string,\
ca_zip:string,\
ca_country:string,\
ca_gmt_offset:float,\
ca_location_type:string

echo -e "${GREEN} Loading data into Table: ${PROJECT}.customer_demographics"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.customer_demographics gs://${GS_BASE}/customer_demographics* \
cd_demo_sk:integer,\
cd_gender:string,\
cd_marital_status:string,\
cd_education_status:string,\
cd_purchase_estimate:integer,\
cd_credit_rating:string,\
cd_dep_count:integer,\
cd_dep_employed_count:integer,\
cd_dep_college_count:integer

echo -e "${GREEN} Loading data into Table: ${PROJECT}.customer"

### File name was renamed to tr_customer_*.dat for the ease of loading
bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.customer gs://${GS_BASE}/tr_customer_*.dat \
c_customer_sk:integer,\
c_customer_id:string,\
c_current_cdemo_sk:integer,\
c_current_hdemo_sk:integer,\
c_current_addr_sk:integer,\
c_first_shipto_date_sk:integer,\
c_first_sales_date_sk:integer,\
c_salutation:string,\
c_first_name:string,\
c_last_name:string,\
c_preferred_cust_flag:string,\
c_birth_day:integer,\
c_birth_month:integer,\
c_birth_year:integer,\
c_birth_country:string,\
c_login:string,\
c_email_address:string,\
c_last_review_date:string

echo -e "${GREEN} Loading data into Table: ${PROJECT}.date_dim"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.date_dim gs://${GS_BASE}/date_dim* \
d_date_sk:integer,\
d_date_id:string,\
d_date:date,\
d_month_seq:integer,\
d_week_seq:integer,\
d_quarter_seq:integer,\
d_year:integer,\
d_dow:integer,\
d_moy:integer,\
d_dom:integer,\
d_qoy:integer,\
d_fy_year:integer,\
d_fy_quarter_seq:integer,\
d_fy_week_seq:integer,\
d_day_name:string,\
d_quarter_name:string,\
d_holiday:string,\
d_weekend:string,\
d_following_holiday:string,\
d_first_dom:integer,\
d_last_dom:integer,\
d_same_day_ly:integer,\
d_same_day_lq:integer,\
d_current_day:string,\
d_current_week:string,\
d_current_month:string,\
d_current_quarter:string,\
d_current_year:string

echo -e "${GREEN} Loading data into Table: ${PROJECT}.household_demographics"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.household_demographics gs://${GS_BASE}/household_demographics* \
hd_demo_sk:integer,\
hd_income_band_sk:integer,\
hd_buy_potential:string,\
hd_dep_count:integer,\
hd_vehicle_count:integer

echo -e "${GREEN} Loading data into Table: ${PROJECT}.income_band"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.income_band gs://${GS_BASE}/income_band* \
ib_income_band_sk:integer,\
ib_lower_bound:integer,\
ib_upper_bound:integer

echo -e "${GREEN} Loading data into Table: ${PROJECT}.inventory"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.inventory gs://${GS_BASE}/inventory* \
inv_date_sk:integer,\
inv_item_sk:integer,\
inv_warehouse_sk:integer,\
inv_quantity_on_hand:integer

echo -e "${GREEN} Loading data into Table: ${PROJECT}.item"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.item gs://${GS_BASE}/item* \
i_item_sk:integer,\
i_item_id:string,\
i_rec_start_date:string,\
i_rec_end_date:string,\
i_item_desc:string,\
i_current_price:float,\
i_wholesale_cost:float,\
i_brand_id:integer,\
i_brand:string,\
i_class_id:integer,\
i_class:string,\
i_category_id:integer,\
i_category:string,\
i_manufact_id:integer,\
i_manufact:string,\
i_size:string,\
i_formulation:string,\
i_color:string,\
i_units:string,\
i_container:string,\
i_manager_id:integer,\
i_product_name:string

echo -e "${GREEN} Loading data into Table: ${PROJECT}.promotion"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.promotion gs://${GS_BASE}/promotion* \
p_promo_sk:integer,\
p_promo_id:string,\
p_start_date_sk:integer,\
p_end_date_sk:integer,\
p_item_sk:integer,\
p_cost:float,\
p_response_target:integer,\
p_promo_name:string,\
p_channel_dmail:string,\
p_channel_email:string,\
p_channel_catalog:string,\
p_channel_tv:string,\
p_channel_radio:string,\
p_channel_press:string,\
p_channel_event:string,\
p_channel_demo:string,\
p_channel_details:string,\
p_purpose:string,\
p_discount_active:string

echo -e "${GREEN} Loading data into Table: ${PROJECT}.reason"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.reason gs://${GS_BASE}/reason* \
r_reason_sk:integer,\
r_reason_id:string,\
r_reason_desc:string

echo -e "${GREEN} Loading data into Table: ${PROJECT}.ship_mode"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.ship_mode gs://${GS_BASE}/ship_mode* \
sm_ship_mode_sk:integer,\
sm_ship_mode_id:string,\
sm_type:string,\
sm_code:string,\
sm_carrier:string,\
sm_contract:string

echo -e "${GREEN} Loading data into Table: ${PROJECT}.store_returns"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.store_returns gs://${GS_BASE}/store_returns* \
sr_returned_date_sk:integer,\
sr_return_time_sk:integer,\
sr_item_sk:integer,\
sr_customer_sk:integer,\
sr_cdemo_sk:integer,\
sr_hdemo_sk:integer,\
sr_addr_sk:integer,\
sr_store_sk:integer,\
sr_reason_sk:integer,\
sr_ticket_number:integer,\
sr_return_quantity:integer,\
sr_return_amt:float,\
sr_return_tax:float,\
sr_return_amt_inc_tax:float,\
sr_fee:float,\
sr_return_ship_cost:float,\
sr_refunded_cash:float,\
sr_reversed_charge:float,\
sr_store_credit:float,\
sr_net_loss:float

echo -e "${GREEN} Loading data into Table: ${PROJECT}.store_sales"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.store_sales gs://${GS_BASE}/store_sales* \
ss_sold_date_sk:integer,\
ss_sold_time_sk:integer,\
ss_item_sk:integer,\
ss_customer_sk:integer,\
ss_cdemo_sk:integer,\
ss_hdemo_sk:integer,\
ss_addr_sk:integer,\
ss_store_sk:integer,\
ss_promo_sk:integer,\
ss_ticket_number:integer,\
ss_quantity:integer,\
ss_wholesale_cost:float,\
ss_list_price:float,\
ss_sales_price:float,\
ss_ext_discount_amt:float,\
ss_ext_sales_price:float,\
ss_ext_wholesale_cost:float,\
ss_ext_list_price:float,\
ss_ext_tax:float,\
ss_coupon_amt:float,\
ss_net_paid:float,\
ss_net_paid_inc_tax:float,\
ss_net_profit:float

echo -e "${GREEN} Loading data into Table: ${PROJECT}.store"

### File name was renamed to tr_store_*.dat for the ease of loading
bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.store gs://${GS_BASE}/tr_store_*.dat \
s_store_sk:integer,\
s_store_id:string,\
s_rec_start_date:string,\
s_rec_end_date:string,\
s_closed_date_sk:integer,\
s_store_name:string,\
s_number_employees:integer,\
s_floor_space:integer,\
s_hours:string,\
s_manager:string,\
s_market_id:integer,\
s_geography_class:string,\
s_market_desc:string,\
s_market_manager:string,\
s_division_id:integer,\
s_division_name:string,\
s_company_id:integer,\
s_company_name:string,\
s_street_number:string,\
s_street_name:string,\
s_street_type:string,\
s_suite_number:string,\
s_city:string,\
s_county:string,\
s_state:string,\
s_zip:string,\
s_country:string,\
s_gmt_offset:float,\
s_tax_precentage:float

echo -e "${GREEN} Loading data into Table: ${PROJECT}.time_dim"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.time_dim gs://${GS_BASE}/time_dim* \
t_time_sk:integer,\
t_time_id:string,\
t_time:integer,\
t_hour:integer,\
t_minute:integer,\
t_second:integer,\
t_am_pm:string,\
t_shift:string,\
t_sub_shift:string,\
t_meal_time:string

echo -e "${GREEN} Loading data into Table: ${PROJECT}.warehouse"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.warehouse gs://${GS_BASE}/warehouse* \
w_warehouse_sk:integer,\
w_warehouse_id:string,\
w_warehouse_name:string,\
w_warehouse_sq_ft:integer,\
w_street_number:string,\
w_street_name:string,\
w_street_type:string,\
w_suite_number:string,\
w_city:string,\
w_county:string,\
w_state:string,\
w_zip:string,\
w_country:string,\
w_gmt_offset:float

echo -e "${GREEN} Loading data into Table: ${PROJECT}.web_page"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.web_page gs://${GS_BASE}/web_page* \
wp_web_page_sk:integer,\
wp_web_page_id:string,\
wp_rec_start_date:string,\
wp_rec_end_date:string,\
wp_creation_date_sk:integer,\
wp_access_date_sk:integer,\
wp_autogen_flag:string,\
wp_customer_sk:integer,\
wp_url:string,\
wp_type:string,\
wp_char_count:integer,\
wp_link_count:integer,\
wp_image_count:integer,\
wp_max_ad_count:integer

echo -e "${GREEN} Loading data into Table: ${PROJECT}.web_returns"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.web_returns gs://${GS_BASE}/web_returns* \
wr_returned_date_sk:integer,\
wr_returned_time_sk:integer,\
wr_item_sk:integer,\
wr_refunded_customer_sk:integer,\
wr_refunded_cdemo_sk:integer,\
wr_refunded_hdemo_sk:integer,\
wr_refunded_addr_sk:integer,\
wr_returning_customer_sk:integer,\
wr_returning_cdemo_sk:integer,\
wr_returning_hdemo_sk:integer,\
wr_returning_addr_sk:integer,\
wr_web_page_sk:integer,\
wr_reason_sk:integer,\
wr_order_number:integer,\
wr_return_quantity:integer,\
wr_return_amt:float,\
wr_return_tax:float,\
wr_return_amt_inc_tax:float,\
wr_fee:float,\
wr_return_ship_cost:float,\
wr_refunded_cash:float,\
wr_reversed_charge:float,\
wr_account_credit:float,\
wr_net_loss:float

echo -e "${GREEN} Loading data into Table: ${PROJECT}.web_sales"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.web_sales gs://${GS_BASE}/web_sales* \
ws_sold_date_sk:integer,\
ws_sold_time_sk:integer,\
ws_ship_date_sk:integer,\
ws_item_sk:integer,\
ws_bill_customer_sk:integer,\
ws_bill_cdemo_sk:integer,\
ws_bill_hdemo_sk:integer,\
ws_bill_addr_sk:integer,\
ws_ship_customer_sk:integer,\
ws_ship_cdemo_sk:integer,\
ws_ship_hdemo_sk:integer,\
ws_ship_addr_sk:integer,\
ws_web_page_sk:integer,\
ws_web_site_sk:integer,\
ws_ship_mode_sk:integer,\
ws_warehouse_sk:integer,\
ws_promo_sk:integer,\
ws_order_number:integer,\
ws_quantity:integer,\
ws_wholesale_cost:float,\
ws_list_price:float,\
ws_sales_price:float,\
ws_ext_discount_amt:float,\
ws_ext_sales_price:float,\
ws_ext_wholesale_cost:float,\
ws_ext_list_price:float,\
ws_ext_tax:float,\
ws_coupon_amt:float,\
ws_ext_ship_cost:float,\
ws_net_paid:float,\
ws_net_paid_inc_tax:float,\
ws_net_paid_inc_ship:float,\
ws_net_paid_inc_ship_tax:float,\
ws_net_profit:float

echo -e "${GREEN} Loading data into Table: ${PROJECT}.web_site"

bq load --field_delimiter '|' --null_marker '' --ignore_unknown_values --project_id ${LOCATION} ${PROJECT}.web_site gs://${GS_BASE}/web_site* \
web_site_sk:integer,\
web_site_id:string,\
web_rec_start_date:string,\
web_rec_end_date:string,\
web_name:string,\
web_open_date_sk:integer,\
web_close_date_sk:integer,\
web_class:string,\
web_manager:string,\
web_mkt_id:integer,\
web_mkt_class:string,\
web_mkt_desc:string,\
web_market_manager:string,\
web_company_id:integer,\
web_company_name:string,\
web_street_number:string,\
web_street_name:string,\
web_street_type:string,\
web_suite_number:string,\
web_city:string,\
web_county:string,\
web_state:string,\
web_zip:string,\
web_country:string,\
web_gmt_offset:float,\
web_tax_percentage:float
