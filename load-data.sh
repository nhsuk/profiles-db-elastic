echo 'starting elastic search'
/docker-entrypoint.sh elasticsearch -p /tmp/pid &
echo 'waiting for es to start'
until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:9200); do
    printf '.'
    sleep 5
done
echo 'loading data'
# curl -XPUT 127.0.0.1:9200/profiles -d '{ "mappings": { "gps": { "properties": { "services": { "include_in_all": false, "type": "text" } } } } }'
curl -XPOST 127.0.0.1:9200/_bulk --data-binary @/tmp/gp-data-bulk-insert.json
echo 'load complete, ending process'
pkill -F /tmp/pid