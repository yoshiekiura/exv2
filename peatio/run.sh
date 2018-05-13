#!/bin/bash

#init vars
RDS=false
MYSQL_DATABASE="peatio"
MYSQL_USER="peatio"
MYSQL_PASSWORD="peatio"
MYSQL_HOST="mysql"

show_help (){
  echo " --rds : set to true to use rds you will have set all other params --host --database --user --password"
}

while [ "$1" != "" ]; do
  case $1 in
    --rds ) RDS=$2
            shift 2 ;;
    --host ) MYSQL_HOST=$2
             shift 2 ;;
    --user ) MYSQL_USER=$2
             shift 2 ;;
    --password ) MYSQL_PASSWORD=$2
                 shift 2 ;;
    --database ) MYSQL_DATABASE=$2
                 shift 2 ;;
    --help ) show_help
             exit ;;
  esac
done

echo "rds = $RDS"
echo "database = $MYSQL_DATABASE"
echo "user = $MYSQL_USER"
echo "password = $MYSQL_PASSWORD"
echo "host = $MYSQL_HOST"

source ./smtp
source ./rpc_vars

export MYSQL_DATABASE
export MYSQL_USER
export MYSQL_PASSWORD
export MYSQL_HOST

export PHANTOMJS_VERISON=1.9.8

if [ ! -e "deps/phantomjs-$PHANTOMJS_VERISON-linux-x86_64.tar.bz2" ]; then
  wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERISON-linux-x86_64.tar.bz2 -P deps
fi
git clone "https://AlyHKafoury@github.com/InfraexDev/SaaS.git" ./app/peatio

if [ $RDS == false ]; then
  echo "deploying on single server"
  docker-compose -f docker-compose.yml up --build
else
  echo "deploying on rds"
  docker-compose -f docker-compose.rds.yml up --build -d
fi
