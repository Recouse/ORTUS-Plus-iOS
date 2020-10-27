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
        HStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 3)
                .frame(maxWidth: 4, maxHeight: .greatestFiniteMagnitude, alignment: .center)
                .foregroundColor(.orange)
            
            VStack(alignment: .leading) {
                Text(event.title)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .font(.caption)
                
                Text(event.allDayEvent ? "all-day" : event.timeParsed)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding([.leading, .trailing])
        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
    }
}
