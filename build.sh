echo "清理已有容器及镜像资源"
container="vue-demo"
image=${container}
if docker ps | grep ${container};then
    docker stop ${container}
fi
if docker ps -a | grep ${container};then
    docker rm -f ${container}
fi
#if docker images | grep ${image};then
#    docker rmi ${image}
#fi
echo --------------获取短版本号...-------------
GITHASH=`git rev-parse --short HEAD`
echo $GITHASH
echo --------------构建docker惊醒...------------
docker build -f Dockerfile -t ${image}:$GITHASH
echo --------------将短版本号标记为最新版本...------------
docker tag ${image}:$GITHASH ${image}:latest
echo --------------运行容器...------------
docker run -d -p 5102:80 --name ${container} --restart=always ${image}:latest
echo --------------删除所有none的镜像..------------
#docker rmi -f `docker images | grep "<none>" | awk '{print $3}'`
