//
//  Requestable.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-08-20.
//

import Combine
import Foundation

public protocol Requestable {
    var requestTimeOut: Float { get }
    
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
