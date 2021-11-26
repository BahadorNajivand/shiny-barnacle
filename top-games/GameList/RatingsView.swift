//
//  RatingsView.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-08-29.
//

import Foundation
import SwiftUI

struct RatingsView: View {
    
    let rating: Float?
    let metacritic: Int?
    
    var body: some View {
        VStack
        {
            HStack {
                if let metacriticValue = metacritic {
                    ZStack {
                      Circle().stroke(.gray, lineWidth: 4)
                        Text(String(metacriticValue))
                    }
                    .frame(width: 40, height: 40)
                }
            }
        }
    }
}
