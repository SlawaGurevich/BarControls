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
import AVKit

class Track: Equatable, Hashable {
    // MARK: - Properties
    let title: String
    let artist: String
    let album: String
    let coverArt: NSImage
    let duration: Int
    
    var description: String { return "\(artist) - \(title) [\(duration)]" }
    
    var displayText: String {
        return "\(artist) - \(title)"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(self.title)\(self.artist)\(self.album)")
    }
    
    init(title: String, artist: String, album: String, duration: Int, coverArt: NSImage) {
        self.title = title
        self.artist = artist
        self.album = album
        self.duration = duration
        self.coverArt = coverArt
    }
    
    convenience init?(fromTrack track: iTunesTrack) {
        let dict = track.properties as! Dictionary<String, Any>
        let filepath = "\(dict["location"] ?? "")"
        var artwork: NSImage? = NSImage(named: NSImage.Name("cover-placeholder"))!
        let metadata = AVURLAsset(url: NSURL(string: filepath)! as URL).commonMetadata
        let artworkItems = AVMetadataItem.metadataItems(from: metadata, filteredByIdentifier: AVMetadataIdentifier.commonIdentifierArtwork)
        
        if let artworkItem = artworkItems.first {
            if let imageData = artworkItem.dataValue {
                artwork = NSImage(data: imageData) ?? NSImage(named: NSImage.Name("cover-placeholder"))!
                artwork?.size = NSSize(width: 216, height: 216)
            }
        }
        
//        print("Title: \(dict["name"] as! String),\nArtist: \(dict["artist"] as! String != "" ? dict["artist"] as! String : dict["albumArtist"] as! String),\nAlbum: \(dict["album"] as! String), Duration: \(dict["duration"] as! NSNumber)")
//                print("==================================================")

        self.init(title: "\(dict["name"] as! String)",
            artist: "\(dict["artist"] as! String != "" ? dict["artist"] as! String : dict["albumArtist"] as! String)",
            album: "\(dict["album"] as! String)",
            duration: Int(truncating: dict["duration"] as! NSNumber),
            coverArt: artwork!)
        
        artwork = nil
        return
    }
    
    static func == (one: Track, two: Track) -> Bool {
        return one.displayText == two.displayText
    }
}
