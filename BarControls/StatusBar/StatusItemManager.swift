//
//  StatusItemManager.swift
//  BarControls
//
//  Created by Slawa on 27.02.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class StatusItemManager: NSObject {
    // MARK: - Static declaration
    static let shared = StatusItemManager()
   
    // MARK: - Properties
    var statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var popover: NSPopover?
    var detachedWindow: NSWindow = NSWindow()
    var playerVC: PlayerViewController?
    var trackDataDidChangeObserver: NSObjectProtocol?
    
    // MARK: - Overridden functions
    override init() {
        super.init()
        
        initStatusItem()
        initPopover()
    }
    
    // MARK: - Init functions
    fileprivate func initStatusItem() {
        statusItem.button?.title = "🎶"
        
        statusItem.button?.target = self
        statusItem.button?.action = #selector(handleClick)
        statusItem.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }
    
    fileprivate func initPopover() {
        popover = NSPopover()
        
        popover?.behavior = .transient
    }
    
    func initManager() {
        createDetachedWindow()
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
    
    func createDetachedWindow() {
        let height:CGFloat = 1
        
        detachedWindow = NSWindow(contentRect: NSMakeRect(0, 0, 15, height), styleMask: .borderless, backing: .buffered, defer: false)
        detachedWindow.backgroundColor = .red
        detachedWindow.alphaValue = 0
    }
    // MARK: - Click handle functions
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
            
            let buttonRect = button.convert(statusItem.button!.bounds, to: nil)
            let screenRect = button.window!.convertToScreen(buttonRect)
            
            let posX = screenRect.origin.x + (screenRect.width / 2)
            let posY = screenRect.origin.y
            
            detachedWindow.setFrameOrigin(NSPoint(x: posX, y: posY))
            detachedWindow.makeKeyAndOrderFront(self)
            
            updateButton()
            
            popover.show(relativeTo: detachedWindow.contentView!.frame, of: detachedWindow.contentView!, preferredEdge: .minY)
        
            NSApp.activate(ignoringOtherApps: true)
        } else {
            popover.performClose(self)
        }
    }
    
    // MARK: - View update functions
    func updateButton() {
        if let button = statusItem.button {
            if let track = MusicController.shared.currentTrack {
                let title: String = track.title
                let artist: String = track.artist
                let album: String = track.album
                
                var displayString = ""
                displayString.append(UserPreferences.showArtist ? "\(artist) " : "")
                displayString.append(
                    ((UserPreferences.showTitle && UserPreferences.showArtist) || (UserPreferences.showTitle && UserPreferences.showAlbum)) ? "-" : "")
                displayString.append(UserPreferences.showTitle ? " \(title) " : "")
                displayString.append((UserPreferences.showArtist && UserPreferences.showAlbum) ? "-" : "")
                displayString.append(UserPreferences.showAlbum ? " \(album)" : "")

                // TO-DO: Keep window from moving
                button.title = displayString
            }
        }
    }
}
