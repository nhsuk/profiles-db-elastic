.[] |
.doctors = ( .doctors | map( { name: . } )) |
.alternativeName = .address.addressLines[0] |
.id = ._id |
del (._id) |
{"index": {"_index": "profiles", "_type": "gps", "_id": .id}}, .
