var jsonServer = require('json-server');
var express = require('express');
var cors = require('cors');

// Return a express server
var server = express();

server.use('/', express.static('public'));

// Set default middlewares (logger, static, cors and no-cache)
server.use('/api', cors());
server.use('/api', jsonServer.router('public/dummy.json'));

server.get('/', function(req, res) {
    res.send('Hello World!');
});

server.listen(process.env.PORT || 3000, function() {
    console.log('Starting server!');
});