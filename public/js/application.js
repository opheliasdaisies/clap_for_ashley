var scheme   = "ws://";
var uri      = scheme + window.document.location.host + "/faye";
var ws       = new WebSocket(uri);

ws.onmessage = function(message) {

  var audio = $("audio")[0];
  var message_div = "<div id='message'>"
  var clap_div = "<div id='clap'>"
  var div_close = "</div>"
  var attribute = "<h2> - wisdom from ashley williams and friends</h2>"

  function clap(message) {
    var data = JSON.parse(message.data);
    console.log("Ashley just tweeted: " + data);
    $("#message").replaceWith(message_div + "<h2>" + data + "</h2>" + attribute + div_close);
    $("#clap").replaceWith(clap_div + "<img src='/images/clap.gif' />" + div_close);
    audio.play();
    setTimeout(hide, 10000);
  };

  function hide() {
    $("#message").replaceWith(message_div + "<h2>" + "Sit patiently, and wait for Ashley to tweet" + "</h2>" + div_close);
    $("#clap").replaceWith(clap_div + div_close);
  };

  clap(message);
};