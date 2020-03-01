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
    
    @IBOutlet weak var l_title: NSTextField!
    @IBOutlet weak var l_artist: NSTextField!
    @IBOutlet weak var l_coverArt: NSImageCell!
    @IBOutlet weak var l_totalDuration: NSTextField!
    
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
        
        let textShadow: NSShadow = NSShadow()
        textShadow.shadowBlurRadius = 10
        textShadow.shadowOffset = NSMakeSize(4, 4)
        textShadow.shadowColor = NSColor.black
        
        l_title.shadow = textShadow
        
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
    }
    
    func removeNotificationObservers() {
        
    }
    
    func updateView(with track: Track) {
        self.l_title.stringValue = track.title
        self.l_artist.stringValue = track.artist
        self.l_totalDuration.stringValue = "\(track.duration / 60):\( track.duration % 60 < 10 ? "0" : "" )\(track.duration % 60)"
        self.l_coverArt.image = track.coverArt
    }
    
}
