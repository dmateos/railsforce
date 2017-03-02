ID=1
for i in {1..10000} 
do
  NUM=$(( ( RANDOM % 10 )  + 1 ));
  #LOAD=$(cut -d ' ' -f 1 < /proc/loadavg)
  curl -H "Content-Type: application/json" -X POST -d "{\"id\": $ID, \"data_sequence\" : { \"data\":\"12839083,$NUM\"} }" http://localhost:3000/api/v1/data_sequences
  sleep 0.5
done
