#!/bin/bash
sed -e "s/\${domain_url}/$DOMAIN/" -i config/application.yml
sed -e "s/\${rpc_url}/$RPCUSER:$RPCPASS@$RPCHOST:$RPCPORT/" -i config/currencies.yml

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
rm -rf /peatio/tmp/pids/*
bundle exec rake daemons:start
bundle exec rails server
