#!/usr/bin/env sh

#get logs of the previous pod
kubectl logs kubia-liveness --previous

#change pod's selector label to retire from replication controller
kubectl label po kubia-f78wm app=foo --overwrite

#edit pod template of replication controller
#this will not change the pods already exist,any pod created later will use new template
kubectl edit rc kubia

#just delete replication controller,not related pod
kubectl delete rc kubia --cascade=false

#replica set can match labels have same key and different value or just have same key
kubectl create -f kubia-replicaset-matchexpressions.yaml

#daemon set is similar to replica set,but it will deployed to every node which match the node selector
#it will be also deployed on the node which is not deployable

#job used to run temporary job,when the job finished,the pod's status become "Completed"
#job can scale parallel count like replication controller
kubectl scale job mutli-completion-parallel-batch-job --replicas 3
