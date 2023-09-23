//
//  CharacterProfileView.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/22/23.
//

import SwiftUI

struct CharacterProfileView: View {
    @ObservedObject var connectionManager: ConnectionManager
    let character: Character
    
    @State var selected = 0
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(.white)
                    .shadow(radius: 1)
                VStack(alignment: .leading) {
                    HStack {
                        Text(character.name)
                        Spacer()
                        AsyncImage(url: URL(string: character.thumbnail.path + "/standard_medium." + character.thumbnail.extension))
                            .clipShape(Circle())
                    }
                    Text(character.description != "" ? character.description : "No description provided.")
                        .lineLimit(2)
                        .font(.subheadline)
                }
                .padding()
            }
            .padding()
            
            HStack {
                Button(action: {selected = 0}, label: {
                    VStack {
                        // Change the image based on whether the button has been selected or not
                        Image(systemName: selected == 0 ? "book.fill" : "book")
                        Text(String(connectionManager.comicResults.count))
                    }
                })
                .padding(30)
                Button(action: {selected = 1}, label: {
                    VStack {
                        Image(systemName: selected == 1 ? "tv.fill" : "tv")
                        Text(String(connectionManager.seriesResults.count))
                    }
                })
                .padding(30)
            }
            .foregroundColor(.primary)
            
            if (selected == 0) {
                ComicsView(comics: connectionManager.comicResults)
            } else {
                SeriesView(series: connectionManager.seriesResults)
            }
        }
        .onAppear {
            self.connectionManager.fetchComicData(character.id)
            self.connectionManager.fetchSeriesData(character.id)
        }
    }
    
}

#Preview {
    CharacterProfileView(connectionManager: ConnectionManager(), character: Character(id: 0, name: "He-Man", description: "Strong Guy", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/a0/4ce18a834b7f5", extension: "jpg")))
}
