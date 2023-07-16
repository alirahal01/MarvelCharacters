//
//  CharacterListView.swift
//  MarvelCharacters
//
//  Created by ali rahal on 14/07/2023.
//

import SwiftUI

struct CharacterListView: View {
    let loadingViewModel: CharactersListViewModel.LoadedViewModel
    @State private var selectedCharacter: CharactersListViewModel.CharacterData? = nil // State variable to track the selected character
    let loadMoreDataAction: () -> Void // Closure property to trigger action when last element is reached
    var body: some View {
        NavigationView {
            List {
                ForEach(loadingViewModel.charactersData.indices, id: \.self) { index in
                    Button(action: {
                        selectedCharacter = loadingViewModel.charactersData[index] // Set the selected character
                    }) {
                        CharacterRow(character: loadingViewModel.charactersData[index])
                    }
                    .background(
                        NavigationLink(
                            destination: CharacterDetailView(character: loadingViewModel.charactersData[index]),
                            isActive: Binding<Bool>(
                                get: { selectedCharacter ==  loadingViewModel.charactersData[index]},
                                set: { _ in }
                            )
                        ) {
                            EmptyView()
                        }
                            .opacity(0) // Hide the navigation link
                    )
                    .onAppear {
                        if index == loadingViewModel.charactersData.count - 1 {
                            loadMoreDataAction()
                        }
                    }
                }
            }
        }
        .onAppear {
            selectedCharacter = nil
        }
        .navigationTitle("Marvel Characters")
    }
}


//struct CharacterListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let character: CharactersListViewModel.CharacterData = CharactersListViewModel.CharacterData(id: 123, title: "TEST", caption: "TEST", imageURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"))
//        let character2: CharactersListViewModel.CharacterData = CharactersListViewModel.CharacterData(id: 123, title: "TEST", caption: "TEST", imageURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"))
//        let loadingViewModel = CharactersListViewModel.LoadedViewModel(id: "123", charactersData: [character,character2])
//        CharacterListView(loadingViewModel: loadingViewModel, didSelectCharacter: <#(CharactersListViewModel.CharacterData) -> Void#>)
//    }
//}
