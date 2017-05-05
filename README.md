# Elasticsearch instance with GP profiles data

Running [`scripts/start`](scripts/start) will format
[data/input/gp-data-merged.json](data/input/gp-data-merged.json)
ready for ingestion into ES and start the ES container.
It will be available on [localhost:9200](http://localhost:9200).

Sample query `curl "http://127.0.0.1:9200/profiles/_search?q=ramdeehul&pretty"`

## Optional

Use [kibana](https://www.elastic.co/products/kibana) for ES
querying and visualistion
