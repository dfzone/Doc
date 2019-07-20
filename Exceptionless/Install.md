# 安装 Exceptionless

## 安装前准备
1. 下载jdk并安装
1. 下载ES ：https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.2.zip
1. 下载Exceptionless：https://github.com/exceptionless/Exceptionless/releases   Exceptionless.4.1.2861.zip

## 安装 elasticsearch 到 win 服务
``` bash
# 进入到 elasticsearch 的 bin 目录
elasticsearch-service.bat install
```

## 验证elasticsearch是否正常
1. 打开windows服务确保elasticsearch的服务已经运行
1. 访问http://127.0.0.1:9200 查看是否正常

## 部署Exceptionless站点
1. IIS中创建网站，指定到Exceptionless下的wwwroot文件夹
2. 修改配置文件如下

## 初始化设置
```bash
# Web.config
#设置 BASE_URL 为 exceptionles 的域名  最后必须带 `/#`
例：<add key="BaseURL" value="http://exceptionless.tapp.tjise.edu.cn/#!" />

#设置 ElasticSearchConnectionString 为您配置的 es 接口地址
例：<add name="ElasticSearchConnectionString" connectionString="http://127.0.0.1:9200" />

# app.config.**.js
设置 BASE_URL 为 exceptionles 的域名
例：.constant('BASE_URL', 'http://exceptionless.tapp.tjise.edu.cn')
```

## 邮箱设置
```xml

<add key="SmtpHost" value="smtp.exmail.qq.com" />
<add key="SmtpPort" value="465" />
<add key="SmtpEncryption" value="SSL" />
<add key="SmtpUser" value="xxx@samsundot.com" />
<add key="SmtpPassword" value="xxx" />
<add key="SmtpFrom" value="xxx@samsundot.com" />
   

```

## 日志配置设置
```xml
    <!--保留日志天数 -->
    <add key="MaximumRetentionDays" value="90" />
    <!--分片数量-->
    <add key="ElasticSearchNumberOfShards" value="3" /> 
    <!--复制分片数量-->
    <add key="ElasticSearchNumberOfReplicas" value="1" />
```