var scheme   = "ws://";
var uri      = scheme + window.document.location.host + "/faye";
var ws       = new WebSocket(uri);

ws.onmessage = function(message) {
  console.log("I received a message");
  var data = JSON.parse(message.data);
  $("#message").replaceWith("<div id='message'>\"" + data + "\"</div>
  ");
  $("#clap").replaceWith("<div id='clap'>" + "<img src='/images/clap.gif' />" + "</div>
  ");
};