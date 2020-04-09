//
//  Track.swift
//  BarControls
//
//  Created by Slawa on 01.03.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//
import Cocoa
import MediaPlayer
import ScriptingBridge


class Track: Equatable, Hashable {
    // MARK: - Properties
    let title: String
    let artist: String
    let album: String
    let path: URL
    let duration: Int
    
    var description: String { return "\(artist) - \(title) [\(duration)]" }
    
    var displayText: String {
        return "\(artist) - \(title)"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(self.title)\(self.artist)\(self.album)")
    }
    
    init(title: String, artist: String, album: String, duration: Int, path: URL) {
        self.title = title
        self.artist = artist
        self.album = album
        self.duration = duration
        self.path = path
    }
    
    convenience init?(fromTrack track: iTunesFileTrack) {
        
//        print("Title: \(dict["name"] as! String),\nArtist: \(dict["artist"] as! String != "" ? dict["artist"] as! String : dict["albumArtist"] as! String),\nAlbum: \(dict["album"] as! String), Duration: \(dict["duration"] as! NSNumber)")
//                print("==================================================")

        self.init(title: track.name ?? "Unknown",
                  artist: (track.artist != "" ? track.artist : track.albumArtist) ?? "Unknown",
                  album: track.album ?? "Unknown",
            duration: Int(track.duration ?? 0),
            path: track.location!)
        
        return
    }
    
    static func == (one: Track, two: Track) -> Bool {
        return one.displayText == two.displayText
    }
}
