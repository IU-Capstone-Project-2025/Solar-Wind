//
//  Days.swift
//  CommonUI
//
//  Created by Даша Николаева on 02.07.2025.
//

import SwiftUI

public struct DaysView: SwiftUI.View, HeightReporting {
    let days: [String]
    
    public var onHeightChange: ((CGFloat) -> Void)?
    public var onCenterXChange: ((CGFloat) -> Void)?
    
    public init(days: [String]) {
        self.days = days
    }
    
    var backgroundColor: Color = Color(UIColor.orangeColor)
    public var body: some SwiftUI.View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: HeightPreferenceKey.self, value: geo.size.height)
                        .preference(key: CenterXPreferenceKey.self, value: geo.frame(in: .global).midX)
                }
            )
            .onPreferenceChange(HeightPreferenceKey.self) { height in
                DispatchQueue.main.async {
                    onHeightChange?(height)
                }
            }
            .onPreferenceChange(CenterXPreferenceKey.self) { centerX in
                DispatchQueue.main.async {
                    onCenterXChange?(centerX)
                }
            }

    }
    
    private var content: some SwiftUI.View {
        HStack {
            ForEach(days, id: \.self) { day in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(backgroundColor)
                        .frame(width: 50, height: 60)
                    Text(day)
                        .font(Font(UIFont.size16Medium))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 0.5)
            }
        }
    }
    
    private struct HeightPreferenceKey: PreferenceKey {
        static let defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    private struct CenterXPreferenceKey: PreferenceKey {
        static let defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }

}
