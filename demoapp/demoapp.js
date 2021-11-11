// Thanks to Andi Grabner (https://github.com/grabnerandi/simplenodeservice) 
// for the original application concept and code!

var port = process.env.PORT || 8080,
    http = require('http'),
    fs = require('fs'),
	os = require('os'),
	path = require('path'),
	urlModule = require('url'),
	html = fs.readFileSync(__dirname + '/index.html').toString();

// ======================================================================
// Here are some global config entries that change the behavior of the app
// ======================================================================
var featureNumber = 1;
var minSleep = 200;
var requestCount = 0;
var failInvokeRequestPercentage = 0;

// ======================================================================
// does some init checks and sets variables!
// ======================================================================
var init = function(newFeatureNumber) {

	// here are some "features" we simulate for different features. 
	// features are identified via Env Variable FEATURE_NUMBER;

	if(newFeatureNumber != null) {
		featureNumber = parseInt(newFeatureNumber);
	}
	else if(process.env.FEATURE_NUMBER && process.env.FEATURE_NUMBER != null) {
		featureNumber = parseInt(process.env.FEATURE_NUMBER);
    }

	switch(featureNumber) {
		case 2:
			minSleep = 200;
			failInvokeRequestPercentage = 50;
			break;
		case 3: 
			minSleep = 1000;
			failInvokeRequestPercentage = 0;
			break;
		default:
			// everything normal here
			minSleep = 200;
			failInvokeRequestPercentage = 0;		
			break;
	}

	console.log("Init: " + featureNumber + "/" + failInvokeRequestPercentage);
} 

// ======================================================================
// Background colors for our app depending on the feature
// ======================================================================
var getBackgroundColor = function() {
	switch(featureNumber) {
		case 2:
			backgroundColors = "#FF0000"; // red
			break;
		case 3: 
			backgroundColors = "#FFFF00"; //yellow
			break;
		default:
			backgroundColors = "#73A53E"; //green
			break;
	}
	return backgroundColors;
}

// ======================================================================
// Very inefficient way to "sleep"
// ======================================================================
function sleep(time) {

	//console.log("in sleep. time before"+ time);
	if(time < minSleep) time = minSleep;
	//console.log("in sleep. time after"+ time);
	if(!time) time = minSleep;
	////console.log("in sleep. time after"+ time);
    var stop = new Date().getTime();
	////console.log("in sleep. stop"+ stop);
    while(new Date().getTime() < stop + time) {
        ;
    }
	//console.log("in sleep. done");
}

