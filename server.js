var express = require('express');
var couchbase = require("couchbase");

var port = process.env.npm_package_config_port || 8080;
var couchbaseHost = process.env.npm_package_config_couchbase || '127.0.0.1';
var bucketName = process.env.npm_package_config_bucket || 'beer-sample';

console.log('Config - Port: ' + port);
console.log('Config - Couchbase host: ' + couchbaseHost);
console.log('Config - Bucket name: ' + bucketName);

var cluster = new couchbase.Cluster(couchbaseHost);
var bucket = cluster.openBucket(bucketName, function(err) {
    if (err) {
        // Failed to make a connection to the Couchbase cluster.
        console.log('cannot connect to couchbase cluster: ' + couchbaseHost + ' - ' + err);
    }
});

var app = express();
app.disable('x-powered-by');

app.get('/status', function(req, res) {
  console.log("Status called");
  res.json({"status": "running"});
});

app.get('/get/:id', function(req, res) {
    console.log("Document requested - id=" + req.params.id);
    bucket.get(req.params.id, function(err, result) {
        if (err) {
            console.log(err);
            res.json({
                'error': err
            });
        }

        var doc = result.value;
        console.log(doc.name + ', ABV: ' + doc.abv);

        res.json({
            'get': req.params.id,
            'doc': doc
        });
    });

    res.json({
        'error': 'no document',
        'id': req.params.id
    });
});

app.listen(port);

console.log('Server listening on port: ' + port);
