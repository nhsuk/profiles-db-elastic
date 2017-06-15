# 2. Use Docker Image from elastic.co

Date: 2017-06-15

## Status

Accepted

## Context

[ElasticSearch](https://www.elastic.co/products/elasticsearch) is a Java based search engine built on top of technologies like Lucene and Solr. It is open source software which can be freely [downloaded](https://github.com/elastic/elasticsearch) and installed on a number of operating systems. It is also available from elastic.co as both a Docker image and as a cloud service.

## Decision

For initial proof of concept and early beta the Docker image is the quickest way of getting up and running with ES and this outweighs the concerns about the inability to change the default user/password for the user which ES runs as.

## Consequences

Whilst the docker image is freely available there have been concerns raised in the ES community regarding it no longer being hosted on Docker Hub (it is now hosted on the elastic.co Docker [repo](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html) ). The Docker Hub [repo](https://hub.docker.com/_/elasticsearch/) has many comments and these can be distilled down to difficulty managing different versions of ES when not hosted on docker hub and the tie in with X-pack security features.

X-Pack: the included basic subscription for the included X-Pack security module does not allow the default username and passwords to be changed without paying a subscription. This will need addressing going forward and this could be by paying the X-Pack subscription, building our own ES image with a free security alternative (e.g. [SearchGuard](https://sematext.com/blog/2017/05/22/elasticsearch-kibana-security-search-guard/)) or by using the ES SaaS [offering](https://www.elastic.co/cloud/as-a-service).  

The inability to change default user presents a small risk. The risk is small since 1) the instance of ES will not be public facing, 2) it can be secured at the Docker container and network level and 3) it contains only data which is currently in the public domain. It would in theory be possible, if a public facing container based app in the same virual network was compromised, for the data to be modified or deleted. The likelyhood of this happening is small. 
