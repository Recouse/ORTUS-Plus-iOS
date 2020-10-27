//
//  LectureItemView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/26/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import SwiftUI

struct LectureItemView: View {
    let lecture: Lecture
    
    var body: some View {
        HStack {
            Color.green
                .cornerRadius(3)
                .frame(width: 4)
            
            Spacer(minLength: 5)
            
            Text(lecture.name)
                .font(.caption)
                .lineLimit(1)
            
            Spacer(minLength: 5)
            
            Text(lecture.timeFromParsed)
                .font(.caption)
        }.frame(minWidth: .greatestFiniteMagnitude, maxWidth: .greatestFiniteMagnitude)
    }
}
