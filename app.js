var compression = require('compression');
var cors = require('cors');
var express = require('express');
var jsonServer = require('json-server');

// Port
server.set('port', (process.env.PORT || 5000));

// Return a express server
var server = express();

server.use(compression());
server.use('/', express.static('public', {
    maxAge: '7d',
    setHeaders: function(res, path) {
        res.setHeader('Cache-Control', 'public, max-age=0');
    }
}));

// Set default middlewares (logger, static, cors and no-cache)
server.use('/api', cors());
server.use('/api', jsonServer.router('public/dummy.json'));

server.get('/', function(req, res) {
    res.send('Hello World!');
});

server.listen(server.get('port'), function() {
  console.log('Node app is running on port ', server.get('port'));
});
