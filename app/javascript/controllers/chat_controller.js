import { Controller } from "stimulus"

export default class extends Controller {
    connect() {
        let frame = document.getElementById("messages");
        frame.scrollTo(0, frame.scrollHeight);
    }
}