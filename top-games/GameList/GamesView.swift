//
//  GamesView.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-07-14.
//
import SwiftUI

struct GamesView: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List{
                searchField
                gamesSection
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Game")
        }
        //.onAppear(perform: )
    }
}

private extension GamesView {
    var searchField: some View {
      HStack(alignment: .center) {
        // 1
          TextField("e.g. Resident Evil", text: $viewModel.searchedName)
      }
    }
    
    var gamesSection: some View {
        Section {
            ForEach(viewModel.games){ game in
                Text(game.name)
                    .padding()
            }
        }
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        //let game = Game(name: "Sample", platforms: [PlatformContainer](), released: nil, rating: nil, metacritic: nil, background_image: nil, id: 1, score: nil, genres: [Genre]())
        let viewModel = GamesView.ViewModel()
        viewModel.games = [Game]()
        
        return GamesView(viewModel: viewModel)
    }
}

