//
//  SeriesView.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/23/23.
//

import SwiftUI

struct EventView: View {
    var events: [Event]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        ScrollView {
            // TODO: Figure out font and spacing from design picture
            LazyVGrid(columns: columns, spacing: 3) {
                // TODO: Figure out pagination to get the next 20 on scrolling
                ForEach (events, id:\.self) { event in
                    AsyncImage(url: URL(string: event.thumbnail.path + "/standard_large." + event.thumbnail.extension))
                }
            }
        }
    }
}

#Preview {
    EventView(events: [])
}
