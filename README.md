# Elasticsearch instance with GP profiles data

[![Build Status](https://travis-ci.org/nhsuk/profiles-db-elastic.svg?branch=master)](https://travis-ci.org/nhsuk/profiles-db-elastic)

Running [`scripts/start`](scripts/start) will start an Elasticsearch instance,
loading data from
[data/input/gp-data-merged.json](data/input/gp-data-merged.json) into an index
named `profiles` [localhost:9200/profiles](http://localhost:9200/profiles).
<<<<<<< Updated upstream
When running the container in this way, the port on which ES is exposed can be
overridden by setting the environment variable `ES_PORT` (e.g. `ES_PORT=9201
./scripts/start`).

A basic set of tests can be run from [`scripts/test`](scripts/test)

The data in a running instance can be queried using the ElasticSearch REST API and a command line tool like curl.

## Full Text Search Example
=======
We do not currently used date dependent indices as the data gets loaded once on starting
up the image, however if the data will automatically refresh in the future 

```
curl -s -XPOST http://localhost:9200/profiles/_search?pretty -d '
{
  "size": 10,
  "explain": false,
  "_source": [ "name", "alternativeName", "address", "doctors" ],
  "query" : {
    "bool": {
      "must": {
        "multi_match": {
          "query": "Beech House Surgery",
          "fields": [ "name^2", "alternativeName" ],
          "operator": "and"
        }
      },
      "should":  [
        { "match_phrase": {
          "name": {
            "query": "Beech House Surgery" ,
            "boost": 2
          }
        } }
      ]
    }
  },
  "highlight" : {
    "fields" : {
      "name" : {},
      "alternativeName" : {}
    }
  }
}'

```

## Geo-Location Search Example 

```
curl -s -XPOST http://localhost:9200/profiles/_search?pretty -d '
{
  "query": {
    "bool": {
      "must" : {
        "match_all" : {}
      },
      "filter": {
        "geo_distance": {
          "distance": "1km", 
          "location.coordinates": { 
            "lon": -1.46519099452929,
            "lat": 54.0095586395326
          }
        }
      }
    }
  },
  "sort": [
    {
      "_geo_distance": {
        "location.coordinates": {
          "lon": -1.46519099452929,
          "lat": 54.0095586395326
        },
        "order":         "asc",
        "unit":          "km",
        "distance_type": "plane"
      }
    }
  ]
}
```

Other useful endpoints on the API are:

* Query index settings:
  * `curl http://localhost:9200/profiles/_settings?pretty`
* Query index mappings:
  * `curl http://localhost:9200/profiles/_mappings?pretty`
* Interact with an analyzer:
 * `curl http://localhost:9200/profiles/_analze?pretty -d '{ "analyzer" : "gp_name_analyzer", "text" : "dr andrew jones" }'`

See
[here](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)
for more detail on querying.

## Optional

An alternative to using `curl` for ES config, querying and also is visualisation [kibana](https://www.elastic.co/products/kibana)
Use version [5.3.*](https://www.elastic.co/blog/kibana-5-3-1-released) that works with out ES image and follow the installation steps
[here](https://www.elastic.co/downloads/kibana#ga-release).
The default port for ES is `9200` and default index is `profiles`

Here is an example query for the `Discover` tab when you choose the `"name", "alternativeName", "address.addressLines", "address.postcode", "doctors"` for the source:
```
{"bool": {"must": {"multi_match": {"query": "Beech House Surgery", "fields":["name^2","alternativeName"], "operator":"and"}}, "should": [{"match_phrase": {"name": {"query": "Beech House Surgery", "boost":2}}}]}}
```

## Pre-requisites

* Set `vm.max_map_count=262144` on the Docker instance to support ES
  [requirement](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-prod-mode)
