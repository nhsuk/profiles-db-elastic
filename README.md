# Elasticsearch instance with GP profiles data

Running [`scripts/start`](scripts/start) will start an Elasticsearch instance,
loading data from
[data/input/gp-data-merged.json](data/input/gp-data-merged.json) into an index
named `profiles` [localhost:9200/profiles](http://localhost:9200/profiles).
When running the container in this way, the port on which ES is exposed can be
overridden by setting the environment variable `ES_PORT` (e.g. `ES_PORT=9201 ./scripts/start`).

A basic set of tests can be run from [`scripts/test`](scripts/test)

There are a number of sample queries in [sample-queries](./sample-queries) which can be used to query the data. (e.g  `curl -s -XPOST "http://localhost:9200/profiles/_search?pretty" -d @sample_queries/query-nested-doctor.json | jq -C '.' | less -R`)

## Optional

An alternative to using `curl` for ES config and querying is [kibana](https://www.elastic.co/products/kibana)

## Pre-requisites

* Set `vm.max_map_count=262144` on the Docker instance to support ES
  [requirement](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-prod-mode)
