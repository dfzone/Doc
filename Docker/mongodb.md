docker运行mongodb命令：
```
docker run -p 27017:27017 -v /data/mongodb/db:/data/db --restart always --name mymongodb -d mongo:3.6.13 --auth --directoryperdb
```

> 命令说明：
1. -p 27017:27017 :将容器的27017 端口映射到主机的27017 端口
1. -v /data/mongodb/db:/data/db :将主机中/data/mongodb/db挂载到容器的/data/db，作为mongo数据存储目录
1. -d mongo:3.6.13 运行容器 --auth 启动验证 -directoryperdb 目录方式存储


> 添加用户  
```
use admin
db.createUser( {user: "root",pwd: "root",roles: [ { role: "root", db: "admin" } ]})
db.createUser( {user: "edudot",pwd: "abcd-1234",roles: [ { role: "dbAdmin", db: "edudot" } ]})
```
> 用户角色
1. 数据库用户角色：read、readWrite;
1. 数据库管理角色：dbAdmin、dbOwner、userAdmin
1. 集群管理角色：clusterAdmin、clusterManager、clusterMonitor、hostManager
1. 备份恢复角色：backup、restore
1. 所有数据库角色：readAnyDatabase、readWriteAnyDatabase、userAdminAnyDatabase、dbAdminAnyDatabase
1. 超级用户角色：root

> 更新用户
```
db.updateUser("edudot",{ roles: [{ role: "dbOwner", db: "edudot" },{ role: "readWrite", db: "edudot" }]})
use admin  
db.auth("用户名","密码")
```

> 修改密码
```
use dbName
db.changeUserPassword('dbName','dbPassword');
```

> 退出用户
```
db.logout();
```

> 删除用户
```
db.dropUser("test1");
```
> 链接信息查询
```
db.serverStatus().connections;
```

> 关闭服务
```
use admin;
db.shutdownServer();
```
> 备份数据库
```  
mongodump -h 127.0.0.1:7003 -u edudot_noticepush -p 1234  -d edudot_noticepush -o /data/backup/ 
mongodump -h 127.0.0.1:27017 -u edudot -p 1234  -d edudot -o /data/backup/ 
```

> 恢复数据库  
```
mongorestore -h 127.0.0.1:7003 -uroot -proot --authenticationDatabase admin -d test /home/mongod/backup/test/

mongorestore -h 127.0.0.1:27017 -uroot -proot --authenticationDatabase admin -d edudot /data/db/backup/edudot 

mongorestore -h 127.0.0.1:27017 -d edudot /data/db/backup/edudot
``


