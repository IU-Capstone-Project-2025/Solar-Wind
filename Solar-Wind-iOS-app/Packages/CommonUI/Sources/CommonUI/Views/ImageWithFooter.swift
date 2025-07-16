//
//  ImageWithFooter.swift
//  CommonUI
//
//  Created by Даша Николаева on 30.06.2025.
//

import SwiftUI
import UIKit

public struct ImageWithFooter: SwiftUI.View {
    var image: UIImage
    var name: String
    var city: String
    
    public init(image: UIImage, name: String, city: String) {
        self.image = image
        self.name = name
        self.city = city
    }
    
    public var body: some SwiftUI.View {
        ZStack(alignment: .bottom) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .clipped()
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .clear, location: 0.8),
                    .init(color: .black.opacity(0.7), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            VStack {
                Text(name)
                    .foregroundColor(.white)
                    .font(Font(UIFont.size24Medium))
                    .padding(.bottom, 8)
                    .padding(.horizontal, 8)
                Text(city)
                    .foregroundColor(.white)
                    .font(Font(UIFont.size16Medium))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 8)
            }
            
        }
    }
}
