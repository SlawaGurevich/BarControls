//
//  AppDelegate.swift
//  BarControls
//
//  Created by Slawa on 21.02.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItemManager: StatusItemManager!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        MusicControllerObserver.shared.start()
        StatusItemManager.shared.initManager()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

