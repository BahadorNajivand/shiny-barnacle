//
//  PlatformsView.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-08-29.
//

import Foundation
import SwiftUI

struct PlatformsView: View {
    
    let paltformContainers: [PlatformContainer]
    
    var body: some View {
        VStack
        {
            HStack {
                ForEach(paltformContainers, id: \.platform.id) { platformContainer in
                    switch platformContainer.platform.name {
                        case "PC":
                            Image(systemName: "desktopcomputer")
                        case "PlayStation 4":
                            Image(systemName: "logo.playstation")
                        case "Xbox One":
                            Image(systemName: "logo.xbox")
                        default:
                            EmptyView()
                    }
                }
            }
        }
    }
}
