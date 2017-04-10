To create import document structure, removing opening times as this causes index problems:

jq -c '.[]  | .id = ._id | del (._id) | del (.openingTimes) | {"index": {"_index": "profiles", "_type": "gps", "_id": .id}}, .' data/gp-data.json > data/gp-data-bulk-insert.json 

create and run: `docker-compose up --build --force-recreate`

To clean before re-creating `docker-compose down -v`

sample query `curl "http://127.0.0.1:9200/profiles/_search?q=ramdeehul&pretty"`
