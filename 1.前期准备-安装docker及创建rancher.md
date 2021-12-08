#初期环境准备
##  防火墙

临时关闭防火墙

```systemctl stop firewalld```

永久关闭防火墙

```systemctl disable firewalld```


查看防火墙状态

```systemctl status firewalld```


##  关闭selinux

临时关闭selinux，立即生效，不需要重启服务器。

```setenforce 0```

永久关闭selinux，修改完配置后需要重启服务器才能生效。

```vi /etc/selinux/config```

修改enable 为disabled，并保存该文件。
![image2021-10-11_16-57-24.png](https://upload-images.jianshu.io/upload_images/14960078-859a331a27baf2da.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

[nfs服务搭建](https://cloud.tencent.com/developer/article/1433259)

# 复制文件到linux文件描述


├─thc_images  存入其他所有的镜像文件，

├─deployment_yaml  空文件夹，用于存放替换后的yaml文件。
├─docker         空文件夹。docker.yaml文件映射到此文件夹下。
├─docker_package  docker安装文件
│ ├─docker
│ └─docker-config
├─rancher_data  // 空文件夹  rancher.yaml 文件映射到此文件夹下
├─rancher_images   rancher2.24 版本的镜像文件
├─registry_images   harbor  镜像文件。
│ ├─harbor
│ └─harbor_data
└─all_yaml    所有的需要替换ip地址的模板文件

install.sh                       安装文件
install_docker.sh           安装docker文件
startup.sh                    启动
stop.sh                           停止
uninstall.sh                 卸载（卸载为卸载所有的容器，包含之前存在的容器，谨慎使用）
uninstall_docker.sh    卸载docker  

如果卸载需要先卸载所有文件之后再后卸载docker(先运行uninstall.sh后运行uninstall_docker.sh)

### 安装
```
chmod + x *.sh   #增加所有sh的可执行权限
./install_docker.sh  # 安装docker
/install.sh [ip地址]   #安装harbor及rancher 例: ./install.sh 192.168.3.128
```
点击  添加集群  按钮
![image2021-10-29_11-25-54](https://user-images.githubusercontent.com/26183465/145188002-c76474e0-0250-42aa-97b8-eea08060c152.png)

运行成功，同时界面会提示，一台主机注册成功
若存在多台主机，则在此新增多台即可。**注意修改ip以及名称（名称相同可能会出现主机不可用的情况）**
复制deplay_all 中的所有文件，在default中上传。，即可创建集群成功。



