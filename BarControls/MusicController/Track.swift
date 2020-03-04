//
//  Track.swift
//  BarControls
//
//  Created by Slawa on 01.03.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//
import Cocoa
import MediaPlayer

class Track {
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
    
    init(title: String, artist: String, album: String, duration: Int, coverArt: NSImage) {
        self.title = title
        self.artist = artist
        self.album = album
        self.duration = duration
        self.coverArt = coverArt
    }
    
    convenience init?(fromList list: [Int: String]) {
        var filepath: String = ""
        
        for entry in list {
            if entry.value.contains("file:") {
                filepath = entry.value
                break
            }
        }

        if filepath != "" {
            let asset = AVURLAsset(url: NSURL(string: filepath)! as URL)

            var t_title: String = "Unknown"
            var t_artist: String = "Unknown"
            var t_album: String = "Unknown"
            var t_duration: Int = 0
            var t_coverArt: NSImage = NSImage()

            t_duration = Int(asset.duration.seconds)

            for metadata in asset.metadata {
                switch metadata.commonKey?.rawValue {
                    case "title":
                        t_title = metadata.stringValue!
                    case "artist":
                        t_artist = metadata.stringValue!
                    case "albumName":
                        t_album = metadata.stringValue!
                    case "artwork":
                        if let image = NSImage(data: metadata.dataValue!) ?? NSImage(named: NSImage.Name("cover-placeholder")) {
                            image.size = NSSize(width: 216, height: 216)
                            t_coverArt = image
                        }
                    default:
                        continue
                }
            }

            self.init(title: t_title, artist: t_artist, album: t_album, duration: t_duration, coverArt: t_coverArt)
            return
        }
        
        return nil
    }
    
}
