#!/bin/bash

export PROJECT=test-project-364309
export DATASET=$1

rounds="${2:-5}"

run() {

  round=$1

  mkdir -p  json_bq_result_per_query
  mkdir -p results

  find query/ -name query*.sql | sort -V | {

    while read -r f; do

        # echo $f
        QUERY=`basename $f | head -c -5`
        echo ${QUERY^}

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
              --use_legacy_sql=false \
              --format=none\
              --job_id=$ID \
              --batch=false 

          JB_ID=${PROJECT}:US.${ID}

          JOB=$(bq show --format=prettyjson -j ${JB_ID})

          echo $JOB >> json_bq_result_per_query/result_${QUERY}.json

          STARTED=$(echo $JOB| sed 's/$/\\n/' | tr -d '\n' | sed -e 's/“/"/g' -e 's/”/"/g' | sed '$ s/\\n$//' | jq .statistics.startTime | tr -d '"')
	  echo "$STARTED"
          ENDED=$(echo $JOB| sed 's/$/\\n/' | tr -d '\n' | sed -e 's/“/"/g' -e 's/”/"/g' | sed '$ s/\\n$//' |jq .statistics.endTime | tr -d '"')
	  echo "$ENDED"
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

        echo $QUERYSTAT >> results/BigQueryResults.csv
    done
  }
}

run $rounds







