//
//  ContentView.swift
//  MarvelCharacters
//
//  Created by ali rahal on 13/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: CharactersListViewModel
    
    var body: some View {
        let state = viewModel.state
        
        switch state {
        case . idle:
            Color.clear.onAppear(perform: { viewModel.LoadData() })
        case .loading:
            ProgressView()
                .imageScale(.large)
        case .success(let loadingViewModel):
            List {
                ForEach(loadingViewModel.charactersData.indices, id: \.self) { index in
                    let article = loadingViewModel.charactersData[index]
                    HStack {
                        if let imageURL = article.imageURL {
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
                            Text(article.title ?? "")
                                .font(.subheadline)
                        }
                        .padding(5)
                    }
                    .listRowSeparator(.hidden)

                }
                
            }
        case .failed(let errorViewModel):
            Color.clear.alert(isPresented: $viewModel.showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorViewModel.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: CharactersListViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
