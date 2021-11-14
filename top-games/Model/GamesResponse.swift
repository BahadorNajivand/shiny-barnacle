//
//  Game.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-07-14.
//

import Foundation

public struct GamesResponse: Codable {
    public let count: Int
    public let previous: String?
    public let next: String?
    public let results: [Game]
}

public struct Game: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let platforms: [PlatformContainer]
    public let background_image: String?
    public let released: String?
}

public struct PlatformContainer: Codable {
    public let platform: Platform
}

public struct Platform: Codable {
    public let id: Int
    public let name: String
}

public struct Genre: Codable {
    public let id: Int
    public let name: String
}
