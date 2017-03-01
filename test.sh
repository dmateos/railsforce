ID=2
for i in {1..100} 
do
  NUM=$(( ( RANDOM % 10 )  + 1 ));
  curl -H "Content-Type: application/json" -X POST -d "{\"id\": $ID, \"data_sequence\" : { \"data\":\"12839083,$NUM\"} }" http://localhost:3000/api/v1/data_sequences
  sleep 0.5
done
