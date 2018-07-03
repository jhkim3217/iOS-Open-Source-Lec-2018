const net = require('net');

var clientList = [];

var server = net.createServer(socket => {
   // Connection Event
   console.log('Client Connected from : ', socket.remoteAddress);

   sendColor();
   var timer;

   function sendColor() {
      // 임의의 시간 후에 R/G/B 값을 소켓에 쓰기
      let random = Math.random() * 10;

      timer = setTimeout(() => {
         let r = Math.floor(Math.random() * 255);
         let g = Math.floor(Math.random() * 255);
         let b = Math.floor(Math.random() * 255);

         let color = { red: r, green: g, blue: b };
         let data = JSON.stringify(color);

         if ( socket ) {
            console.log(`writing ${r},${g},${b}`);
            socket.write(data);
            sendColor();
         }
      }, random * 1000);
   }

   socket.on('error', (err) => {
      clearTimeout(timer);
      console.log('error');
   });

   socket.on('data', (data) => {
   });

   socket.on('end', () => {
      clearTimeout(timer);
      console.log('Connection end')
   });
});

server.listen(3000);