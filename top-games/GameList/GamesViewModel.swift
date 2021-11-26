//
//  GameViewModel.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-07-14.
//

import Foundation
import SwiftUI
import Combine

extension GamesView {
    class ViewModel: ObservableObject {
        
        @Published var games = [Game]()
        @Published var searchedName: String = ""
        @Published var isLoading = false
        
        private let networkService: NativeRequestable
        
        private var disposables = Set<AnyCancellable>()
        private var nextPageUrl: String?
        
        init(networkService: NativeRequestable = NativeRequestable(),
             scheduler: DispatchQueue = DispatchQueue(label: "GamesViewModel")) {
            
            self.networkService = networkService
            
            $searchedName
              // 3
              .dropFirst(4)
              // 4
              .debounce(for: .seconds(0.8), scheduler: scheduler)
              // 5
              .sink(receiveValue: fetchGames(gameName:))
              // 6
              .store(in: &disposables)
        }
        
        func fetchGames(gameName name: String) {
    
            let gameRequest = GameRequest(name: name)
            
            let service = DataService(networkRequest: NativeRequestable(), rawg: .development)
            
            service.searchGames(request: gameRequest)
                .sink { (completion) in
                    switch completion {
                    case .failure(let error):
                        print("oops got an error \(error.localizedDescription)")
                    case .finished:
                        print("nothing much to do here")
                    }
                } receiveValue: { (response) in
                    DispatchQueue.main.async {
                        self.games = response.results
                        self.nextPageUrl = response.next
                        self.isLoading = response.next == nil ? false : true
                    }
                }
                .store(in: &disposables)
        }
        
        func fetchNextPageIfPossible() {
            
            guard let url = nextPageUrl else {
                return
            }
            
            let nextPageGamesRequest = NextPageGamesRequest(url: url)
            
            let service = DataService(networkRequest: NativeRequestable(), rawg: .development)
            
            service.fetchNextPageGames(request: nextPageGamesRequest)
                .sink { (completion) in
                    switch completion {
                    case .failure(let error):
                        print("oops got an error \(error.localizedDescription)")
                    case .finished:
                        print("nothing much to do here")
                    }
                } receiveValue: { (response) in
                    DispatchQueue.main.async {
                        self.games += response.results
                        self.nextPageUrl = response.next
                        self.isLoading = response.next == nil ? false : true
                    }
                }
                .store(in: &disposables)

         }
    }
}
