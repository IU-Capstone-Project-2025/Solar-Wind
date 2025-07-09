//
//  Tags.swift
//  CommonUI
//
//  Created by Даша Николаева on 30.06.2025.
//

import SwiftUI
import UIKit

public struct TagsView: SwiftUI.View {
    var tags: [String] = []
    var backgroundColor: Color = Color(UIColor.orangeColor)
    var textColor: Color = .white
    var cornerRadius: CGFloat = 16
    var padding: CGFloat = 8
    
    public init(tags: [String] = []) {
        self.tags = tags
    }
    @State private var totalHeight = CGFloat.zero
    
    public var body: some SwiftUI.View {
        VStack {
            GeometryReader { geometry in
                generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in g: GeometryProxy) -> some SwiftUI.View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                item(for: tag)
                    .padding([.trailing, .bottom], padding)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func item(for text: String) -> some SwiftUI.View {
        Text(text)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .font(.system(size: 14, weight: .medium))
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(cornerRadius)
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some SwiftUI.View {
        GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
    
    
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        VStack {
            TagsView(tags: ["Йога", "Бег", "Плавание", "Силовые тренировки", "Кроссфит", "Пилатес", "Стретчинг"])
                .padding()
            
            Spacer()
        }
    }
}
