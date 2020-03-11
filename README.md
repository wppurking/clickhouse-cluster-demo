# clickhouse-cluster-demo
使用 docker-compose 来模拟 clickhouse 的 1 分片 2 副本的两个节点的集群, 主要协助从操作层面看到具体一个 clickhouse 集群的部署例子是什么样的.


## 目录结构介绍
.
├── README.md  
├── config.d   #  所有 clickhouse 都需要的 /etc/clickhouse-server/config.d 自定义配置
│   ├── base.xml     # 基础配置, 开启了 mysql_port 和兼容在容器中的网络监听
│   ├── ch_demo_cluster.xml   # clickhouse 中需要使用的 ch_demo cluster. 
│   └── zookeeper.xml       # 服务器的 zookeeper 服务器
├── dataset.sh        # 用来下载 1987 ~ 2018 的 ontime 数据
├── docker-compose.yaml  # 包含 zk, ch 的容器编排
├── load.sh          # 将 1987 ~ 2018 的 ontime 数据导入 ch (需要 clickhouse-client 支持)
├── metrika_ch1.xml   # ch1 服务器自己的信息
└── metrika_ch2.xml   # ch2 服务器自己的信息


## clickhouse 数据目录
通过 docker-compose up 启动之后, 会在本地出现 ch1 与 ch2 目录, 这两个是 volume 到容器中 ch1 和 ch2 节点的 /var/lib/clickhouse 目录, 记录着当前 clickhouse 实例运行中各种数据, 包括导入后存储的具体数据和目录结构.


# 使用
1. 启动容器编排: docker-compose up   
2. 进入容器操作命令: docker exec -it xxx bash
3. 在容器内操作: clickhouse-client 

因为为 ch 开启了 mysql_port, 所以也可以使用 mysql client 直接连接 9004 或者 9204 端口. 可以通过兼容的 mysql 协议完成查询.