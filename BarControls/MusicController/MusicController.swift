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
    
    var currentTrack: Track? {
        didSet {

            NotificationCenter.post(name: .TrackDataDidChange)
        }
    }
    
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
    
    func getTrackData() {
        // Update current track
        NSAppleScript.run(code: NSAppleScript.appleScripts.GetTrackData.rawValue) { (success, output, errors) in
            if success {
                // Get the new track
                let newTrack = Track(fromList: output!.listItems())
                self.currentTrack = newTrack
            }
        }
    }
}
