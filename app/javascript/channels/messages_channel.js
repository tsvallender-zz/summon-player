import consumer from "./consumer"

consumer.subscriptions.create({ channel: "MessagesChannel", room: window.location.pathname}, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to " + window.location.pathname)
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data);
    document.getElementById('messages').innerHTML += data.message;
  }
});
