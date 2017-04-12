var jsonServer = require('json-server');
var express = require('express');
var cors = require('cors');

// Return a express server
var server = express();

server.use(express.static('public'))

// Set default middlewares (logger, static, cors and no-cache)
server.use('/api', jsonServer.defaults());
server.use('/api', jsonServer.router('public/dummy.json'));

console.log('Listening at 4000');
server.listen(4000);
