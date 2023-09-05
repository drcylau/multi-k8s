docker build -t drcylau/multi-client-k8s:latest -t drcylau/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t drcylau/multi-server-k8s:latest -t drcylau/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t drcylau/multi-worker-k8s:latest -t drcylau/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push drcylau/multi-client-k8s:latest
docker push drcylau/multi-server-k8s:latest
docker push drcylau/multi-worker-k8s:latest

docker push drcylau/multi-client-k8s:$SHA
docker push drcylau/multi-server-k8s:$SHA
docker push drcylau/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=drcylau/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=drcylau/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=drcylau/multi-worker-k8s:$SHA