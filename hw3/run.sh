docker build -t hw3 .
docker run -dp 9292:9292 hw3
ab -c 10 -n 1000 http://localhost:9292/
