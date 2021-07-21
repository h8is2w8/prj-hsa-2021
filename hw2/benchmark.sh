echo "Starting GET posts benchmark"
ab -c 10 -n 2000 http://localhost:8080/posts

echo "Starting POST logs benchmark"
ab -p log.json -T application/json -c 10 -n 2000 http://localhost:8080/logs
