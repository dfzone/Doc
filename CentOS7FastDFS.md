#下载相关软件
FastDFS作者GitHub地址：https://github.com/happyfish100

1、libfastcommon
https://github.com/happyfish100/libfastcommon/releases
2、fastdfs
https://github.com/happyfish100/fastdfs/releases
3、fastdfs-nginx-module
https://github.com/happyfish100/fastdfs-nginx-module/releases
4、nginx
https://nginx.org/download/

#本次安装使用的版本
1、libfastcommon-1.0.36.tar
2、fastdfs-5.11.tar.gz
3、fastdfs-nginx-module-1.20.tar.gz
4、nginx-1.12.0.tar.gz

#安装软件
一、安装libfastcommon-1.0.36.tar
1、解压文件
tar zxf libfastcommon-1.0.36.tar.gz  
2、进入文件目录 
cd libfastcommon-1.0.36
3、编译 
./make.sh
4、编译安装
./make.sh install

注意：
编译时，需要gcc的支持，如果是最小化安装的系统，gcc默认不安装，当编译时候报错，提示：gcc: 未找到命令。此时需要自己安装gcc
安装方式：
yum -y install gcc-c++

libfastcommon默认会被安装到/usr/lib64/libfastcommon.so，但是FastDFS的主程序却在/usr/local/lib目录下 
这个时候我们就要建立一个软链接了，实际上也相当于windows上的快捷方式
ln -s /usr/lib64/libfastcommon.so /usr/local/lib/libfastcommon.so
ln -s /usr/lib64/libfastcommon.so /usr/lib/libfastcommon.so
ln -s /usr/lib64/libfdfsclient.so /usr/local/lib/libfdfsclient.so
ln -s /usr/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so

二、安装fastdfs-5.11.tar.gz
1、解压文件 
tar zxf fastdfs-5.11.tar.gz 
2、进入文件目录
cd fastdfs-5.11
3、编译 
./make.sh
4、编译安装
./make.sh install

如果没有报错，进入/etc/fdfs/目录下查看
[root@localhost fdfs]# ll
-rw-r--r-- 1 root root  1461 Jun  8 21:56 client.conf.sample
-rw-r--r-- 1 root root  7927 Jun  8 21:56 storage.conf.sample
-rw-r--r-- 1 root root  7389 Jun  8 21:56 tracker.conf.sample

复制三个示例文件
cp client.conf.sample client.conf
cp storage.conf.sample storage.conf
cp tracker.conf.sample tracker.conf

注意：
如果没有安装perl，编译时候会报错，提示：perl: 未找到命令。需要自己安装perl运行环境
yum install perl* 
安装完毕后，重新编译还是会报错，需要执行./make.sh clean 命令。如果编译前已经安装好perl环境，则不会报错。

三、配置tracker
1、创建tracker工作目录，用来保存tracker的data和log
mkdir /data/fastdfs/tracker
2、修改tracker配置文件
cd /etc/fdfs
vi tracker.conf
重点关注如下配置：
disabled=false #默认开启 
port=22122 #默认端口号 
base_path=/usr/yong.cao/dev/fastdfs/fastdfs_tracker #我刚刚创建的目录 
http.server_port=8080 #默认端口是8080
3、启动tracker
service fdfs_trackerd start
或者
systemctl start fdfs_trackerd

成功后应该可以看到：
[root@localhost fdfs]# service fdfs_trackerd start
Starting fdfs_trackerd (via systemctl):                    [  OK  ]

进入刚刚创建的tracker目录，发现目录中多了data和log两个目录
[root@localhost fdfs]# cd /data/fastdfs/tracker
[root@localhost tracker]# ll
total 0
drwxr-xr-x 2 root root 178 Jun 16 21:19 data
drwxr-xr-x 2 root root  26 Jun 13 22:01 logs

设置tracker加入开机启动
[root@localhost tracker]# ll /etc/rc.d/rc.local
-rw-r--r-- 1 root root 501 Jun 16 21:34 /etc/rc.d/rc.local

发现并没有执行权限，需要加执行权限
chmod +x /etc/rc.d/rc.local

加完后应该是这样的：
-rwxr-xr-x 1 root root 501 Jun 16 21:34 /etc/rc.d/rc.local

修改rc.local
vi /etc/rc.d/rc.local
#!/bin/bash
# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
#
# It is highly advisable to create own systemd services or udev rules
# to run scripts during boot instead of using this file.
#
# In contrast to previous versions due to parallel execution during boot
# this script will NOT be run after all other services.
#
# Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure
# that this script will be executed during boot.

touch /var/lock/subsys/local
service fdfs_trackerd start

四、配置storage
1、创建storage工作目录
mkdir /data/fastdfs/storage

2、修改storage配置文件
cd /etc/fdfs
vi storage.conf
重点关注如下配置：
disabled=false #默认开启 
group_name=group1 #组名，根据实际情况修改 
port=23000 #设置storage的端口号，默认是23000，同一个组的storage端口号必须一致 
base_path=/data/fastdfs/storage #设置storage数据文件和日志目录 
store_path_count=1 #存储路径个数，需要和store_path个数匹配 
base_path0=/data/fastdfs/storage #实际文件存储路径 
tracker_server=192.168.128.131:22122 #服务器的ip地址 
http.server_port=8888 #设置 http 端口号

