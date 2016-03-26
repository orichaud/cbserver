var express = require('express');
var bodyParser = require('body-parser')
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
        return;
    }
    bucket.operationTimeout = 60 * 1000;
    console.log("Connected to bucket: " + bucketName);
});

var app = express();
app.disable('x-powered-by');
app.use(bodyParser.json());

app.get('/status', function(req, res) {
    console.log("Status called");
    res.json({
        "status": "running"
    });
});

app.get('/entry/:id', function(req, res) {
    console.log("get - Document requested - id=" + req.params.id);
    bucket.get(req.params.id, function(err, result) {
        console.log("Document get called - id=" + req.params.id);
        if (err) {
            console.log("get - error reported - id=" + req.params.id + ":", err);
            res.json({
                'operation': 'get',
                'id': req.params.id,
                'status': 'failed'
            });
        } else {
            var doc = result.value;
            res.json({
                'operation': 'get',
                'id': req.params.id,
                'status': 'success',
                'doc': doc
            });
        }
    });
});

app.put('/entry/:id', function(req, res) {
    data = req.body;
    console.log("post - Document requested - id=" + req.params.id + " - data=" + JSON.stringify(data));

    bucket.upsert(req.params.id, data, function(err, result) {
        if (err) {
            console.log("put - error reported - id=" + req.params.id + ":", err);
            res.json({
                'operation': 'put',
                'id': req.params.id,
                'status': 'failed'
            });
        } else {
            res.json({
                'operation': 'put',
                'id': req.params.id,
                'status': 'success',
                'doc': data
            });
        }
    });
});

app.delete('/entry/:id', function(req, res) {
    console.log("delete - Document requested - id=" + req.params.id);
    bucket.remove(req.params.id, function(err, result) {
        console.log("Document get called - id=" + req.params.id);
        if (err) {
            console.log("delete - error reported - id=" + req.params.id + ":", err);
            res.json({
                'operation': 'delete',
                'id': req.params.id,
                'status': 'failed'
            });
        } else {
            res.json({
                'operation': 'delete',
                'id': req.params.id,
                'status': 'success'
            });
        }
    });
});

app.post('/entry/:id', function(req, res) {
    data = req.body;
    console.log("post - Document requested - id=" + req.params.id + " - data=" + JSON.stringify(data));
    bucket.insert(req.params.id, data, function(err, result) {
        if (err) {
            console.log("post - error reported - id=" + req.params.id + ":", err);
            res.json({
                'operation': 'post',
                'id': req.params.id,
                'status': 'failed'
            });
        } else {
            res.json({
                'operation': 'post',
                'id': req.params.id,
                'status': 'success',
                'doc': data
            });
        }
    });
});


app.listen(port);

console.log('Server listening on port: ' + port);
