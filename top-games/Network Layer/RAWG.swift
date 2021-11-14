//
//  Environment.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-08-20.
//

import Foundation

public enum RAWG: String, CaseIterable {
    case development
}

extension RAWG {
    var dataServiceBaseUrl: String {
        switch self {
        case .development:
            return "https://api.rawg.io/api"
        }
    }
}
