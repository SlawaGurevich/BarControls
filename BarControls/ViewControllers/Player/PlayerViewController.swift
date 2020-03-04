//
//  PlayerViewController.swift
//  BarControls
//
//  Created by Slawa on 21.02.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class PlayerViewController: NSViewController {
    @IBOutlet weak var b_playPause: NSButton!
    @IBOutlet weak var b_prevTrack: NSButton!
    @IBOutlet weak var b_nextTrack: NSButton!
    @IBOutlet weak var b_shuffleButton: NSButton!
    @IBOutlet weak var b_progressSlider: NSSlider!
    @IBOutlet weak var b_currentPosition: NSButton!
    @IBOutlet weak var b_totalDuration: NSButton!
    
    @IBOutlet weak var l_title: NSTextField!
    @IBOutlet weak var l_artist: NSTextField!
    @IBOutlet weak var l_coverArt: NSImageCell!

    
    var changeObservers: [NSObjectProtocol] = []
    
    @IBAction func playPauseClicked(_ sender: Any) {
        MusicController.shared.playPause()
    }
    
    @IBAction func prevTrack(_ sender: Any) {
        MusicController.shared.prevTrack()
    }
    
    @IBAction func nextTrack(_ sender: Any) {
        MusicController.shared.nextTrack()
    }
    
    @IBAction func toggleShuffle(_ sender: Any) {
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let track = MusicController.shared.currentTrack {
            updateView(with: track)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        addNotificationObservers()
    }
    
    // MARK: - Functions
    func addNotificationObservers() {
        changeObservers.append(
            NotificationCenter.observe(name: .TrackDataDidChange) {
                if let track = MusicController.shared.currentTrack {
                    self.updateView(with: track)
                }
            }
        )
        
        // Add PlayerPositionDidChange observer
        changeObservers.append(
            NotificationCenter.observe(name: .PlayerPositionDidChange) {
                self.setCurrentPlayerPosition(to: MusicController.shared.currentPlayerPosition)
            }
        )
        
        changeObservers.append(
            NotificationCenter.observe(name: .PlayerStateDidChange) {
                self.updatePlayerStatus(playing: MusicController.shared.isPlaying)
            }
        )
    }
    
    func removeNotificationObservers() {
        
    }
    
    @IBAction func backFiveSeconds(_ sender: Any) {
        MusicController.shared.setPlayerPosition(position: b_progressSlider.integerValue > 5 ? b_progressSlider.integerValue - 5 : 0)
    }
    
    @IBAction func forwardFiveSeconds(_ sender: Any) {
        MusicController.shared.setPlayerPosition(position: b_progressSlider.integerValue < Int(b_progressSlider.maxValue) ? b_progressSlider.integerValue + 5 : Int(b_progressSlider.maxValue))
    }
    
    @IBAction func setPlayerPosition(_ sender: NSSlider) {
        MusicController.shared.setPlayerPosition(position: sender.integerValue)
    }
    
    func updatePlayerStatus(playing: Bool) {
        if playing {
            b_playPause.image = NSImage(named: NSImage.Name("button-pause"))
        }
        else {
            b_playPause.image = NSImage(named: NSImage.Name("button-play"))
        }
    }
    
    func updateView(with track: Track) {
        self.l_title.stringValue = track.title
        self.l_artist.stringValue = track.artist
        self.b_totalDuration.title = "\(track.duration / 60):\( track.duration % 60 < 10 ? "0" : "" )\(track.duration % 60)"
        self.l_coverArt.image = track.coverArt
        self.b_progressSlider.maxValue = Double(track.duration)
        self.updatePlayerStatus(playing: MusicController.shared.isPlaying)
    }
    
    // Updates the slider position to the given seconds
    func setCurrentPlayerPosition(to seconds: Int) {
        self.b_progressSlider.intValue = Int32(seconds)
        self.b_currentPosition.title = seconds.intToLiteralDuration
    }
    
}
