//
//  String.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/11/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

extension String {
    // Source https://stackoverflow.com/a/47230632/7844080
    var htmlToAttributedString: NSAttributedString? {
        let data = Data(self.utf8)
        
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func generatePinAuthURL(withToken token: String) -> URL? {
        let string = "\(Global.Server.pinAuthURL)?module=PINAuth&locale=en&token=\(token)&goto=\(self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        
        return URL(string: string)
    }
    
    func format(_ arguments: CVarArg...) -> Self {
        String(format: self, arguments)
    }
}
