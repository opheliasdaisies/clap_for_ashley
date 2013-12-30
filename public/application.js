var scheme   = "ws://";
var uri      = scheme + window.document.location.host + "/faye";
var ws       = new WebSocket(uri);

ws.onmessage = function(message) {
  console.log("I received a message");
  console.log(typeof message);
  var data = JSON.parse(message.data);
  $("#message").append(data);
  alert("Ashley tweeted! Clap for Ashley!");
};