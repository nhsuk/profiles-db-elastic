# Elasticsearch instance with GP profiles data

Running [`scripts/start`](scripts/start) will start an Elasticsearch instance,
loading data from
[data/input/gp-data-merged.json](data/input/gp-data-merged.json) into an index
named `profiles` [localhost:9200/profiles](http://localhost:9200/profiles).

Sample query to return the top 3 of a query by GP name:
```
curl -s -XPOST "http://localhost:9200/profiles/_search?pretty" -d '
{
  "size": 3,
  "explain": false,
  "_source": [ "name", "address", "doctors" ],
  "query" : { 
    "multi_match": { 
      "query": "Doctor O'Connor",
      "fields": [ "name^2", "address.addressLines", "doctors" ],
      "operator": "or"
    }
  },
  "highlight" : {
    "fields" : {
      "name" : {},
      "doctors" : {},
      "address.addressLines" : {}
    }
  }
}'
```

## Environment variables

`ES_PORT` is available as an environment variable to override the default port
used by ES (9200). Simply set `ES_PORT=XXXX` to the port value required within
the shell.

## Optional

Use [kibana](https://www.elastic.co/products/kibana) for ES querying and
visualistion

## Pre-requisites

* Set `vm.max_map_count=262144` on the Docker instance to support ES
  [requirement](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-prod-mode)