修改保存后创建软引用
ln -s /usr/bin/fdfs_storaged /usr/local/bin

启动storage
service fdfs_storaged start
或者
systemctl start fdfs_storaged

成功后应该可以看到：
[root@localhost fdfs]# service fdfs_stroaged start
Starting fdfs_storaged (via systemctl):                    [  OK  ]

设置开机启动
vi /etc/rc.d/rc.local

#!/bin/bash
# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
#
# It is highly advisable to create own systemd services or udev rules
# to run scripts during boot instead of using this file.
#
# In contrast to previous versions due to parallel execution during boot
# this script will NOT be run after all other services.
#
# Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure
# that this script will be executed during boot.

touch /var/lock/subsys/local
service fdfs_trackerd start
service fdfs_storaged start

五、校验整合，验证安装
执行如下命令：
/usr/bin/fdfs_monitor /etc/fdfs/storage.conf

[root@localhost fastdfs]# /usr/bin/fdfs_monitor /etc/fdfs/storage.conf
[2017-06-17 14:15:44] DEBUG - base_path=/usr/yong.cao/dev/fastdfs/fastdfs_storage, connect_timeout=30, network_timeout=60, tracker_server_count=1, anti_steal_token=0, anti_steal_secret_key length=0, use_connection_pool=0, g_connection_pool_max_idle_time=3600s, use_storage_id=0, storage server id count: 0
server_count=1, server_index=0
tracker server is 192.168.128.131:22122
group count: 1
Group 1:
group name = group1
disk total space = 8178 MB
disk free space = 6463 MB
trunk free space = 0 MB
storage server count = 2
active server count = 1
storage server port = 23000
storage HTTP port = 8888
store path count = 1
subdir count per path = 256
current write server index = 0
current trunk file id = 0
        Storage 1:
                id = 192.168.128.131
                ip_addr = 192.168.128.131 (localhost.localdomain)  ACTIVE
                http domain =
                version = 5.11
                join time = 2017-06-13 22:19:42
                up time = 2017-06-16 21:19:47
                total storage = 8178 MB
                free storage = 6463 MB
                upload priority = 10
                store_path_count = 1
                subdir_count_per_path = 256
                storage_port = 23000
                storage_http_port = 8888
                current_write_path = 0
                source storage id =
                if_trunk_server = 0
                connection.alloc_count = 256
                connection.current_count = 0
                connection.max_count = 1
                total_upload_count = 6
                success_upload_count = 6
                total_append_count = 0
                success_append_count = 0
                total_modify_count = 0
                success_modify_count = 0
                total_truncate_count = 0
                success_truncate_count = 0
                total_set_meta_count = 5
                success_set_meta_count = 5
                total_delete_count = 0
                success_delete_count = 0
                total_download_count = 0
                success_download_count = 0
                total_get_meta_count = 0
                success_get_meta_count = 0
                total_create_link_count = 0
                success_create_link_count = 0
                total_delete_link_count = 0
                success_delete_link_count = 0
                total_upload_bytes = 590790
                success_upload_bytes = 590790
                total_append_bytes = 0
                success_append_bytes = 0
                total_modify_bytes = 0
                success_modify_bytes = 0
                stotal_download_bytes = 0
                success_download_bytes = 0
                total_sync_in_bytes = 0
                success_sync_in_bytes = 0
                total_sync_out_bytes = 0
                success_sync_out_bytes = 0
                total_file_open_count = 6
                success_file_open_count = 6
                total_file_read_count = 0
                success_file_read_count = 0
                total_file_write_count = 6
                success_file_write_count = 6
                last_heart_beat_time = 2017-06-17 14:15:27
                last_source_update = 2017-06-16 23:34:20
                last_sync_update = 1970-01-01 08:00:00
                last_synced_timestamp = 1970-01-01 08:00:00

配置客户端：
修改客户端的配置文件
vi /etc/fdfs/client.conf

如下配置需要注意
base_path=/data/fastdfs/tracker #tracker服务器文件路径
tracker_server=192.168.128.131:22122 #tracker服务器IP地址和端口号
http.tracker_server_port=8080 # tracker 服务器的 http端口号，必须和tracker的设置对应起来

模拟上传:
确定图片位置后，我们输入上传图片命令
/usr/bin/fdfs_upload_file  /etc/fdfs/client.conf  /software/logo.jpg  #这后面放的是图片的位置

成功后会返回图片的路径：
[root@localhost ~]# /usr/bin/fdfs_upload_file  /etc/fdfs/client.conf  /software/logo.jpg
group1/M00/00/00/wKiAg1lE9WqAWu_ZAAFaL_xdW_s943.jpg

六、整合Nginx模块
在安装nginx之前要安装nginx所需的依赖lib:
yum -y install pcre pcre-devel  
yum -y install zlib zlib-devel  
yum -y install openssl openssl-devel

