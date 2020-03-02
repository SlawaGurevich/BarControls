//
//  File.swift
//  BarControls
//
//  Created by Slawa on 01.03.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class SettingsWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        super.window?.setFrame(NSRect(x: 0, y: 0, width: 480, height: 400), display: true)
        self.window?.center()
    }
}
