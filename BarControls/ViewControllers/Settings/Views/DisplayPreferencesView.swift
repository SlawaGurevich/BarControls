//
//  DisplayPreferencesController.swift
//  BarControls
//
//  Created by Slawa on 01.03.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class DisplayPreferenesView: NSViewController {
    @IBOutlet weak var b_showTitle: NSButton!
    @IBOutlet weak var b_showArtist: NSButton!
    @IBOutlet weak var b_showAlbum: NSButton!
    
    @IBOutlet weak var l_previewLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DisplayOptions")
        b_showTitle.state = (UserPreferences.showTitle ? .on : .off)
        b_showArtist.state = (UserPreferences.showArtist ? .on : .off)
        b_showAlbum.state = (UserPreferences.showAlbum ? .on : .off)
        
        updateLabel()
    }
    
    @IBAction func checkedTitle(_ sender: Any) {
        UserPreferences.showTitle = b_showTitle.state == .on ? true : false
        updateLabel()
    }
    
    @IBAction func checkedArtist(_ sender: Any) {
        UserPreferences.showArtist = b_showArtist.state == .on ? true : false
        updateLabel()
    }
    
    @IBAction func checkedAlbum(_ sender: Any) {
        UserPreferences.showAlbum = b_showAlbum.state == .on ? true : false
        updateLabel()
    }
    
    func updateLabel() {
        var displayString = ""
        displayString.append(b_showArtist.state == .on ? "Queen " : "")
        displayString.append(
            ((b_showTitle.state == .on && b_showArtist.state == .on) || (b_showTitle.state == .on && b_showAlbum.state == .on)) ? "-" : "")
        displayString.append(b_showTitle.state == .on ? " One Vision " : "")
        displayString.append((b_showArtist.state == .on && b_showAlbum.state == .on) ? "-" : "")
        displayString.append(b_showAlbum.state == .on ? " A Kind of Magic" : "")
      
        l_previewLabel.stringValue = displayString
    }
}
