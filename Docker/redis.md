> docker运行redis命令：
```
docker run -p 6379:6379 -v /data/redis/data:/data --restart always --name myredis -d redis:4.0.14 redis-server --appendonly yes 
```

> 命令说明：
1. redis:4.0.14: redis版本号：4.0.14
1. -p 6379:6379 : 将容器的6379端口映射到主机的6379端口
1. -v /data/redis/data:/data : 将主机中/data/redis/data 挂载到容器的/data
1. redis-server --appendonly yes : 在容器执行redis-server启动命令，并打开redis持久化配置