//
//  Int+Music-Bar.swift
//  Music Bar
//
//  Created by Musa Semou on 26/11/2019.
//  Copyright © 2019 Musa Semou. All rights reserved.
//

import Foundation

extension Int {
    var intToLiteralDuration: String {
        let minutes = Int(self / 60)
        let seconds = self % 60 < 10 ? "0\(self % 60)" : "\(self % 60)"
        
        return "\(minutes):\(seconds)"
    }
}
