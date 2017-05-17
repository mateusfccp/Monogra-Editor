var compression = require('compression');
var cors = require('cors');
var express = require('express');
var jsonServer = require('json-server');

// Return a express server
var server = express();

server.use(compression());
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