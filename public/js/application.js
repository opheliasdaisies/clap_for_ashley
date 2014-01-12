var scheme   = "ws://";
var uri      = scheme + window.document.location.host + "/faye";
var ws       = new WebSocket(uri);

ws.onmessage = function(message) {

  var audio = $("audio")[0];
  var message_div = "<div id='message'>"
  var clap_div = "<div id='clap'>"
  var div_close = "</div>"

  function clap(message) {
    var data = JSON.parse(message.data);
    var matcher = /(.*) \- (@.*)$/
    var tweet = matcher.exec(data)[1]
    var user = matcher.exec(data)[2]
    console.log("Just received: " + data);
    if (user == '@ag_dubs' || tweet.indexOf("clapforashley") != -1) {
      $("#message").replaceWith(message_div + "<h2>" + tweet + "</h2>" + "<h3>- " + user + "</h3>" + div_close);
      $(".photo").fadeTo(500, 1);
    }
      // $("#clap").replaceWith(clap_div + "<img src='/images/clap.gif' />" + div_close);
    audio.play();
    setTimeout(hide, 10000);
  };

  function hide() {
    $("#message").replaceWith(message_div + "<h2>" + "Wait for it..." + "</h2>" + div_close);
    $(".photo").fadeTo(1000, 0);
    // $("#clap").replaceWith(clap_div + div_close);
  };

  clap(message);
};