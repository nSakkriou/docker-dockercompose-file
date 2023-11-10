## Start Redis

#### No Web UI
```
docker run -d --name REDIS_CONTAINER -v /local-data/:/data -p 6379:6379 redis/redis-stack-server:latest
```

##### With Web UI
```
docker run -d --name REDIS_CONTAINER -v /local-data/:/data -p 6379:6379 -p 8001:8001 redis/redis-stack:latest
```

### Options

#### To insert config file
```
-v `pwd`/local-redis-stack.conf:/redis-stack.conf
```

#### To connect
```
docker exec -it redis-stack-server redis-cli
```

#### To pass env variables
REDIS_ARGS: extra arguments for Redis

REDISEARCH_ARGS: arguments for the search and query features (RediSearch)

REDISJSON_ARGS: arguments for JSON (RedisJSON)

REDISTIMESERIES_ARGS: arguments for time series (RedisTimeSeries)

REDISBLOOM_ARGS: arguments for the probabilistic data structures (RedisBloom)
```
-e REDIS_ARGS="--requirepass redis-stack"
```

Config file exemple : https://redis.io/docs/management/config-file/