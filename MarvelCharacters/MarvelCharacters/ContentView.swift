//
//  ContentView.swift
//  MarvelCharacters
//
//  Created by ali rahal on 13/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: CharactersListViewModel
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        VStack {
            if networkMonitor.isConnected {
                let state = viewModel.state
                switch state {
                case . idle:
                    Color.clear.onAppear(perform: { viewModel.loadData() })
                case .loading:
                    ProgressView()
                        .imageScale(.large)
                case .success(let loadingViewModel):
                    NavigationView {
                        CharacterListView(loadingViewModel: loadingViewModel, loadMoreDataAction: {
                            viewModel.loadData(loadMore: true)
                        })
                    }
                case .failed(let errorViewModel):
                    Color.clear.alert(isPresented: $viewModel.showErrorAlert) {
                        Alert(title: Text("Error"), message: Text(errorViewModel.message), dismissButton: .default(Text("OK")))
                    }
                }
            } else {
                VStack {
                    Text("No Internet Connection")
                }
            }
        }
        .onAppear {
            networkMonitor.start()
        }
        .onDisappear {
            networkMonitor.stop()
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: CharactersListViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
