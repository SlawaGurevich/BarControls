//
//  MusicControllerObserver.swift
//  BarControls
//
//  Created by Slawa on 01.03.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Foundation

class MusicControllerObserver {
    static let shared = MusicControllerObserver()
    
    private init() {}
    
    var timer: Timer?
    
    func start() {
        if timer != nil {
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            MusicController.shared.updateData()
        })
    }
    
    func stop() {
        if let timer = timer {
            timer.invalidate()
        }
    }
}