解压nginx,和fastdfs-nginx-module
tar xvf nginx-1.12.0.tar.gz
tar xvf fastdfs-nginx-module-1.20.tar.gz

解压后进入nginx目录编译安装nginx,并添加fastdfs-nginx-module
./configure --prefix=/usr/local/nginx --add-module=/software/fastdfs-nginx-module-1.20/src  #解压后fastdfs-nginx-module所在的位置

如果配置不报错的话，就开始编译
make
make install

此时会报错，错误信息：
/usr/local/include 
-o objs/addon/src/ngx_http_fastdfs_module.o 
/software/fastdfs-nginx-module-1.20/src/ngx_http_fastdfs_module.c
In file included from /software/fastdfs-nginx-module-1.20/src/common.c:26:0,
from /software/fastdfs-nginx-module-1.20/src/ngx_http_fastdfs_module.c:6:
/usr/include/fastdfs/fdfs_define.h:15:27: 致命错误：common_define.h：没有那个文件或目录
#include "common_define.h"
^
编译中断。
make[1]: *** [objs/addon/src/ngx_http_fastdfs_module.o] 错误 1
make[1]: 离开目录“/software/nginx-1.12.0”
make: *** [build] 错误 2

需要修改fastdfs-nginx-module-1.20的conf配置文件
[root@localhost ~]# vi /software/fastdfs-nginx-module-1.20/src/config
主要修改如下两处配置：
ngx_module_incs="/usr/local/include"
CORE_INCS="$CORE_INCS /usr/local/include"
修改为：
ngx_module_incs="/usr/local/include/fastdfs /usr/local/include/fastcommon/"
CORE_INCS="$CORE_INCS /usr/local/include/fastdfs /usr/local/include/fastcommon/"

修改完成后，在进行编译安装即可。
nginx的默认目录是/usr/local/nginx，安装成功后查看：
[root@localhost nginx-1.12.0]# cd /usr/local/nginx

[root@localhost nginx]# ll
total 0
drwx------ 2 nobody root   6 Jun 14 01:58 client_body_temp
drwxr-xr-x 2 root   root 333 Jun 16 21:42 conf
drwx------ 2 nobody root   6 Jun 14 01:58 fastcgi_temp
drwxr-xr-x 2 root   root  40 Jun 14 01:31 html
drwxr-xr-x 2 root   root  58 Jun 15 22:21 logs
drwx------ 2 nobody root   6 Jun 14 01:58 proxy_temp
drwxr-xr-x 2 root   root  19 Jun 14 01:31 sbin
drwx------ 2 nobody root   6 Jun 14 01:58 scgi_temp
drwx------ 2 nobody root   6 Jun 14 01:58 uwsgi_temp

配置storage nginx
修改nginx.conf
[root@localhost nginx]# cd conf/
[root@localhost conf]# ls
fastcgi.conf            koi-win             scgi_params
fastcgi.conf.default    mime.types          scgi_params.default
fastcgi_params          mime.types.default  uwsgi_params
fastcgi_params.default  nginx.conf          uwsgi_params.default
koi-utf                 nginx.conf.default  win-utf
[root@localhost conf]# vi nginx.conf

server {
        listen       80;
        server_name  localhost;

        location / {
            root   html;
            index  index.html index.htm;
        }

        location ~/group1/M00 {
            root /data/fastdfs/storage/data;
            ngx_fastdfs_module;
        }

        location = /50x.html {
            root   html;
        }
}

进入FastDFS安装时的解压过的目录，将http.conf和mime.types拷贝到/etc/fdfs目录下
[root@localhost fastdfs-5.11]# cd /software/fastdfs-5.11/conf/
[root@localhost conf]# ls
anti-steal.jpg  http.conf   storage.conf      tracker.conf
client.conf     mime.types  storage_ids.conf
cp http.conf /etc/fdfs/
cp mime.types /etc/fdfs/

还需要把fastdfs-nginx-module-1.20安装目录中src目录下的mod_fastdfs.conf也拷贝到/etc/fdfs目录下：
cp /software/fastdfs-nginx-module-1.20/src/mod_fastdfs.conf /etc/fdfs/

修改mod_fastdfs.conf文件：
vi /etc/fdfs/mod_fastdfs.conf

base_path=/data/fastdfs/storage  #保存日志目录
tracker_server=192.168.128.131:22122 #tracker服务器的IP地址以及端口号
storage_server_port=23000 #storage服务器的端口号
url_have_group_name=true #文件 url 中是否有 group 名
store_path0=/data/fastdfs/storage   #存储路径
group_count = 3 #设置组的个数，事实上这次只使用了group1

注意：
如果url_have_group_name=false的情况下，会报如下错误：
../common/fdfs_global.c, line: 52, the format of filename "group1/M00/00/00/wKgDLVtMOWaAAYuNAAAatRA7TR0787.jpg" is invalid
需要修改配置后，重新启动下nginx
由于是编译安装，systemclt nginx restart不好用，需要进行如下操作
cd /usr/local/nginx/sbin/
./nginx 
./nginx -s stop
./nginx -s quit
./nginx -s reload
