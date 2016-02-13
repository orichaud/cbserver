var express = require('express');
var program = require('commander');
var couchbase = require("couchbase");

var port = 8080;
var couchbaseHost = '127.0.0.1';
var bucketName = 'beer-sample';

program
    .version('0.0.1')
    .option('-p, --port <Port>', 'set port to listen to')
    .option('-c, --couchbase <host>', 'set ip to connect to')
    .option('-b, --bucket <bucket name>', 'set bucket to connect to')
    .parse(process.argv);


if (program.port) {
    port = program.port;
    console.log('Port given: ' + port);
} else {
    console.error('No port has been defined. Default port used: ' + port);
}

if (program.couchbase) {
    couchbaseHost = program.couchbase;
    console.log('Couchbase host: ' + couchbaseHost);
} else {
    console.error('No couchbase host has been defined. Default host used: ' + couchbaseHost);
}

if (program.bucket) {
    bucketName = program.bucket;
    console.log('Bucket name: ' + bucketName);
} else {
    console.error('No bucket name has been defined. Default host used: ' + bucketName);
}

var cluster = new couchbase.Cluster(couchbaseHost);
var bucket = cluster.openBucket(bucketName, function(err) {
    if (err) {
        // Failed to make a connection to the Couchbase cluster.
        console.log('cannot connect to couchbase cluster: ' + couchbaseHost + ' - ' + err);
    }
});

var app = express();
app.disable('x-powered-by');

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
