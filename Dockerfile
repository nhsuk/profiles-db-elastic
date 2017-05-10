FROM elasticsearch:5.3.0
RUN apt-get update && apt-get install -y \
    jq

RUN mkdir /data && chown -R elasticsearch:elasticsearch /data/

COPY ./data/ /usr/share/elasticsearch/tmp/
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/

RUN /usr/share/elasticsearch/tmp/scripts/transform-data
RUN /usr/share/elasticsearch/tmp/scripts/load-data

USER elasticsearch
