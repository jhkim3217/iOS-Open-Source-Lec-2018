const express = require('express');
const app = express();
app.listen(3000, () => {
   console.log('server is running @3000');
});

app.get('/', (req, res) => {
   res.sendFile(__dirname + "/index.html");
});

const WebSocket = require('ws');

const ws = new WebSocket.Server({ port: 8080 });

ws.on('open', () => {
   console.log('Open!');
});

ws.on('connection', socket => {
   console.log('connected!');
   socket.on('message', message => {
      console.log('>>', message.toString());

      let str = JSON.stringify(message);
      console.log('str :', str);

      // socket.send(message);
      ws.clients.forEach((client) => {
         if (client.readyState === WebSocket.OPEN && client != socket) {
            client.send(message);
         }
      });
   });
});