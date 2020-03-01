//
//  StatusItemManager.swift
//  BarControls
//
//  Created by Slawa on 27.02.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class StatusItemManager: NSObject {
    static let shared = StatusItemManager()
    
    var statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var popover: NSPopover?
    var playerVC: PlayerViewController?
    var trackDataDidChangeObserver: NSObjectProtocol?
    
    override init() {
        super.init()
        
        initStatusItem()
        initPopover()
    }
    
    fileprivate func initStatusItem() {
        statusItem.button?.title = "Some Song"
        
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showPlayerVC)
    }
    
    @objc func showPlayerVC() {
        guard let popover = popover, let button = statusItem.button else { return }
        
        if playerVC == nil {
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateController(withIdentifier: .init(stringLiteral: "playerVC")) as? PlayerViewController else { return  }
            playerVC = vc
        }
        
        MusicController.shared.getTrackData()
        
        popover.contentViewController = playerVC
        updateButton()
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    }
    
    func initManager() {
        print("initManager")
        updateButton()
        
        trackDataDidChangeObserver = NotificationCenter.observe(name: .TrackDataDidChange) {
            self.updateButton()
        }
    }
    
    func deinitManager() {
        if let observer = trackDataDidChangeObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func updateButton() {
        if let button = statusItem.button {
            if let track = MusicController.shared.currentTrack {
                let title: String = track.title
                let artist: String = track.artist
                
                button.title = "\(artist) - \(title)"
            }
        }
    }

    fileprivate func initPopover() {
        popover = NSPopover()
        
        popover?.behavior = .transient
    }
}
