//
//  GeneralPreferecesController.swift
//  BarControls
//
//  Created by Slawa on 01.03.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa

class GeneralPreferencesView: NSViewController {
    @IBOutlet weak var b_quit: NSButton!
    @IBOutlet weak var b_leftClickDropDown: NSPopUpButton!
    @IBOutlet weak var b_rightClickDropDown: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch(UserPreferences.leftClick) {
            case .showPopup:
                b_leftClickDropDown.selectItem(withTitle: "Show Popup")
            case .showMenu:
                b_leftClickDropDown.selectItem(withTitle: "Show Menu")
            case .playPause:
                b_leftClickDropDown.selectItem(withTitle: "Play/Pause")
            case .skipTrack:
                b_leftClickDropDown.selectItem(withTitle: "Skip Track")
            case .prevTrack:
                b_leftClickDropDown.selectItem(withTitle: "Previous Track")
            case .none:
                b_leftClickDropDown.selectItem(withTitle: "None")
        }
        
        switch(UserPreferences.rightClick) {
            case .showPopup:
                b_rightClickDropDown.selectItem(withTitle: "Show Popup")
            case .showMenu:
                b_rightClickDropDown.selectItem(withTitle: "Show Menu")
            case .playPause:
                b_rightClickDropDown.selectItem(withTitle: "Play/Pause")
            case .skipTrack:
                b_rightClickDropDown.selectItem(withTitle: "Skip Track")
            case .prevTrack:
                b_rightClickDropDown.selectItem(withTitle: "Previous Track")
            case .none:
                b_rightClickDropDown.selectItem(withTitle: "None")
        }
    }
    
    @IBAction func leftClickSelected(_ sender: Any) {
        switch(b_leftClickDropDown.selectedItem?.title) {
            case "Show Popup":
                UserPreferences.leftClick = .showPopup
            case "Show Menu":
                UserPreferences.leftClick = .showMenu
            case "Play/Pause":
                UserPreferences.leftClick = .playPause
            case "Skip Track":
                UserPreferences.leftClick = .skipTrack
            case "Previous Track":
                UserPreferences.leftClick = .prevTrack
            default:
                UserPreferences.leftClick = .none
        }
        
        if( b_rightClickDropDown.selectedItem?.title != "Show Popup" && b_leftClickDropDown.selectedItem?.title != "Show Popup" ) {
            b_rightClickDropDown.selectItem(withTitle: "Show Popup")
            UserPreferences.rightClick = .showPopup
        }
    }
    
    @IBAction func rightClickSelected(_ sender: Any) {
        switch(b_rightClickDropDown.selectedItem?.title) {
            case "Show Popup":
                UserPreferences.rightClick = .showPopup
            case "Show Menu":
                UserPreferences.rightClick = .showMenu
            case "Play/Pause":
                UserPreferences.rightClick = .playPause
            case "Skip Track":
                UserPreferences.rightClick = .skipTrack
            case "Previous Track":
                UserPreferences.rightClick = .prevTrack
            default:
                UserPreferences.rightClick = .none
        }
        
        if( b_rightClickDropDown.selectedItem?.title != "Show Popup" && b_leftClickDropDown.selectedItem?.title != "Show Popup" ) {
            b_leftClickDropDown.selectItem(withTitle: "Show Popup")
            UserPreferences.leftClick = .showPopup
        }
    }
    
    @IBAction func quitApplication(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
}
