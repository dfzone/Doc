# jar通过windows服务的方式启动
1. 选择适合的版本，下载[WinSW](https://github.com/winsw/winsw/releases)
2. 将下载的文件重命名，跟jar包名称相同
3. 在相同目录下创建配置jar包名称相同的配置文件，配置文件内容如下：
```
<service>
    <!-- 服务标识 -->
    <id>HelloWorld</id>
    <!-- 服务名称 -->
    <name>HelloWorld</name>
    <!-- 服务描述 -->
    <description>This is a HelloWorld</description>
    <!-- java环境变量 -->
    <env name="JAVA_HOME" value="%JAVA_HOME%"/>
    <executable>java</executable>
    <arguments>-jar HelloWorld.jar</arguments>
    <!-- 开机启动 -->
    <startmode>Automatic</startmode>
    <!-- 日志配置 -->
    <logpath>%BASE%\log</logpath>
    <!--
    Defines logging mode for logs produced by the executable.
    Supported modes:
      * append - Rust update the existing log
      * none - Do not save executable logs to the disk
      * reset - Wipe the log files on startup
      * roll - Roll logs based on size
      * roll-by-time - Roll logs based on time
      * rotate - Rotate logs based on size, (8 logs, 10MB each). This mode is deprecated, use "roll"
    Default mode: append
    -->
    <logmode>rotate</logmode>

 </service>

``` 
4. 安装服务。以管理员运行cmd进入jar所在的目录，然后执行HelloWorld.exe install