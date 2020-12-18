# mago3D
<strong>mago3D是一个数字孪生平台.</strong>

[设置及帮助文档](https://gaia3d.atlassian.net/wiki/spaces/education/pages/71892997/mago3D)

## Features
- 二维空间信息管理功能
- 三维数据格式支持功能
- 三维数据管理功能
- 自动化的二维/三维空间信息管理功能
- 三维可视化功能
- 三维数据运行功能
- 模拟服务联动

## Development Environment
- JAVA(OpenJDK) 11.0.2
- Spring Boot 2.3.0
- PostgreSQL 12
- PostGIS 3.0
- Gradle 6.5.0
- Mybatis
- Lombok
- Thymeleaf
- F4d Converter
- Geoserver 2.17.x
- RabbitMQ 3.8.x
- Gdal 3.x

## Project Composition
- mago3d-admin : 平台（mago3D）维护者     
- mago3d-converter : 三维空间信息自动化管理
- mago3d-user : 二维/三维空间数据查询、模拟联动等
- common : 加密（安全）、统计模块等共同功能管理
- doc : database schema, 开发文档
- html : html设计文件（由npm init生成）

## Getting Started

## 1. Install
### 1.1 通用
#### [java](https://jdk.java.net/archive/)
- OpenJDK 11.0.2 (build 11.0.2+9) : 11版本的安装

#### [GDAL](https://trac.osgeo.org/osgeo4w/)
- 安装GDAL安装OSGeo4W（FOSSGIS for Windows）
- 添加系统变量 <br>
  Path C:\OSGeo4W64\bin
  
#### [F4D Converter](https://github.com/Gaia3D/F4DConverter/blob/master/install/SetupF4DConverter.msi)
- 安装路径：C:\F4DConverterConsole
- 运行已下载的文件，并安装Coverter。
 
### 1.2 docker环境
- 使用docker-compose需要事先设置docker。
- checkout项目的root路径中运行以下指令。 
~~~ cmd
    docker-compose up -d
~~~
- 根据docker-compose文件中定义的内容，database，geoserver，rabbitmq由container生成。 

### 1.3一般环境
- 在1.2的docker环境中，以docker-compose组成开发环境的话，1.3课程可以省略。 

#### [PostgreSQL](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
- 设定为PostgreSQL 12版本
- 安装路径C:/PostgreSQL/12 <br>
  doc/database/doc/database/ 参考
- [PostGIS](https://postgis.net/) 设定为PostGIS最新SQL版本

#### [Erlang](https://www.erlang.org/downloads)
- 为了安装rabbit mq，需要erlang，所以先安装erlang。.
- 在Download OTP 23.1项目中点击“OTP 23.1 Windows 64-bit Binary File”下载并执行文件。
- 配置元素设置将以默认值进行，所以点击next进行安装。
- **如果Visual C++组件安装窗口显示，请检查并安装检查框。**

#### [RabbitMQ](https://www.rabbitmq.com/download.html)
- 确认最新版本，并根据操作系统环境下载并安装文件。
    - 设置环境变量
        - 点击[控制板]→[系统及安全]→[系统]或[我的PC]的[属性]后，点击[高级系统设置]。
        - 在[系统属性]的[高级]标签画面中点击[环境变量]。
        - 点击[环境变量]屏幕上的[新建]，在变量名称和变量值输入栏中设置RABBITMQ HOME和RabbitMQ设置路径。
        - 设置RabbitMQ安装路径后，选择系统变量的[Path]变量，点击[编辑]按钮。
        - 点击[新建]按钮，输入%RABBITMQ HOME\sbin。
    - 激活管理员插件
        - 要连接到管理员页面，必须启用maagent plugin。（禁用时无法连接）
        - 为了激活RabbitMQ的maagent plugin，在命令提示窗口输入“rabbitmq-plugins enable rabbitmq maagent”并激活。
        - 重新启动命令提示，通过“rabbitmq-plugins list”确认插件是否被激活。
    - 管理员设置
        - Rabbit MQ管理器页面（http://localhost:15672）登录。
        - ID和密码都用guest登录。
        - 在上端点击Exchange标签，在下端点击Add a new exchangs，输入以下内容后点击Add exchange按钮。 
            - Name : f4d.converter
            - Type : topic
            - Durability : Durable
        - 在上端绘制Queues标签，在底部点击Add a new queue，输入以下内容后，点击Add quere按钮。
            - Type : Classic
            - Name : f4d.converter.queue
            - Durability : Durable
        - 点击Admin菜单底部的Add a user创建其它管理器账户。
            - Username : mago3d
            - Password : mago3d
            - Tags : administrator
        - 点击guest下面新生成的mago3d账户，并生成以下Current permissions、Current topic permissions，在Update this user输入密码（mago3d）后，点击下端的Update user按钮。
            - Current permission
                - Virtual Host : /
                - Configure regexp : .*
                - Write regexp : .*
                - Read regexp : .*
            - Topic permission
                - Virtual Host : /
                - Exchange : f4d.converter
                - Write regexp : .*
                - Read regexp : .*
                
#### IDE设置 
#### [eclipse](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-12/R/eclipse-inst-win64.exe)
- Eclipse IDE 2019-12 (2019-12(4.14.0) 版本以上安装)<br>
- 设置Eclipse-STS（Spring Tools） <br>
  Help → Eclipse Marketplace → 'STS' 搜索后, 设置 Spring Tools 4
- 运行Eclipse后Project Import <br>
  File → import → Gradle → Existing Gradle Project
  
#### intellij
- 为了在本地开发环境中不发生build更新static resource，将resource路径设为file path，将mago3d的运行设为boot Run，或者将Working directory设为$MODULE WORKING DIR$。


#### [lombok](https://projectlombok.org/)
- 如果使用eclipse，需要通过以下过程设置lombok。
- 移动下载文件夹后运行
- 搜索eclipse安装位置eclipse.exe“选择文件。
- 点击install/update。



## 2. DB生成及初始数据注册
- 在1.2的docker环境中，以docker-compose组成开发环境的话，该过程可以省略。
- Database & Extensions
	- 生成mago3d数据库。为了韩文排列，设置数据库如下。
	~~~ sql
        CREATE DATABASE mago3d
        WITH OWNER = postgres
        	ENCODING = 'UTF8'
        	TEMPLATE = template0
        	TABLESPACE = pg_default
        	LC_COLLATE = 'C'
        	LC_CTYPE = 'C'
        	CONNECTION LIMIT = -1; 
    ~~~
	- psql（SQL Shell）或者pgAdmin运行Extensions。
	~~~ sql
        CREATE EXTENSION postgis
    ~~~
- sql执行
    - 运行doc/database路径上的dl/dml/index文件夹中的sql。

	   
## 3. Execution
- mago3d-admin project spring boot 运行 <br>
  url : http://localhost(:port)/
<pre><code>/mago3d-admin/src/main/java/gaia3d/Mago3DAdminApplication.java</code></pre>

## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).