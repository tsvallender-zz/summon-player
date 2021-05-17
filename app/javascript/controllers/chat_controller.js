import { Controller } from "stimulus"

export default class extends Controller {
    connect() {
        console.log("Connected to chat_controller", this.element);
        this.scrollToBottom(document.getElementById("messages"));
    }

    send() {
        // TODO: Validate message
        // let input = document.getElementById("message_text");
        // input.value = "";
    }

    scrollToBottom(frame) {
        frame.scrollTo(0, frame.scrollHeight);
    }
}