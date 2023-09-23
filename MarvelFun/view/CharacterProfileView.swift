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
                    .shadow(radius: 3)
                VStack(alignment: .leading) {
                    HStack {
                        Text(character.name)
                        Spacer()
                        AsyncImage(url: URL(string: character.thumbnail.path + "/standard_large." + character.thumbnail.extension))
                            .clipShape(Circle())
                    }
                    // TODO: Figure out how to limit to 100 characters
                    Text(character.description)
                    
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
                .foregroundColor(.primary)
                Button(action: {selected = 1}, label: {
                    VStack {
                        Image(systemName: selected == 1 ? "tv.fill" : "tv")
                        Text("12")
                    }
                })
                .foregroundColor(.primary)
            }
            if (selected == 0) {
                ComicsView(comics: connectionManager.comicResults)
            } else {
                EpisodesView()
            }
        }
        .onAppear {
            self.connectionManager.fetchComicData(character.id)
        }
    }
    
}

#Preview {
    CharacterProfileView(connectionManager: ConnectionManager(), character: Character(id: 0, name: "He-Man", description: "Strong Guy", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/a0/4ce18a834b7f5", extension: "jpg")))
}
