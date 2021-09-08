#!/usr/bin/env sh

#create a replication controller directly
kubectl run kubia --image=zjjfly/kubia:1.0 --port=8080 --generator=run/v1

#create a loadbalancer for replication controller
kubectl expose rc kubia --type=LoadBalancer --name kubia-http

#scale a replication controller to increase the number of pods
kubectl scale rc kubia --replicas=3

#get resources with some addtional columns
kubectl get pods -o wide

#setup dashboard
curl https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml -o dashboard.yaml
#apply yaml
kubectl apply -f dashboard.yaml
#expose dashboard to public
#edit service,change type from ClusterIP to NodePort
kubectl edit service kubernetes-dashboard -n kubernetes-dashboard
#get service port
kubectl -n kubernetes-dashboard get service kubernetes-dashboard
#access the dashboard in browser by localhost:port(this port is from previous command)
#chrome will prevent you from access the login page,just type "thisisunsafe" on page,see https://blog.51cto.com/mapengfei/2476429
#get dashboard login token,the secret name is just a example
kubectl describe secret kubernetes-dashboard-token-gkwtk --namespace=kubernetes-dashboard
