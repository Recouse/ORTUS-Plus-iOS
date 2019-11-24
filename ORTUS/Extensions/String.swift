//
//  String.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/11/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation

extension String {
    func generatePinAuthURL(withToken token: String) -> URL? {
        let string = "\(Global.Server.pinAuthURL)?module=PINAuth&locale=en&token=\(token)&goto=\(self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        
        return URL(string: string)
    }
}
