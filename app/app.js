'use strict';

var config = require('konfig')();
var express = require('express');
var app = express();
var hbs = require('hbs');
//var config = require('./config.json')[process.env.NODE_ENV || 'development'];


hbs.registerHelper('equal', function(lvalue, rvalue, options) {
    if (arguments.length < 3)
        throw new Error("Handlebars Helper equal needs 2 parameters");
    if( lvalue!=rvalue ) {
        return options.inverse(this);
    } else {
        return options.fn(this);
    }
});

app.use(express.static('public'));
app.set('view engine', 'hbs');
hbs.registerPartials(__dirname + '/views/partials');

var elasticsearch = require('elasticsearch');
var client = new elasticsearch.Client({
  host: config.app.elasticsearch_host,
   log: config.app.elasticsearch_log
});

app.get('/_ah/health', function(req, res) {
  res.status(200).send('ok');
  next();
});

app.get('/', function (req, res) {
	var query = req.query.q;
	var page = req.query.page;
	typeof (page - 0);
	var from = 0;
	var items_per_page = config.app.items_per_page;
	if (typeof query == 'undefined') {
		return res.render('index');
	}
	if (typeof page == 'undefined') {
		page = 1;
	}
	if (page > 1) {
		from = items_per_page * (page - 1);
	}
	query = query.replace(/([\!\*\+\&\|\(\)\[\]\{\}\^\~\?\:\"])/g, "\\$1");
	//console.log(query);

	var hits = client.search({
	  index: config.app.elasticsearch_index,
	  type: 'recipe',
	  body: {
	  	from: from,
	  	size: items_per_page,
	    query: {
	      match: {
	        _all: query
	      }
	    }
	  }
	}).then(function (resp) {
	    var hits = resp.hits.hits;
	    var total = resp.hits.total;
	    var pageCount = Math.ceil(total/items_per_page);
	    var next_page = null;
	    var previous_page = null;
	    var previous_url = '?q=' + query;
	    var next_url = '?q=' + query;
	    if (page > 1) {
	    	previous_page = (Number(page) - 1);
	    	if (previous_page > 1) {
	    		previous_url = '?q=' + query + '&page=' + previous_page;
	    	}
	    }
	    if (page < pageCount) {
	    	next_page = (Number(page) + 1);
	    	next_url = '?q=' + query + '&page=' + next_page;
	    }

	    res.render('index', { query: query,
	    	results: hits,
        total: total,
	    	page: page,
	    	previous_page: previous_page,
	    	previous_url: previous_url,
	    	next_page: next_page,
	    	next_url: next_url,
	    	pageCount: pageCount
	    });
      next();
	}, function (err) {
	    console.trace(err.message);
      // const HTTP_SERVER_ERROR = 500;
      // app.use(function(err, req, res, next) {
      //   if (res.headersSent) {
      //     return next(err);
      //   }
      //   return res.status(err.status || HTTP_SERVER_ERROR).render('500');
      // });
	    res.render('index', { query: query, results: null});
	});
});

// [START server]
// Start the server
var server = app.listen(process.env.PORT || 8080, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('App listening at http://%s:%s', host, port);
});
// [END server]
