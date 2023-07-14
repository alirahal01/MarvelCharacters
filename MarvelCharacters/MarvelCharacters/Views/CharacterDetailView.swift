//
//  CharacterDetailView.swift
//  MarvelCharacters
//
//  Created by ali rahal on 15/07/2023.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: CharactersListViewModel.CharacterData
    
    var body: some View {
        VStack {
            // Display the details of the selected character
            // Modify this part based on your desired layout and content
            
            Text(character.title ?? "")
                .font(.title)
            
            Text(character.caption ?? "")
                .font(.body)
            
            if let imageURL = character.imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "􀏅")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
        }
        .padding()
    }
}

//struct CharacterDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterDetailView()
//    }
//}
