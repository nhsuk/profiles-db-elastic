# 3. Build Image with GP Data

Date: 2017-06-15

## Status

Accepted

## Context

In the early stages of ES adoption (which predates the development of ETL processes to automatically build the GP JSON data file) the GP data mas manually added to this repo. The data is in a format optimised for loading into MongoDB. Whilst Elastic Search (ES) can import documents singly in the format it takes some considerable time. By re-shaping the data to that required by the bulk import API of ES then the import can happen in a matter of seconds rather than 10's of minutes otherwise.

## Decision

The use of an existing data file coupled with pre-procesing (using a `jq` script) to reshape it and subsequent bulk loading it into ES was a pragmatic move
 
## Consequences

The data is loaded using bash scripts run within the container as part of `docker build` which means that the resulting Docker image contains ES preloaded with the GP data.

The updating of the source GP data file in this repo is a manual process with no set schedule. This will likely be superceeded by the GP data ETL processors in the near future.

As well as reshaping the GP JSON document for bulk insert some manipulation of the properties was necessary to optimise for particular search requirements. The reshaping was carried out using `jq` as a lightweight way of doing this but did mean that there are no tests around the reshaping.
