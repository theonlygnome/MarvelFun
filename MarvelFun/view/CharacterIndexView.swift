//
//  ContentView.swift
//  MarvelFun
//
//  Created by Naomi Anderson on 9/22/23.
//

import SwiftUI

struct CharacterIndexView: View {
    @ObservedObject var connectionManager = ConnectionManager()
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                // TODO: Figure out font and spacing from design picture
                LazyVGrid(columns: columns, spacing: 3) {
                    // TODO: Figure out pagination to get the next 20 on scrolling
                    ForEach (connectionManager.characterResults, id:\.self) { character in
                        NavigationLink(destination: CharacterProfileView(connectionManager: connectionManager, character: character)) {
                            ZStack(alignment: .bottomLeading) {
                                AsyncImage(url: URL(string: character.thumbnail.path + "/standard_large." + character.thumbnail.extension))
                                Text(character.name)
                                    .foregroundStyle(.white)
                                    .font(.footnote)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding(10)
                            }
                        }
                        // Hide the 'back' text on the subview backbutton to just show the chevron
                        .navigationTitle("")
                    }
                    ProgressView()
                        .progressViewStyle(.circular)
                        .onAppear {
                            self.connectionManager.loadMoreCharacters()
                        }
                }
            }
        }
        .onAppear {
            self.connectionManager.fetchCharacterData()
        }
    }
}

#Preview {
    CharacterIndexView()
}
