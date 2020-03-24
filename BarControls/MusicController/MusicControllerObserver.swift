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
    
    var timer: Timer?
    
    func start() {
        if timer != nil {
            return
        }
        
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
//            MusicController.shared.updateData()
//        })
//        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(runUpdate), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {[weak self] (timer) in
            self?.runUpdate()
        })
    }
    
    func runUpdate() {
        MusicController.shared.updateData()
    }
    
    func stop() {
        if let timer = timer {
            timer.invalidate()
        }
    }
}
