> docker运行mysql命令：
```
docker run -p 3306:3306 --name mymysql  -v /data/mysql/db:/var/lib/mysql -v /data/mysql/conf:/etc/mysql -v /data/mysql/logs:/var/log/mysql -e MYSQL_ROOT_PASSWORD=123 -d mysql:5.7 --character-set-server=utf8 --collation_server=utf8_general_ci --lower_case_table_names=1
```

> 命令说明：
1. -p 3306:3306 端口映射
1. --name mymysql 容器名称
1. -v /data/mysql/db:/var/lib/mysql 主机映射到容器目录
1. -e MYSQL_ROOT_PASSWORD=123 roo的密码
1. -d mysql:5.7 后台运行并指定镜像版本 
    1. --character-set-server=utf8 指定字符集 
    1. --collation_server=utf8_general_ci 排序规则 
    1. --lower_case_table_names=1 大小写忽略

> 管理mysql
```
mysql -uname -pPWD
create user 'edudot'@'localhost' identified by '1234';
grant all privileges on `edudot_spider`.* to 'edudot'@'localhost' identified by '1234' with grant option;
grant all privileges on `edudot_spider`.* to 'edudot'@'%' identified by '1234' with grant option;
grant all privileges on `edudot_admin`.* to 'edudot'@'%' identified by '1234' with grant option;
flush privileges;
```