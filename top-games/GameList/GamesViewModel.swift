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
        
        private let networkService: NativeRequestable
        
        private var disposables = Set<AnyCancellable>()
        
        init(networkService: NativeRequestable = NativeRequestable(),
             scheduler: DispatchQueue = DispatchQueue(label: "GamesViewModel")) {
            
            self.networkService = networkService
            
            $searchedName
              // 3
              .dropFirst(1)
              // 4
              .debounce(for: .seconds(0.5), scheduler: scheduler)
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
                    self.games = response.results
                    print("got my response here \(response)")
                }
                .store(in: &disposables)
        }
    }
}

struct GameViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
