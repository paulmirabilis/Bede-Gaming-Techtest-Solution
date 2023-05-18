# Bede-Gaming-Techtest-Solution

#Setup

`` Initial setup ``

```bash

1. helm create sre-techtask

2. In the sre-techtask helm chart directory that was generated in by helm create, update the values.yaml file. Specifically, update replicaCount, image repository, image tag and service port. Also enable ingress and set hosts to dadjokes.local.

Note: From the dockerhub page of the container image, i noticed that the non-https port that the service should expose is 8100, so I used it in the values.yaml file.


3. In the project's parent directory, create a namespace.yaml file with the following content:

apiVersion: v1
kind: Namespace
metadata:
  name: sre-techtask
  

 
4. In the same parent directory, create a Makefile with the following content:

.PHONY: deploy-dadjokes verify-dadjokes

deploy-dadjokes:
	kubectl apply -f namespace.yaml 
	helm install sre-techtask ./sre-techtask -n sre-techtask

verify-dadjokes:
	@echo "Verifying deployment..."
	kubectl get pods -n sre-techtask
	kubectl get svc -n sre-techtask
	kubectl get ingress -n sre-techtask
	curl http://dadjokes.local


5. adebayo@adebayo-VirtualBox:~/Bede-Gaming-Techtest-Solution$ ls -la
total 28
drwxrwxr-x  4 adebayo adebayo 4096 May 18 18:04 .
drwxr-x--- 27 adebayo adebayo 4096 May 18 18:07 ..
drwxrwxr-x  8 adebayo adebayo 4096 May 18 14:14 .git
-rw-rw-r--  1 adebayo adebayo  334 May 18 18:04 Makefile
-rw-rw-r--  1 adebayo adebayo   62 May 18 18:01 namespace.yaml
-rw-rw-r--  1 adebayo adebayo   31 May 18 14:14 README.md
drwxr-xr-x  4 adebayo adebayo 4096 May 18 17:44 sre-techtask


```

# Validation


Step 1:

`` make deploy-dadjokes ``

#Output

```bash 

adebayo@adebayo-VirtualBox:~/Bede-Gaming-Techtest-Solution$ make deploy-dadjokes
kubectl apply -f namespace.yaml 
namespace/sre-techtask created
helm install sre-techtask ./sre-techtask -n sre-techtask
NAME: sre-techtask
LAST DEPLOYED: Thu May 18 18:08:50 2023
NAMESPACE: sre-techtask
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  http://dadjokes.local/


```


Step2:

`` make verify-dadjokes `` 

```bash

##Output

adebayo@adebayo-VirtualBox:~/Bede-Gaming-Techtest-Solution$ make verify-dadjokes
Verifying deployment...
kubectl get pods -n sre-techtask
NAME                            READY   STATUS    RESTARTS   AGE
sre-techtask-5c9cb688b4-5pwfh   1/1     Running   0          27s
sre-techtask-5c9cb688b4-c5tq4   1/1     Running   0          27s
sre-techtask-5c9cb688b4-gql2s   1/1     Running   0          27s
kubectl get svc -n sre-techtask
NAME           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
sre-techtask   ClusterIP   10.96.49.230   <none>        8100/TCP   28s
kubectl get ingress -n sre-techtask
NAME           CLASS   HOSTS            ADDRESS        PORTS   AGE
sre-techtask   nginx   dadjokes.local   192.168.49.2   80      28s
curl http://dadjokes.local
{"Joke":{"Opener":"I know a lot of jokes about retired people","Punchline":"but none of them work.","Processing Time":"0.000545"},"RequestEcho":{"Headers":{"Host":"dadjokes.local","X-Request-ID":"a47587d3361206ac921e0f5c52d23efa","X-Real-IP":"192.168.49.1","X-Forwarded-For":"192.168.49.1","X-Forwarded-Host":"dadjokes.local","X-Forwarded-Port":"80","X-Forwarded-Proto":"http","X-Forwarded-Scheme":"http","X-Scheme":"http","User-Agent":"curl/7.81.0","Accept":"*/*"},"Method":"GET","Origin":"10.244.0.13","URI":"/","Arguments":[],"Data":"","URL":"http://dadjokes.local/"},"DadJokesInfo":{"SourceCode":"https://github.com/yesinteractive/dadjokes","Version":"20211111"}}adebayo@adebayo-VirtualBox:~/Bede-Gaming-Techtest-Solution$ 


```

