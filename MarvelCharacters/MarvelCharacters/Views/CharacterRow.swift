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
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: character.imageURL, content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipped()
                }) {
                    ProgressView()
                        .scaleEffect(2.0)
                        .frame(height: 100)
                        
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading) { // Set alignment to .center
                    VStack(alignment: .leading) {
                        Text(character.title ?? "")
                            .font(.title)
                    }
                }
                .frame(maxWidth: .infinity) // Add maxWidth to expand the text horizontally
            }
        }
    }

}
struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        let character: CharactersListViewModel.CharacterData = CharactersListViewModel.CharacterData(id: 123, title: "TEST", caption: "TEST", imageURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"))
        CharacterRow(character: character)
    }
}
