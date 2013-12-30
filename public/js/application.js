var scheme   = "ws://";
var uri      = scheme + window.document.location.host + "/faye";
var ws       = new WebSocket(uri);

ws.onmessage = function(message) {

  function clap(message) {
    var data = JSON.parse(message.data);
    console.log("Ashley just tweeted: " + data);
    var audio = $("audio")[0];
    $("#message").replaceWith("<div id='message'><h2>" + data + "</h2></div>");
    $("#clap").replaceWith("<div id='clap'>" + "<img src='/images/clap.gif' />" + "</div>");
    audio.play();
    setTimeout(hide, 9000);
  };

  function hide() {
    $("#message").replaceWith("<div id='message'><h2>" + "Sit patiently, and wait for Ashley to tweet" + "</h2></div>");
    $("#clap").replaceWith("<div id='clap'></div>");
  };

  clap(message);
};