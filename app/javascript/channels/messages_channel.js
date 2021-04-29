import consumer from "./consumer"

let roomname = readCookie('username');

consumer.subscriptions.create({ channel: "MessagesChannel", room: roomname}, {
  connected() {
    console.log("Connected to room " + roomname)
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Alerts for new messages etc.
  }
});

function readCookie(name) {
	var cookiename = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(cookiename) == 0) return c.substring(cookiename.length,c.length);
	}
	return null;
}