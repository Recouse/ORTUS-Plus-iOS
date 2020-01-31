//
//  CourseJS.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 31/01/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import Foundation

struct CourseJS {
    static let script = """
    ready(function() {
        var pinTextField = document.getElementById("PIN");
      
        if (pinTextField) {
            window.webkit.messageHandlers.courseHandler.postMessage({ key: "Logging In" });
            pinTextField.value = "%@";
            LoginSubmit("Sign in");
        } else {
            window.webkit.messageHandlers.courseHandler.postMessage({ key: "loggedIn" });
        }
    });

    function ready(fn) {
        if (document.readyState != 'loading'){
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
    """
}
