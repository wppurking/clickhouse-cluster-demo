#!/bin/bash
# 如果只下载了单个数据, 手动 unzip 操作需要 sed -i 's/\.00//g'  xxx.csv 操作
# 简化了数据将 .00 替换为 空
for i in *.zip; do echo $i; unzip -cq $i '*.csv' | sed 's/\.00//g' | clickhouse-client --host=example-perftest01j --query="INSERT INTO ontime FORMAT CSVWithNames"; done
