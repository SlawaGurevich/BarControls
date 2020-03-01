//
//  StatusItemManager.swift
//  BarControls
//
//  Created by Slawa on 27.02.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class StatusItemManager: NSObject {
    var statusItem: NSStatusItem?
    var popover: NSPopover?
    var playerVC: PlayerViewController?
    
    override init() {
        super.init()
        
        initStatusItem()
        initPopover()
    }
    
    fileprivate func initStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        statusItem?.button?.title = "Some Song"
        
        statusItem?.button?.target = self
        statusItem?.button?.action = #selector(showPlayerVC)
    }
    
    @objc func showPlayerVC() {
        guard let popover = popover, let button = statusItem?.button else { return }
        
        if playerVC == nil {
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateController(withIdentifier: .init(stringLiteral: "playerVC")) as? PlayerViewController else { return  }
            playerVC = vc
        }
        
        MusicController.shared.getTrackData()
        
        popover.contentViewController = playerVC
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    }
    
    fileprivate func initPopover() {
        popover = NSPopover()
        
        popover?.behavior = .transient
    }
}
