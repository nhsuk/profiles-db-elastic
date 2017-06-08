FROM elasticsearch:5.4.0
RUN apt-get update && apt-get install -y \
    jq

# Limit heapsize to 512MB, default is 2GB
ENV ES_JAVA_OPTS="-Xms512m -Xmx512m"

# Create data dir for persistence between restarts. Changing path here requires
# corresponding change in ./config/elasticsearch.yml for path.data
RUN mkdir /data && chown -R elasticsearch:elasticsearch /data

COPY ./config/ /usr/share/elasticsearch/config/
COPY ./data/ /usr/share/elasticsearch/tmp/data/

RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/

USER elasticsearch

RUN /usr/share/elasticsearch/tmp/data/scripts/transform-data
RUN /usr/share/elasticsearch/tmp/data/scripts/load-data
