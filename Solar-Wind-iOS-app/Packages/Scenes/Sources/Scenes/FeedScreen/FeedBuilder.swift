//
//  FeedBuilder.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import UIKit

final class FeedBuilder {
    @MainActor public static func build() -> UIViewController {
        let vc = FeedViewController()
        return vc
    }
}
