import { Controller } from "stimulus"

export default class extends Controller {
    connect() {
        const m = document.getElementById('messages');
        m.scrollTo(0, m.scrollHeight);
        const config = {childList: true, subTree: true };
        const callback = function(mutationsList, observer) {
            m.scrollTo(0, m.scrollHeight);
        };
        const observer = new MutationObserver(callback);
        observer.observe(m, config);
    }

    send() {
        // TODO: Validate message
    }
}