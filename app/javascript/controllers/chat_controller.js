import { Controller } from "stimulus"

export default class extends Controller {
    connect() {
        console.log("Connected to chat_controller", this.element);

        const m = document.getElementById('messages');
        const config = {childList: true, subTree: true };
        const callback = function(mutationsList, observer) {
            m.scrollTo(0, m.scrollHeight);
        };
        const observer = new MutationObserver(callback);
        observer.observe(m, config);
    }

    send() {
        // TODO: Validate message
        // let input = document.getElementById("message_text");
        // input.value = "";
    }
}