//
//  CharacterListViewModel.swift
//  MarvelCharacters
//
//  Created by ali rahal on 13/07/2023.
//

import Foundation
import Combine
import SwiftUI

class CharactersListViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    private let networkService: NetworkClient?
    @Published var charactersData: [CharacterData] = []
    @Published private(set) var state: LoadingState<LoadedViewModel> = .idle
    @Published var showErrorAlert = false
    private var offset: Int = 0
    
    init(networkService: NetworkClient? = nil) {
        self.networkService = networkService
    }
    
    func incrementOffset() {
        self.offset += 100
    }
    
    func loadData(loadMore: Bool? = false) {
        guard state != .loading else {
            return
        }
        state = .loading
        if let loadMore = loadMore, loadMore == true {
            self.incrementOffset()
        }
        let networkService = DefaultNetworkServiceFactory.makeNetworkService(offset: offset)
        cancellable = networkService.fetchData().sink { [weak self] completion in
            if case .failure(let error) = completion {
                DispatchQueue.main.async {
                    self?.showErrorAlert = true
                    self?.state = .failed(ErrorViewModel(message: error.localizedDescription))
                }
                
            }
        } receiveValue: { [weak self] (result: Result<CharactersResponse, ErrorViewModel>) in
            switch result {
            case .success(let response):
                let articles = response.data.results ?? []
                if articles.count != 0 {
                    let articlesData = articles.map { CharacterData(id: $0.id, title: $0.name, caption: $0.description, imageURL: $0.thumbnail.completeURL)
                    }
                    print(articlesData)
                    DispatchQueue.main.async {
                        self?.charactersData = articlesData
                        self?.state = .success(LoadedViewModel(id: UUID().uuidString, charactersData: articlesData))
                    }
                }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        
    }

extension CharactersListViewModel {
    struct CharacterData: Identifiable, Equatable {
        let id: Int?
        let title: String?
        let caption: String?
        let imageURL: URL?
    }
    
    struct LoadedViewModel: Equatable {
        let id: String
        let charactersData: [CharacterData]
        
        static func == (lhs: CharactersListViewModel.LoadedViewModel, rhs: CharactersListViewModel.LoadedViewModel) -> Bool {
            lhs.id == rhs.id
        }
    }
}