// ======================================================================
// This is our main HttpServer Handler
// ======================================================================
var server = http.createServer(function (req, res) {

	// debugging
	// console.log(`${req.method} ${req.url}`);
	// parse URL
	const parsedUrl = urlModule.parse(req.url);
	// extract URL path
	let pathname = `.${parsedUrl.pathname}`;
	// based on the URL path, extract the file extension. e.g. .js, .doc, ...
	const extName = path.parse(pathname).ext;
	// mimeMaps file extention to MIME types
	const mimeMap = {
	  '.ico': 'image/x-icon',
	  '.html': 'text/html',
	  '.js': 'text/javascript',
	  '.json': 'application/json',
	  '.css': 'text/css',
	  '.png': 'image/png',
	  '.jpg': 'image/jpeg',
	  '.wav': 'audio/wav',
	  '.mp3': 'audio/mpeg',
	  '.svg': 'image/svg+xml',
	  '.pdf': 'application/pdf',
	  '.doc': 'application/msword'
	};

    if (req.method === 'POST') {
        var body = '';

        req.on('data', function(chunk) {
            body += chunk;
        });

        req.on('end', function() {
            if (req.url === '/') {
                //console.log('Received message: ' + body);
            } else if (req.url = '/scheduled') {
                //console.log('Received task ' + req.headers['x-aws-sqsd-taskname'] + ' scheduled at ' + req.headers['x-aws-sqsd-scheduled-at']);
            }

            res.writeHead(200, 'OK', {'Content-Type': 'text/plain'});
            res.end();
        });
    } else if (req.url.startsWith("/api")) {
		var url = require('url').parse(req.url, true);
		var closeResponse = true;

        // sleep a bit :-)
		var sleeptime = parseInt(url.query["sleep"]);
		if(sleeptime === 0) sleeptime = minSleep;
		//console.log("Sleeptime: " + sleeptime);
		sleep(sleeptime);

		// figure out which API call they want to execute
        var status = "Unknown API Call";
		if(url.pathname === "/api/sleeptime") {
			// Usage: /api/sleeptime?min=1234 
			var sleepValue = parseInt(url.query["min"]);
			if(sleepValue >= 0 && sleepValue <= 10000) minSleep = sleepValue;
			status = "Minimum Sleep Time set to " + minSleep;
		}
		if(url.pathname === "/api/echo") {
			// Usage: /api/echo?text=your text to be echoed!
			status = "Thanks for saying: " + url.query["text"];
		}
		if(url.pathname === "/api/login") {
			// Usage: /api/login?username=your user name 
			status = "Welcome " + url.query["username"];
		}
		if(url.pathname === "/api/invoke") {

			// fail requests if required 
			var returnStatusCode = 200;
			var randNum = Math.floor((Math.random() * 100) + 1);
			if( randNum <= failInvokeRequestPercentage ) {
				returnStatusCode = 500;
			}
			console.log('API randNum = ' + randNum + ' returnStatusCode = ' + returnStatusCode);
			// Usage: /api/invoke?url=http://www.yourdomain.com 
			var urlRequest = url.query["url"];
			status = "Trying to invoke remote call to: " + urlRequest;
			
			var http = null;
			if(urlRequest.startsWith("https")) http = require("https");
			else http = require("http");
			closeResponse = false;
			var options = {
              	host: urlRequest,
              	path: '/'
            };
			var result = http.get(urlRequest, function(getResponse) {
				//console.log('STATUS: ' + getResponse.statusCode);
				//console.log('HEADERS: ' + JSON.stringify(getResponse.headers));

				// Buffer the body entirely for processing as a whole.
				var bodyChunks = [];
				getResponse.on('data', function(chunk) {
					bodyChunks.push(chunk);
				}).on('end', function() {
					var body = Buffer.concat(bodyChunks);
					//console.log('BODY: ' + body);
					status = "Request to '" + url.query["url"] + "' returned with HTTP Status: " + getResponse.statusCode + " and response body length: " + body.length;
					res.writeHead(returnStatusCode, returnStatusCode == 200 ? 'OK' : 'ERROR', {'Content-Type': 'text/plain'});	
					res.write(status);
					res.end();
				}).on('error', function(error) {
					status = "Request to '" + url.query["url"] + "' returned in an error: " + error;
					res.writeHead(returnStatusCode, returnStatusCode == 200 ? 'OK' : 'ERROR', {'Content-Type': 'text/plain'});	
					res.write(status);
					res.end();
					console.log(status);				
					//log(SEVERITY_INFO, status);
				})
			});
		}
		// usage: /api/feature
		// simply returns the feature number as defined in FEATURE_NUMBER env-variable which is specified
		// Usage: /api/feature?newFeatureNumber=1
		// to fake out the feature number
		if(url.pathname === "/api/feature") {
			if (url.query["newFeatureNumber"] && url.query["newFeatureNumber"] != null) {
				var newFeatureNumber = url.query["newFeatureNumber"];
				console.log('Somebody is changing! featureNumber from ' + featureNumber + ' to ' + newFeatureNumber);
				//log(SEVERITY_WARNING, "Somebody is changing! featureNumber from " + featureNumber + " to " + newFeatureNumber);

				init(newFeatureNumber);
			}
			status = "App is Running with feature number: " + featureNumber;
		}

		// usage: /api/causeerror
		if(url.pathname === "/api/causeerror") {
			//console.log("somebody called /api/causeerror");
			status = "We just caused an error log entry"
		}

		// only close response handler if we are done with work!
		if(closeResponse) {
		   res.writeHead(200, 'OK', {'Content-Type': 'text/plain'});	
		   res.write(status);
		   res.end();
		}
	}
	else if (typeof mimeMap[extName] !== 'undefined')
	{
		// read file from file system
		fs.readFile(pathname, function(err, data){
			if(err){
				res.statusCode = 500;
				res.end(`Error getting the file: ${err}.`);
			} else {
				// if the file is found, set Content-type and send data
				res.setHeader('Content-type', mimeMap[extName] || 'text/plain' );
				res.end(data);
			}
		})
	}
	else
	{
		res.writeHead(200, 'OK', {'Content-Type': 'text/html'});

		// replace featureNumber and background color
		var finalHtml = html.replace("BACKGROUND-COLOR", getBackgroundColor()).replace("FEATURE_NUMBER", featureNumber);
        res.write(finalHtml);
        res.end();
	}
	
	requestCount++;
	if(requestCount >= 100) {
		console.log("Just served another 100 requests!");
		requestCount = 0;
	}
});

// first we initialize!
init(null);

// Listen on port 80, IP defaults to 127.0.0.1
server.listen(port);

// Put a friendly message on the terminal
console.log('Server running at http://127.0.0.1:' + port + '/');
console.log("Service is up and running - feed me with data!");