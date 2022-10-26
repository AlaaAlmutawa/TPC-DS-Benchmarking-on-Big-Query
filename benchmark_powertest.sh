#!/bin/bash
##usage ./benchmark_powertest.sh <dataset_name> <dataset_location>

export PROJECT=test-project-364309
export DATASET=$1
export LOCATION=$2

rounds="${3:-5}"

run() {

  round=$1

  mkdir -p json_bq_result_per_query
  mkdir -p results


    find powertest/ -name queries.sql | sort -V | {
      read -r f
      echo $f
      QUERY='queries'
      echo ${QUERY}

      QUERYSTAT="$QUERY,"

      for (( n=1; n<=$round; n++ ))
      do

        ID=${QUERY}_$(date +%s)
        cat "$f" \
          | bq \
            --project_id=${PROJECT} \
            --dataset_id=${DATASET} \
            query \
            --use_cache=false \
            --nouse_cache\
            --use_legacy_sql=false \
            --format=none\
            --job_id=$ID \
            --max_statement_results=150\
            --batch=false 

        JB_ID=${PROJECT}:${LOCATION}.${ID}

        JOB=$(bq show --format=prettyjson -j ${JB_ID})

        echo $JOB >> json_bq_result_per_query/result_${QUERY}_powertest.json

        STARTED=$(echo $JOB| sed 's/$/\\n/' | tr -d '\n' | sed -e 's/“/"/g' -e 's/”/"/g' | sed '$ s/\\n$//' | jq .statistics.startTime | tr -d '"')
        ENDED=$(echo $JOB| sed 's/$/\\n/' | tr -d '\n' | sed -e 's/“/"/g' -e 's/”/"/g' | sed '$ s/\\n$//' |jq .statistics.endTime | tr -d '"')
        DURATION=$(($ENDED - $STARTED))

        echo "------------ROUND $n------------"
        echo "Started Time = $STARTED"
        echo "Ended Time = $ENDED"
        echo "Duration = $DURATION ms"
        echo ""

        if [[ $n == $round ]] 
        then 
          QUERYSTAT+="$DURATION" 
        else 
          QUERYSTAT+="$DURATION," 
        fi
      
      done

      echo $QUERYSTAT >> results/BigQueryResults_powertest.csv
    }
}

run $rounds






