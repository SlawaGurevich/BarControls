//
//  UserPreferences.swift
//  BarControls
//
//  Created by Slawa on 03.03.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Foundation

class UserPreferences {
    // MARK: - Enums
    private enum Keys: String {
        case leftClick
        case rightClick
        case startAtLogin
    }
    
    enum LeftClickAction: String {
        case showPopup, showMenu, playPause, skipTrack, prevTrack, none
    }
    
    enum RightClickAction: String {
        case showPopup, showMenu, playPause, skipTrack, prevTrack, none
    }
    
    // MARK: - Class vars
    class var leftClick: LeftClickAction {
        get {
            return self.LeftClickAction.init(rawValue:
                self.readString(fromKey: self.Keys.leftClick.rawValue) ?? ""
            ) ?? self.LeftClickAction.showPopup
        }
        set {
            self.write(value: newValue.rawValue, toKey: self.Keys.leftClick.rawValue)
        }
    }
    
    class var rightClick: RightClickAction {
        get {
            return self.RightClickAction.init(rawValue:
                self.readString(fromKey: self.Keys.rightClick.rawValue) ?? ""
            ) ?? self.RightClickAction.showPopup
        }
        set {
            self.write(value: newValue.rawValue, toKey: self.Keys.rightClick.rawValue)
        }
    }
    
    class var startAtLogin: Bool {
        get {
            return self.readBool(fromKey: self.Keys.startAtLogin.rawValue) ?? true
        }
        set {
            self.write(value: newValue, toKey: self.Keys.startAtLogin.rawValue)
        }
    }
    
    // MARK: - Functions
    private static func write(value: Any?, toKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    private static func readString(fromKey key: String) -> String? {
        if !self.has(key: key) {
            return nil
        }
        
        return UserDefaults.standard.string(forKey: key)
    }
    
    private static func readBool(fromKey key: String) -> Bool? {
        if !self.has(key: key) {
            return nil
        }
        
        return UserDefaults.standard.bool(forKey: key)
    }
    
    private static func has(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
