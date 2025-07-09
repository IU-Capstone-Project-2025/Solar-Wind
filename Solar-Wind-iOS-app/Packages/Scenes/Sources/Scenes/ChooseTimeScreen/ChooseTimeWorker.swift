//
//  ChooseTimeWorker.swift
//  Scenes
//
//  Created by Даша Николаева on 22.06.2025.
//

import Foundation

final class ChooseTimeWorker {
    func save(_ selectedDays: [Int]) {
        UserDefaults.standard.set(selectedDays, forKey: "selectedWeekdays")
    }
}
