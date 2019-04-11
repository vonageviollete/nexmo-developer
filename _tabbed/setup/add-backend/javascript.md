---
title: JavaScript
language: javascript
---

# How to Create a Backend to Support Your Client-Side App

This tutorial shows you how to define the backend server that will support your client-side app. 

## Prerequisites

This tutorial assumes you have already [added the Client SDK to your app](https://developer.nexmo.com/client-sdk/setup/add-sdk-to-your-app) and have a basic server for your client-side code.

## To add the Nexmo Node SDK to your server

### Install the Node SDK package

In your terminal, navigate to the root of your application directory and install the Nexmo Node SDK from npm:

```bash
npm install nexmo -s
```

### Create a Nexmo Client object on your server

In your server code, require the Nexmo Node SDK and instantiate a client object with your API Key and API Secret. You can find both values on the [Getting Started page](https://dashboard.nexmo.com/getting-started-guide) in your [Nexmo Dashboard](https://dashboard.nexmo.com).

```javascript
const Nexmo = require('nexmo');
const nexmo = new Nexmo({
  apiKey: '1234ABCD',
  apiSecret: '1234567890ABCDEF'
});
```

### Create the Nexmo Application

Next in your server code, use the `create` method to create a new application. Supply a recognizable application name and the URLs of your own `answer` and `event` webhook endpoints.

```javascript
let application_id, private_key;
nexmo.applications.create(
  'New App Name', 
  'voice', 
  'http://example.com/answer', 
  'http://example.com/event', 
  {}, 
  (error, response) => {
    if (error) {
      console.log(error);
    }
    application_id = response.id; 
    private_key = response.keys.private_key;
  });
```

## To add endpoints for your webhooks

To handle incoming calls or events, you will need endpoints on your server containing the logic you want to execute. In Express.js, for example, an `answer` endpoint might be defined with `app.get`:

```javascript
app.get('/answer', function(req, res) {});
```

The `answer` endpoint receives a GET request and `event` receives a POST.

### Add logic to the answer endpoint

The logic that handles incoming calls to your application is defined by a [Nexmo Call Control Object (NCCO)](https://developer.nexmo.com/voice/voice-api/ncco-reference). An NCCO can contain one or more steps which will be executed in sequence. Define the NCCO in your handler and return it as your response body.

```javascript
app.get('/answer', function(req, res) {
  const ncco = [
    {
      action: 'talk',
      voiceName: 'Ivy',
      text: 'Thank you for calling, your lucky number is ' + parseInt(Math.random() * 100) + '. Goodbye.'
    }
  ];
  res.send(ncco);
});
```

## Where next? 

[Add the Client SDK to your app.](https://developer.nexmo.com/client-sdk/setup/add-sdk-to-your-app)

