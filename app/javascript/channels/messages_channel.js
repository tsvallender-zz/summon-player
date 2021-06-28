import consumer from "./consumer"

let roomname = readCookie('username');

consumer.subscriptions.create({ channel: "MessagesChannel", room: roomname}, {
  connected() {
    console.log("Connected to room " + roomname)
  },

  disconnected() {
    console.log("Disconnected from Action Cable");
  },

  received(data) {
    switch (data.type) {
      case "message":
        // Display new message if chat open
        let chatFrame = document.getElementById("chat-" + data.message.chat_id);
        let messagesFrame = document.getElementById("messages");
        if (chatFrame && data.message.from_id != parseInt(readCookie('user_id'))) {
          fetch('/messages/'+data.message.id)
            .then(res=> res.text() )
            .then(data => messagesFrame.innerHTML += data);
        }
        break;
      default:
        console.log("Received unknown data:", data);
    }
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