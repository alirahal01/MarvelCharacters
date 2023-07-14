//
//  CharacterRow.swift
//  MarvelCharacters
//
//  Created by ali rahal on 14/07/2023.
//

import SwiftUI

struct CharacterRow: View {
    let character: CharactersListViewModel.CharacterData
    
    var body: some View {
        HStack {
            if let imageURL = character.imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "􀏅")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading) {
                Text(character.title ?? "")
                    .font(.subheadline)
            }
            .padding(5)
        }
        .listRowSeparator(.hidden)
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        let character: CharactersListViewModel.CharacterData = CharactersListViewModel.CharacterData(id: 123, title: "TEST", caption: "TEST", imageURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"))
        CharacterRow(character: character)
    }
}
