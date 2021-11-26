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
                if viewModel.isLoading {
                    loadingIndicator
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Search a Game")
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
                GameCardView(imageUrlString: game.background_image, releasedDate: game.released, title: game.name, platforms: game.platforms, rating: game.rating, metacritic: game.metacritic)
                    .onAppear {
                        if viewModel.games.last == game {
                            viewModel.fetchNextPageIfPossible()
                        }
                    }
            }
        }
    }
    
    var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game(id: 1, name: "Sample", platforms: [PlatformContainer](), background_image: nil, released: nil, rating: nil, metacritic: nil)
        let viewModel = GamesView.ViewModel()
        viewModel.games = [game]
        
        return GamesView(viewModel: viewModel)
    }
}
