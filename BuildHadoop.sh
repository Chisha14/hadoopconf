#bin/bash

kubectl run hadoop-nn --image=hash14/mynn --port=50070 --replicas=1

kubectl run hadoop-sl --image=hash14/myhadoopslaves --replicas=1

getPods="$(exec kubectl get pods)"

echo "Pods" $getPods
master="hadoop-nn"
workers=()
IPs=()
for word in $getPods
do
    echo $word
    if [[ $word == hadoop-nn* ]] ; 
    then
	master=$word
	echo $master
    elif [[ $word == hadoop-sl* ]] ;
    then
	workers+=("$word") 
    fi
done

echo "Supervisors " ${workers[@]}

for ip in ${workers[@]}
do
	IPs+=("$(kubectl describe pod $ip | grep IP | sed -E 's/IP:[[:space:]]+//')")
done
echo $IPs
kubectl exec -it $workers ls



#kubectl describe pod $superVisors | grep IP | sed -E 's/IP:[[:space:]]+//'

#if [ $HOST == user* ]
 #then

#fi
