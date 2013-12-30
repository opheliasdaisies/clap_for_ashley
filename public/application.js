var scheme   = "ws://";
var uri      = scheme + window.document.location.host + "/faye";
var ws       = new WebSocket(uri);

ws.onmessage = function(message) {
  // var data = JSON.parse(message.data);
  $("#message").append(message.text);
  alert("Ashley tweeted! Clap for Ashley!");
};