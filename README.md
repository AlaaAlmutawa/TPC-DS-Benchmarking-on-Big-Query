# TPC-DS-Benchmarking-on-Big-Query
TPC-DS Benchmarking on Big Query 

### Steps: 

1. Move the compiled dsdgen.exe to your desired directory or Google Compute Engine instance

2. Clone the repository into the same 

2.a. If dsdgen will be run from Google Compute Engine: Mount [Google Bucket](https://cloud.google.com/storage/docs/gcs-fuse) into {DATA_DIR}

3. Run dsdgen with $SCALE 

4. Run load_data.sh

4.a. Local machine: make sure that you specify the {DATA_DIR}

4.b. Google Compute Engine: make sure that you specify {DATA_DIR} created on GCS

./load_data.sh $SCALE 

5. For Throughput test: Run benchmark.sh  

6. For Powertest: Run benchmark_powertest.sh

####Credits: 

scripts have been referenced from the below sources and were adjusted to be used in our particular usecase/environment. 
The below sources provided us with ability to understand the required syntactical changes for some queries. 

[TPC - DS - Big Query](https://github.com/snithish/tpc-ds_big-query)

[Fivetran DW Benchmark](https://github.com/fivetran/benchmark)

[Reproducing TPC-DS Qualification Results](https://github.com/cwida/tpcds-result-reproduction)







