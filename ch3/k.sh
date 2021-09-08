#!/usr/bin/env sh

#explain fields of resource manifest
kubectl explain pods

#explain options of specified resource field in manifest
kubectl explain pod.spec

#get yaml of resource
kubectl get pod kubia-manual -o yaml

#get logs of container
kubectl logs kubia-manual -c kubia

#port forward,this can forward requests from local port to pod port
kubectl port-forward kubia-manual 8888:8080

#get resources with a labels column
kubectl get pods --show-labels

#get resources with separate column for every specified label
kubectl get po -L creation_method,env

#add label
kubectl label po kubia-manual creation_method=manual

#update label
kubectl label po kubia-manual-v2 env=debug --overwrite

#filter resource whose labels with specified key-value pairs
kubectl get po -l creation_method=manual,env=debug

#filter resource whose labels contain specified key
kubectl get po -l env

#filter resource whose labels not contain specified key
kubectl get po -l '!env'

#filter resource whose labels with specified key but its value is not specfied value
kubectl get po -l creation_method!=manual

#filter resource whose labels with specified key and its value is in or not in some specified options
kubectl get po -l 'env in (prod,devel)'
kubectl get po -l 'env notin (prod,devel)'

#schedule specified pod to node with specified features
#label node
kubectl label no docker-desktop gpu=true
#add nodeSelector in spec field

#add annotation to resource,the key is prefixed by a domain name to avoid name confliction
kubectl annotate pod kubia-manual mycompany.com/someannotation="foo bar"

#get resources in specified namespace
kubectl get po -n kube-system

#create namespace
kubectl create ns custom-namespace

#switch namespace
kubectl config set-context $(kubectl config current-context) --namespace custom-namespace

#delete resources whose labels contain specified key
kubectl delete po -l creation_method=manual

#delete all pods in current namespace
kubectl delete po --all

#delete all resources (except some cretical resources) in current namespace
kubectl delete all --all
