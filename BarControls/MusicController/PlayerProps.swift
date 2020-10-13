//
//  PlayerProps.swift
//  BarControls
//
//  Created by Slawa on 24.03.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Foundation

class PlayerProps: Equatable {
    static func == (lhs: PlayerProps, rhs: PlayerProps) -> Bool {
        return lhs.isPlaying == rhs.isPlaying && lhs.isShuffling == rhs.isShuffling && lhs.repeatMode == rhs.repeatMode
    }
    
    var isPlaying: Bool {
        didSet {
            if oldValue != isPlaying {
                NotificationCenter.post(name: .PlayerPropsDidChange)
            }
        }
    }
    
    var isShuffling: Bool {
       didSet {
           if oldValue != isShuffling {
               NotificationCenter.post(name: .PlayerPropsDidChange)
           }
       }
   }
    
    var repeatMode: String {
       didSet {
           if oldValue != repeatMode {
               NotificationCenter.post(name: .PlayerPropsDidChange)
           }
       }
   }

    init(playing: Bool, shuffling: Bool, repeatMode: String) {
        self.isPlaying = playing
        self.isShuffling = shuffling
        self.repeatMode = repeatMode
        return
    }
}
