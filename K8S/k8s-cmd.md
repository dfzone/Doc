> 命令式API、

> 声明式API  
Deployment\ReplicaSet\Service

> 获取pods  
```
 kubectl get pods
 kubectl get pods --show-labels
 kubectl get pods podName -o yaml | less
 kubectl get pods --show-labels -l env=dev
 kubectl get pods --show-labels -l env=dev,app=myapp
 kubectl get pods --show-labels -l 'env in (dev,test)'
```

> 操作标签
```
//覆盖标签
kubectl lable pods podName lableKey=lableValue --overwrite
kubectl lable pods nginx env=dev --overwrite

//删除标签
kubectl lable pods podName lableKey-
kubectl lable pods nginx env-
```
> 从指定文件加载pods  
```
kubectl apply -f fileName
kubectl apply -f pod1.yaml
```

> deployment
```
kubectl create -f nginx-deployment.yaml
kubectl get deployment
```
通过deployment创建的pod命名格式：
${deployment-name}-${template-hash}-${random-suffix}


DESIRED:期望pod数量
CURRENT:当前实际pod数量
UP-TO-DATE:达到期望版本pod数量
AVAILABLE:运行中并可用的pod数量
AGE:deployment创建的时长

> pod生命周期  
## 初始化容器（init container）
initContainers
## 运行主容器（main container）
1. lifecycle:启动之后:post start hook
2. 存活状态探测(livenessProbe)、就绪状态探测(readinessProbe)
3. lifecycle:停止之前：per stop hook