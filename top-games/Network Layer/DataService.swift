//
//  DataService.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-08-20.
//

import Foundation
import Combine

protocol DataServiceable {
    func searchGames(request: GameRequest) -> AnyPublisher<GamesResponse, NetworkError>
}

class DataService: DataServiceable {
    
    private let apiKey: String = "82d62277928745f69f94b40dc4c0836d"
    
    private var networkRequest: Requestable
    private var rawg: RAWG = .development
    
  // inject this for testability
    init(networkRequest: Requestable, rawg: RAWG) {
        self.networkRequest = networkRequest
        self.rawg = rawg
    }

    func searchGames(request: GameRequest) -> AnyPublisher<GamesResponse, NetworkError> {
        let endpoint = DataServiceEndpoints.searchGames(request: request)
        let request = endpoint.createRequest(queryItems:
                                                [URLQueryItem(name: "key", value: apiKey),
                                                 URLQueryItem(name: "search", value: request.name)],
                                             rawg: self.rawg)
        return self.networkRequest.request(request)
    }
  
}

public struct GameRequest: Encodable {
    public let name: String
}
