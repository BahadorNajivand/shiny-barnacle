//
//  ServiceEndpoints.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-08-20.
//

import Foundation

public typealias Headers = [String: String]

// if you wish you can have multiple services like this in a project
enum DataServiceEndpoints {

  // organise all the end points here for clarity
    case searchGames(request: GameRequest)
    
  // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
  //specify the type of HTTP request
    var httpMethod: HttpMethod {
        switch self {
        case .searchGames:
            return .GET
        }
    }
    
  // compose the NetworkRequest
    func createRequest(queryItems: [URLQueryItem], rawg: RAWG) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        var urlComponents = URLComponents(string: getURL(from: rawg))!
        urlComponents.queryItems = queryItems
        return NetworkRequest(url: urlComponents.url!.absoluteString, headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
  // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        default:
            return nil
        }
    }
    
  // compose urls for each request
    func getURL(from rawg: RAWG) -> String {
        let baseUrl = rawg.dataServiceBaseUrl
        switch self {
        case .searchGames:
            return "\(baseUrl)/games"
        }
    }
}
