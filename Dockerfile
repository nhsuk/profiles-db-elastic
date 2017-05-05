FROM elasticsearch:5.3.0

RUN mkdir /data && chown -R elasticsearch:elasticsearch /data && echo 'path.data: /data' >> config/elasticsearch.yml

COPY ./data/output/gp-data-bulk-insert.json /tmp/gp-data-bulk-insert.json
COPY ./data/mapping/mapping.json /tmp/mapping.json
COPY ./load-data /tmp/load-data

RUN /tmp/load-data

USER elasticsearch
