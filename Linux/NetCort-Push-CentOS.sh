//--------注册微软签名密钥并添加微软产品提要---------------
# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
# sudo sh -c 'echo -e "[packages-microsoft-com-prod]\nname=packages-microsoft-com-prod \nbaseurl=https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/dotnetdev.repo'
//--------注册微软签名密钥并添加微软产品提要---------------


//--------安装.netcore sdk-------------------------------------
# sudo yum update
# sudo yum install libunwind libicu
# sudo yum install dotnet-sdk-2.0.3
//--------安装.netcore sdk-------------------------------------


# dotnet -h
# dotnet --info
# dotnet new mvc -o myMvcApp
# ls
# cd myMvcApp
[root@localhost myMvcApp]# ls
[root@localhost myMvcApp]# dotnet run

//--------安装nginx-------------------------------------
# curl -o  nginx.rpm http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
# rpm -ivh nginx.rpm
# systemctl start nginx
# ip addr
# systemctl enable nginx
//--------安装nginx-------------------------------------

//--------配置nginx-------------------------------------
# cat /etc/nginx/conf.d/default.conf
# vi /etc/nginx/conf.d/default.conf
[root@localhost nginx]# sudo nginx -s reload
//--------配置nginx-------------------------------------

//--------配置nginx代理问题---------------------------
# yum install policycoreutils-python
# sudo cat /var/log/audit/audit.log | grep nginx | grep denied | audit2allow -M mynginx
# sudo semodule -i mynginx.pp
//--------配置nginx代理问题----------------------------

//--------配置防火墙-------------------------------------
# firewall-cmd --zone=public --add-port=80/tcp --permanent
# systemctl restart firewalld
//--------配置防火墙-------------------------------------

