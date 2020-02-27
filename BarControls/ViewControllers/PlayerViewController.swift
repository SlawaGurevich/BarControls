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
        MusicController.shared.getCoverArt()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
