var params = (new URL(document.location)).searchParams;
var pageModule = params.get("module");

ready(function() {
    var pinTextField = document.getElementById("PIN");

    if (pageModule == "PINAuth" && pinTextField) {
        var pin = "%@";

        if (pin.length != 4) {
            window.webkit.messageHandlers.courseHandler.postMessage({ key: "loggedIn" });
            return;
        }

        window.webkit.messageHandlers.courseHandler.postMessage({ key: "loggingIn" });
        pinTextField.value = pin;
        LoginSubmit("Sign in");
    } else {
        window.webkit.messageHandlers.courseHandler.postMessage({ key: "loggedIn" });
    }
});

function ready(fn) {
    if (document.readyState != 'loading') {
        fn();
    } else if (document.addEventListener) {
        document.addEventListener('DOMContentLoaded', fn);
    } else {
        document.attachEvent('onreadystatechange', function() {
            if (document.readyState != 'loading')
                fn();
        });
    }
}