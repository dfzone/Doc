# Linux命令

## 远程复制命令
> 从远程服务器复制文件到本地  
> scp root@192.168.1.100:/data/test.txt /home/myfile/  
-------------
> 从远程服务器复制文件夹到本地  
> scp -r root@192.168.1.100:/data/ /home/myfile/  
-------------
> 复制本地文件到远程服务器  
> scp /home/myfile/test.txt root@192.168.1.100:/data/  
-------------
> 复制本地文件夹到远程服务器  
> scp -r /home/myfile/ root@192.168.1.100:/data/
