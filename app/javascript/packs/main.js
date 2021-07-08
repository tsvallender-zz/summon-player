function messagesButton() {
    let frame = document.getElementById("messagesFrame");

    if (frame.style.display == "none" || getComputedStyle(frame).display == "none") {
        frame.style.display = "block";
    } else {
        frame.style.display = "none";
    }
}

window.onload = function() {
    addButtonListeners();
    document.addEventListener('turbo:load', addButtonListeners);
    document.addEventListener('turbo:submit-end', clearMessageInput);
}

function addButtonListeners() {
    let button = document.getElementById("messagesFrameButton");
    if (button != null) {
        button.addEventListener("click", messagesButton);
    }
    let chatButton = document.getElementById("chatButton");
    if (chatButton != null) {
        chatButton.addEventListener("click", messagesButton);
    }  
}

function clearMessageInput() {
    let input = document.getElementById("message_text");
    if (input) {
        input.value = "";
    }
}