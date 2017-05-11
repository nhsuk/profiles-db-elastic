FROM elasticsearch:5.3.0
RUN apt-get update && apt-get install -y \
    jq

# Create data dir for persistence between restarts. Changing path here requires
# corresponding change in ./config/elasticsearch.yml for path.data
RUN mkdir /data && chown -R elasticsearch:elasticsearch /data

COPY ./config/ /usr/share/elasticsearch/config/
COPY ./data/ /usr/share/elasticsearch/tmp/data/

RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/

USER elasticsearch

RUN /usr/share/elasticsearch/tmp/data/scripts/transform-data
RUN /usr/share/elasticsearch/tmp/data/scripts/load-data
