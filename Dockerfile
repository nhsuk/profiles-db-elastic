FROM elasticsearch:5.3.0

RUN mkdir /data && chown -R elasticsearch:elasticsearch /data && echo 'path.data: /data' >> config/elasticsearch.yml
COPY data/gp-data-bulk-insert.json /tmp/gp-data-bulk-insert.json

RUN /docker-entrypoint.sh elasticsearch -p /tmp/pid & sleep 20 && curl -XPOST 127.0.0.1:9200/_bulk --data-binary @/tmp/gp-data-bulk-insert.json; pkill -F /tmp/pid

USER elasticsearch