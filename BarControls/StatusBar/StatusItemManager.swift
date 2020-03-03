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
        statusItem.button?.title = "🎶"
        
        statusItem.button?.target = self
        statusItem.button?.action = #selector(handleClick)
        statusItem.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }
    
    @objc func handleClick(sender: NSStatusItem) {
        let event = NSApp.currentEvent!

        if event.type == NSEvent.EventType.leftMouseUp {
            switch(UserPreferences.leftClick) {
                case .showPopup:
                    playerShowPopover()
                case .showMenu:
                    return
                case .playPause:
                    playerPlayPause()
                case .skipTrack:
                    playerSkipTrack()
                case .prevTrack:
                    playerPrevTrack()
                case .none:
                    return
            }
        } else {
            switch(UserPreferences.rightClick) {
                case .showPopup:
                    playerShowPopover()
                case .showMenu:
                    return
                case .playPause:
                    playerPlayPause()
                case .skipTrack:
                    playerSkipTrack()
                case .prevTrack:
                    playerPrevTrack()
                case .none:
                    return
            }
        }
    }
    
    func playerPlayPause() {
        MusicController.shared.playPause()
    }
    
    func playerSkipTrack() {
        MusicController.shared.nextTrack()
    }
    
    func playerPrevTrack() {
        MusicController.shared.prevTrack()
    }
    
    func playerShowPopover() {
        guard let popover = popover, let button = statusItem.button else { return }
        
        if !popover.isShown {
            MusicController.shared.updateData()
            
            if playerVC == nil {
                let storyboard = NSStoryboard(name: "Main", bundle: nil)
                guard let vc = storyboard.instantiateController(withIdentifier: .init(stringLiteral: "playerVC")) as? PlayerViewController else { return  }
                playerVC = vc
            }
            
            popover.contentViewController = playerVC
        
            updateButton()
            popover.show(relativeTo: button.window!.contentView!.bounds, of: button.window!.contentView!, preferredEdge: .minY)
            popover.contentViewController?.view.window?.makeKeyAndOrderFront(nil) // Needed so that the window disappears when clicked somewhere else
            
            // TO-DO: Rething this
            // Needed so that the window stays where it is when the menu bar is auto-hidden
//            if let window = popover.contentViewController?.view.window {
//                window.parent?.removeChildWindow(window)
//            }
        
            NSApp.activate(ignoringOtherApps: true)
        } else {
            popover.performClose(self)
        }
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

                // TO-DO: Keep window from moving
                button.title = "\(artist) - \(title)"
            }
        }
    }

    fileprivate func initPopover() {
        popover = NSPopover()
        
        popover?.behavior = .transient
    }
}
