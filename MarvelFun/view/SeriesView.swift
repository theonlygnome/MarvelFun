//
//  SeriesView.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/23/23.
//

import SwiftUI

struct SeriesView: View {
    var series: [Series]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        ScrollView {
            // TODO: Figure out font and spacing from design picture
            LazyVGrid(columns: columns, spacing: 3) {
                // TODO: Figure out pagination to get the next 20 on scrolling
                ForEach (series, id:\.self) { series in
                    AsyncImage(url: URL(string: series.thumbnail.path + "/standard_large." + series.thumbnail.extension))
                }
            }
        }
    }
}

#Preview {
    SeriesView(series: [])
}
