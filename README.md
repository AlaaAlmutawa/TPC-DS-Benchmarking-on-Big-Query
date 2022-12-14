# TPC-DS Benchmarking on Google BigQuery
TPC-DS Benchmarking on Big Query 

### Steps: 

1. Move the compiled dsdgen.exe to your desired directory or Google Compute Engine instance

2. Clone the repository into the same 

2.a. Google Compute Engine: Mount [Google Bucket](https://cloud.google.com/storage/docs/gcs-fuse) into `DATA_DIR`

3. Run `dsdgen` 

`./dsdgen <scale>`

4. Run `load_data.sh`

4.a. Local machine: make sure that you specify the `DATA_DIR` 

4.b. Google Compute Engine: make sure that you specify `DATA_DIR` created on GCS

`./load_data.sh <scale> <project-id>`

5. For Throughput test: Run `benchmark.sh` 

`./benchmark.sh <dataset>`

6. For Powertest: Run `benchmark_powertest.sh`

`./benchmark_powertest.sh <dataset> <dataset_location>`

#### Credits: 

scripts have been referenced from the below sources and were adjusted to be used in our particular usecase/environment. 
The below sources provided us with ability to understand the required syntactical changes for some queries. 

[TPC - DS - Big Query](https://github.com/snithish/tpc-ds_big-query)

[Fivetran DW Benchmark](https://github.com/fivetran/benchmark)

[Reproducing TPC-DS Qualification Results](https://github.com/cwida/tpcds-result-reproduction)

##### This is a group project apart of INFO-H419: Data Warehouse course at ULB and was completed by: Koumudi, Adina, Zyad, Alaa 







