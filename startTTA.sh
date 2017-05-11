#!/usr/bin/env bash
set -e

echo "--> (Re)Start TTA <--"

pwd

echo "--> Kill TTA if already running"
ps -ef | grep rail[s] | awk '{print $2}' | xargs kill

sleep 2

echo "--> MySQL server status - "
mysql.server status

echo "--> Restart MySQL server"
mysql.server restart

sleep 3

echo "--> Start TTA on IP $1:3000 in '$RAILS_ENV' mode"
bundle exec rails s -b $1 &

sleep 2

echo "--> TTA IS READY <--"
