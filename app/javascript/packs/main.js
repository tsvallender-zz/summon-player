function messagesButton() {
    let frame = document.getElementById("messagesFrame");
    if (frame.style.display == "none" || getComputedStyle(frame).display == "none") {
        frame.style.display = "block";
    } else {
        frame.style.display = "none";
    }
}

window.onload = function() {
    let button = document.getElementById("messagesFrameButton");
    if (button != null) {
        button.addEventListener("click", messagesButton);
    }
}