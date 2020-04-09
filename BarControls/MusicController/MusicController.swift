//
//  MusicController.swift
//  BarControls
//
//  Created by Slawa on 21.02.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Foundation
import AppKit
import ScriptingBridge

class MusicController {
    static let shared = MusicController()
    
    let trackCache: NSCache<NSString, Track>
    let sbCache: NSCache<NSString, SBApplication>
    let propCache: NSCache<NSString, PlayerProps>
    let iTunesApplication: AnyObject;
    
    init() {
        if #available(macOS 10.15, *) {
            iTunesApplication = SBApplication(bundleIdentifier: "com.apple.Music")!
        } else {
            iTunesApplication = SBApplication(bundleIdentifier: "com.apple.iTunes")!
        }

        trackCache = NSCache<NSString, Track>()
        sbCache = NSCache<NSString, SBApplication>()
        propCache = NSCache<NSString, PlayerProps>()
    }
    
    var currentTrack: Track? {
        didSet {
            if oldValue != currentTrack {
                NotificationCenter.post(name: .TrackDataDidChange)
            }   
        }
    }
    
    var currentPlayerPosition: Int = 0 {
        didSet {
            if oldValue != currentPlayerPosition {
                NotificationCenter.post(name: .PlayerPositionDidChange)
            }
        }
    }
    
    var currentProps: PlayerProps? {
        didSet {
            if oldValue != currentProps {
                NotificationCenter.post(name: .PlayerPropsDidChange)
            }
        }
    }
    
    // MARK: - Functions
//    func runScript(script: String) {
//        OSAScript.run(code: script, completionHandler: {_,_,_ in})
//    }
    
    func getState() -> Int {
        switch iTunesApplication.playerState!
        {
            case iTunesEPlS.stopped:
                return 1
            
            case iTunesEPlS.playing:
                return 2
            
            case iTunesEPlS.paused:
                return 3
            
            case iTunesEPlS.fastForwarding:
                return 4
            
            case iTunesEPlS.rewinding:
                return 5
        }
    }
    
    func getRepeat() -> String {
        switch iTunesApplication.songRepeat! {
            case iTunesERpt.off:
                return "off"
            
            case iTunesERpt.one:
                return "one"
            
            case iTunesERpt.all:
                return "all"
        }
    }
    
    
    func playPause() {
        iTunesApplication.playpause()
    }
    
    func nextTrack() {
        iTunesApplication.nextTrack()
    }
    
    func prevTrack() {
        iTunesApplication.backTrack()
    }
    
    func getShuffle() -> Bool {
        return iTunesApplication.shuffleEnabled
    }
    
    func toggleRepeat() {
        switch currentProps?.repeatMode {
            case "off":
                iTunesApplication.setSongRepeat(iTunesERpt.all)
            case "all":
                iTunesApplication.setSongRepeat(iTunesERpt.one)
            case "one":
                iTunesApplication.setSongRepeat(iTunesERpt.off)
            default:
                iTunesApplication.setSongRepeat(iTunesERpt.off)
        }
    }
    
    func toggleShuffleMode() {
        iTunesApplication.setShuffleEnabled(!iTunesApplication.shuffleEnabled)
    }
    
    func setPlayerPosition(position: Double) {
        iTunesApplication.setPlayerPosition(position)
    }
    
    func updateData() {
        self.currentPlayerPosition = Int(Double(iTunesApplication.playerPosition).rounded())
        
        if let cachedPlayerProps = propCache.object(forKey: "CachedProps") {
            let props = PlayerProps(playing: getState() == 2, shuffling: getShuffle(), repeatMode: getRepeat())
            if cachedPlayerProps == props {
//                print("same props")
            } else {
                propCache.setObject(props, forKey: "CachedProps")
                self.currentProps = props
                print("PROPS CHANGED\nShuffle: \(cachedPlayerProps.isShuffling) Repeat: \(cachedPlayerProps.repeatMode) Playing: \(cachedPlayerProps.isPlaying)\n===================")
            }
        } else {
            let props = PlayerProps(playing: getState() == 2, shuffling: getShuffle(), repeatMode: getRepeat())
            propCache.setObject(props, forKey: "CachedProps")
            self.currentProps = propCache.object(forKey: "CachedProps")
        }
        
        if iTunesApplication.currentTrack != nil {
            if let cachedTrack = trackCache.object(forKey: "CachedTrack") {
                var track = Track(fromTrack: iTunesApplication.currentTrack as! iTunesFileTrack)
                if cachedTrack == track {
//                    print("same track")
                } else {
                    trackCache.setObject(track!, forKey: "CachedTrack")
                    self.currentTrack = track!
                    print("TRACK CHANGED\nArtist: \(track!.artist)\nTitle: \(track!.title)")
                    track = nil
                }
            } else {
                if let track = Track(fromTrack: iTunesApplication.currentTrack as! iTunesFileTrack) {
                    trackCache.setObject(track, forKey: "CachedTrack")
                    self.currentTrack = trackCache.object(forKey: "CachedTrack")
                }
            }
        }
    }
}
