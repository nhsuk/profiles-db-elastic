# Elasticsearch instance with GP profiles data

Running [`scripts/start`](scripts/start) will start an Elasticsearch instance,
loading data from
[data/input/gp-data-merged.json](data/input/gp-data-merged.json) into an index
named `profiles` [localhost:9200/profiles](http://localhost:9200/profiles).

Sample query to return the top 10 of all results: `curl
"http://127.0.0.1:9200/profiles/_search?q=*&pretty"`

When running the container in this way, the port on which ES is exposed can be
overridden by setting an environment variable - `ES_PORT` - equal to the port
wishing to be used e.g. `ES_PORT=9201 ./scripts/start`.

## Optional

Use [kibana](https://www.elastic.co/products/kibana) for ES querying and
visualistion

## Pre-requisites

* Set `vm.max_map_count=262144` on the Docker instance to support ES
  [requirement](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-prod-mode)
