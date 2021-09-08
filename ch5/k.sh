#!/usr/bin/env sh

#execute a command in pod to test service
#"--" represents the end of kubectl command and the rest part is command need to be executed in pod
kubectl exec kubia-named-ports -- curl -s http://10.104.147.41

#serivce is not linked to pod directory,there is endpoint between them
#if service contains label selector,endpoints will be created automatically
kubectl get endpoints kubia

#the service host and port are set in environment variables
#use kubectl exec to show environment variables in container
kubectl exec kubia-named-ports env
