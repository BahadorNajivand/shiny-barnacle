//
//  GameCardView.swift
//  top-games
//
//  Created by Bahador Najivand on AP 1400-08-24.
//

import SwiftUI
import Foundation

struct GameCardView: View {
    
    let imageUrlString: String?
    let releasedDate: String?
    let title: String
    let platforms: [PlatformContainer]
    let rating: Float?
    let metacritic: Int?
    
    var body: some View {
        VStack {
            
            if let urlString = imageUrlString, let url = URL(string: urlString)
            {
                AsyncImage(
                   url: url,
                   placeholder: { Text("Loading ...").padding(3) },
                   image: { Image(uiImage: $0).resizable() }
                )
               .aspectRatio(contentMode: .fit)
            }

            
            HStack {
                VStack(alignment: .leading) {
                    Text(releasedDate ?? "Unknown")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    Text(title)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    HStack {
                        PlatformsView(paltformContainers: platforms)
                        Spacer()
                        RatingsView(rating: rating, metacritic: metacritic)
                    }
                }
                .layoutPriority(100)
 
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}

struct GameCardView_Previews: PreviewProvider {
    static var previews: some View {
        GameCardView(
            imageUrlString: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg",
            releasedDate: "SwiftUI",
            title: "Drawing a Border with Rounded Corners",
            platforms: [PlatformContainer(platform: Platform(id: 1, name: "PC"))],
            rating: 3.0,
            metacritic: 98
        )
    }
}
