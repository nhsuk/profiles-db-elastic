FROM elasticsearch:5.3.0

RUN mkdir /data && chown -R elasticsearch:elasticsearch /data && echo 'path.data: /data' >> config/elasticsearch.yml
COPY data/output/gp-data-bulk-insert.json /tmp/gp-data-bulk-insert.json
COPY data/mapping/mapping.json /tmp/mapping.json
COPY ./load-data.sh /tmp/load-data.sh

RUN chmod +x /tmp/load-data.sh && /tmp/load-data.sh

USER elasticsearch
