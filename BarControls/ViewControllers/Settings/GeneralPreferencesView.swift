//
//  GeneralPreferecesController.swift
//  BarControls
//
//  Created by Slawa on 01.03.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class GeneralPreferencesView: NSView {
    @IBOutlet weak var b_quit: NSButton!
    
    @IBAction func quitApplication(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
}
