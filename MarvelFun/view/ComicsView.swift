//
//  ComicsView.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/22/23.
//

import SwiftUI

struct ComicsView: View {
    var comics: [Comic]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        ScrollView {
            // TODO: Figure out font and spacing from design picture
            LazyVGrid(columns: columns, spacing: 3) {
                // TODO: Figure out pagination to get the next 20 on scrolling
                ForEach (comics, id:\.self) { comic in
                    AsyncImage(url: URL(string: comic.thumbnail.path + "/standard_large." + comic.thumbnail.extension))
                }
            }
        }
    }
}

#Preview {
    ComicsView(comics: [])
}
