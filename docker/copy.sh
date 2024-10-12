#!/bin/sh

# 复制项目的文件到对应docker路径，便于一键生成镜像。
usage() {
	echo "Usage: sh copy.sh"
	exit 1
}


# copy sql
echo "begin copy sql "
cp ../sql/ry_20231130.sql ./mysql/db
cp ../sql/ry_config_20231204.sql ./mysql/db

# copy html
echo "begin copy html "
cp -r ../easygpt-ui/dist/** ./nginx/html/dist


# copy jar
echo "begin copy easygpt-gateway "
cp ../easygpt-gateway/target/easygpt-gateway.jar ./ruoyi/gateway/jar

echo "begin copy easygpt-auth "
cp ../easygpt-auth/target/easygpt-auth.jar ./ruoyi/auth/jar

echo "begin copy easygpt-visual "
cp ../easygpt-visual/easygpt-monitor/target/easygpt-visual-monitor.jar  ./ruoyi/visual/monitor/jar

echo "begin copy easygpt-modules-system "
cp ../easygpt-modules/easygpt-system/target/easygpt-modules-system.jar ./ruoyi/modules/system/jar

echo "begin copy easygpt-modules-file "
cp ../easygpt-modules/easygpt-file/target/easygpt-modules-file.jar ./ruoyi/modules/file/jar

echo "begin copy easygpt-modules-job "
cp ../easygpt-modules/easygpt-job/target/easygpt-modules-job.jar ./ruoyi/modules/job/jar

echo "begin copy easygpt-modules-gen "
cp ../easygpt-modules/easygpt-gen/target/easygpt-modules-gen.jar ./ruoyi/modules/gen/jar

