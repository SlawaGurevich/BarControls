//
//  MusicController.swift
//  BarControls
//
//  Created by Slawa on 21.02.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Foundation
import AppKit

class MusicController {
    static let shared = MusicController()
    
    // MARK: - Functions
    func runScript(script: String) {
        NSAppleScript.run(code: script, completionHandler: {_,_,_ in})
    }
    
    func playPause() {
        runScript(script: NSAppleScript.appleScripts.PausePlay.rawValue)
    }
    
    func nextTrack() {
        runScript(script: NSAppleScript.appleScripts.NextTrack.rawValue)
    }
    
    func prevTrack() {
        runScript(script: NSAppleScript.appleScripts.PrevTrack.rawValue)
    }
    
    func getCoverArt() {
        NSAppleScript.run(code: NSAppleScript.appleScripts.GetCoverImage.rawValue) { (success, output, errors) in
            if success {
//                self.isPlaying = (output!.data.stringValue == "playing")
            }
        }
    }
}
