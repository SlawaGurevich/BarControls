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
    
    var isPlaying: Bool
    var isShuffling: Bool
    var repeatMode: String

    init(playing: Bool, shuffling: Bool, repeatMode: String) {
        self.isPlaying = playing
        self.isShuffling = shuffling
        self.repeatMode = repeatMode
        return
    }
}
