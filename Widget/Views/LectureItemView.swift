//
//  LectureItemView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/26/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import SwiftUI

struct LectureItemView: View {
    let date: Date
    let lecture: Lecture
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = LatviaDateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }()
    
    var body: some View {
        HStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 3)
                .frame(maxWidth: 4, maxHeight: .greatestFiniteMagnitude, alignment: .center)
                .foregroundColor(.green)
            
            VStack(alignment: .leading) {
                Text(lecture.name)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .font(.caption)
                
                if Date().day == date.day {
                    (Text(lecture.timeFromParsed) + Text(" - ") + Text(lecture.timeTillParsed))
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    (Text(date, formatter: dateFormatter) + Text(", ") + Text(lecture.timeFromParsed) + Text(" - ") + Text(lecture.timeTillParsed))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
        }
        .padding([.leading, .trailing])
        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
    }
}
