#!/usr/bin/env bash

sleep 10


mongosh db:27017/admin --eval "rs.initiate({_id: 'rs0', members: [{_id: 0, host: 'db:27017'}]})"

mongosh db:27017/admin --eval "db.createUser({user:'flowci', pwd:'flowci', roles:[{role:'root',db:'admin'}]})"