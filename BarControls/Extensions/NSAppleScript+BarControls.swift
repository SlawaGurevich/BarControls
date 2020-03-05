//
//  NSAppleScript+BarControls.swift
//  BarControls
//
//  Created by Slawa on 21.02.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Foundation

extension NSAppleScript {
    static func run(code: String, completionHandler: (Bool, NSAppleEventDescriptor?, NSDictionary?) -> Void) {
        var error: NSDictionary?
        let script = NSAppleScript(source: code)

        let output = script?.executeAndReturnError(&error)
        
        if let ou = output {
            completionHandler(true, ou, nil)
        }
        else {
            completionHandler(false, nil, error)
        }
    }
}

extension NSAppleScript {
    enum appleScripts: String {
        case PausePlay = """
        tell application "Music"
            if it is running then
                playpause
            end if
        end tell
        """
        
        case GetCurrentPlayerPosition = """
        tell application "Music"
            if it is running then
                get player position
            end if
        end tell
        """
        
        case GetCurrentPlayerState = """
        tell application "Music"
            if it is running then
                set playerstate to (get player state) as text
            end if
        end tell
        """
        
        static func SetPlayerPosition(_ position: Int) -> String {
            return """
            tell application "Music"
                if it is running then
                    set player position to \(position)
                end if
            end tell
            """
        }
        
        case GetShuffleMode = """
            tell application "Music"
                if it is running then
                    set shufflestate to (get shuffle enabled) as text
                end if
            end tell
        """
        
        static func SetShuffleMode(_ shuffle: Bool) -> String {
            return """
            tell application "Music"
                if it is running then
                    set shuffle enabled to \(shuffle ? "true" : "false")
                end if
            end tell
            """
        }
        
        case NextTrack = """
        tell application "Music"
            if it is running then
                next track
            end if
        end tell
        """
        
        case PrevTrack = """
        tell application "Music"
            if it is running then
                back track
            end if
        end tell
        """
        
        case GetTrackData = """
        tell application "Music"
            if it is running then
                get properties of current track
            end if
        end tell
        """
    }
}
