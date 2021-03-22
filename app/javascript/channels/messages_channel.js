import consumer from "./consumer"

let path = window.location.pathname.split("/");
let roomname = path.pop();

consumer.subscriptions.create({ channel: "MessagesChannel", room: roomname}, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to room " + roomname)
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    document.getElementById('messages').innerHTML += data.message;
  }
});
