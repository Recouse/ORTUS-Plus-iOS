//
//  EventItemView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/26/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import SwiftUI

struct EventItemView: View {
    let event: Event
    
    var body: some View {
        HStack {
            Text(event.title)
            Text(event.timeParsed)
        }
    }
}
