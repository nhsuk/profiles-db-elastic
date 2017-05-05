# Elasticsearch instance with GP profiles data

Running [`scripts/start`](scripts/start) will format
[data/input/gp-data-merged.json](data/input/gp-data-merged.json)
ready for ingestion into ES and start the ES container.
ES will be available on [localhost:9200](http://localhost:9200).

Sample query to return the top 10 of all results:
`curl "http://127.0.0.1:9200/profiles/_search?q=*&pretty"`

## Optional

Use [kibana](https://www.elastic.co/products/kibana) for ES
querying and visualistion
