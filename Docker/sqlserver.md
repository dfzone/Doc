> docker运行redis命令：
```
docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=12345678' --restart always --name mysqlserver -p 1433:1433 -v /data/sqlserver/db:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2017-latest
```

> sqlserver要求内存比较高，宿主机内存低于3.5G貌似不能运行  

> 命令说明：
1. -p 1433:1433 :将容器的1433 端口映射到主机的1433端口
1. -v /data/sqlserver/db:/var/opt/mssql/data/db/ :将主机中/data/sqlserver/db挂载到容器的/var/opt/mssql/data/db/，作为sqlserver数据存储目录
1. -d mcr.microsoft.com/mssql/server:2017-latest  获取2017最新版
1. -e 'ACCEPT_EULA=Y' 接受协议
1. -e 'MSSQL_SA_PASSWORD=12345678' 设置sa的密码
1. --restart always 在容器退出时总是重启容器

> restart参数说明:
* Docker容器的重启策略 
* no，默认策略，在容器退出时不重启容器
* on-failure，在容器非正常退出时（退出状态非0），才会重启容器
* on-failure:3，在容器非正常退出时重启容器，最多重启3次
* always，在容器退出时总是重启容器
* unless-stopped，在容器退出时总是重启容器，但是不考虑在Docker守护进程启动时就已经停止了的容器