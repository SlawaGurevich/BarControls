//
//  PlayerViewController.swift
//  BarControls
//
//  Created by Slawa on 21.02.20.
//  Copyright © 2020 slawa.gurevich. All rights reserved.
//

import Cocoa
import AVKit

class PlayerViewController: NSViewController {
    // MARK: - Outlets
    @IBOutlet weak var b_playPause: NSButton!
    @IBOutlet weak var b_prevTrack: NSButton!
    @IBOutlet weak var b_nextTrack: NSButton!
    @IBOutlet weak var b_progressSlider: NSSlider!
    @IBOutlet weak var b_currentPosition: NSButton!
    @IBOutlet weak var b_totalDuration: NSButton!
    @IBOutlet weak var b_toggleShuffle: NSButton!
    @IBOutlet weak var b_toggleRepeat: NSButton!
    
    @IBOutlet weak var l_title: NSTextField!
    @IBOutlet weak var l_artist: NSTextField!
    @IBOutlet weak var l_coverArt: NSImageView!
    @IBOutlet weak var l_unblurredCoverArt: NSImageView!
    
    @IBOutlet weak var v_controlsView: NSView!
    @IBOutlet weak var v_visualEffectsImageView: NSVisualEffectView!
    

    // MARK: - Actions
    var changeObservers: [NSObjectProtocol] = []
    
    @IBAction func playPauseClicked(_ sender: Any) {
        MusicController.shared.playPause()
    }
    
    @IBAction func prevTrack(_ sender: Any) {
        MusicController.shared.prevTrack()
    }
    
    @IBAction func nextTrack(_ sender: Any) {
        MusicController.shared.nextTrack()
    }
    
    @IBAction func toggleShuffle(_ sender: Any) {
        MusicController.shared.toggleShuffleMode()
    }
    
    @IBAction func toggleRepeat(_ sender: Any) {
        MusicController.shared.toggleRepeat()
    }
    
    // MARK: - Overridden functions
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let track = MusicController.shared.currentTrack {
            v_controlsView.alphaValue = 0.99
            v_visualEffectsImageView.alphaValue = 1
            l_unblurredCoverArt.alphaValue = 0
            
            updateView(with: track)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMouseTrackingArea()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        addNotificationObservers()
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        removeMusicAppChangeObservers()
    }
    
    fileprivate func addMouseTrackingArea() {
        let trackingArea = NSTrackingArea(rect: self.view.accessibilityFrame(), options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
        self.view.addTrackingArea(trackingArea)
    }
    
    override func mouseEntered(with event: NSEvent) {
        NSAnimationContext.runAnimationGroup({(context) -> Void in
            context.duration = 0.5
            // TODO: Check why the shadow disappears, when it;s set to 1
            v_controlsView.animator().alphaValue = 0.99
            v_visualEffectsImageView.animator().alphaValue = 1
            l_unblurredCoverArt.animator().alphaValue = 0
            
        }) {
            
        }
    }

    override func mouseExited(with event: NSEvent) {
        if(UserPreferences.hideControls) {
            NSAnimationContext.runAnimationGroup({(context) -> Void in
                context.duration = 0.5
                v_visualEffectsImageView.animator().alphaValue = 0
                l_unblurredCoverArt.animator().alphaValue = 1
                v_controlsView.animator().alphaValue = 0
                
            }) {
                
            }
        }
    }
    
    // MARK: - Functions
    func addNotificationObservers() {
        changeObservers.append(
            NotificationCenter.observe(name: .TrackDataDidChange) {
                if let track = MusicController.shared.currentTrack {
                    self.updateView(with: track)
                }
            }
        )
        
        // Add PlayerPositionDidChange observer
        changeObservers.append(
            NotificationCenter.observe(name: .PlayerPositionDidChange) {
                self.setCurrentPlayerPosition(to: MusicController.shared.currentPlayerPosition)
            }
        )
        
        
        changeObservers.append(
            NotificationCenter.observe(name: .PlayerPropsDidChange) {
                self.updatePlayerStatus(playing: MusicController.shared.currentProps!.isPlaying)
                self.updateShuffleState(shuffling: MusicController.shared.currentProps!.isShuffling)
                self.updateRepeatMode(repeatMode: MusicController.shared.currentProps!.repeatMode)
            }
        )
//
//        changeObservers.append(
//            NotificationCenter.observe(name: .PlayerStateDidChange) {
//
//            }
//        )
//
//        changeObservers.append(
//            NotificationCenter.observe(name: .ShuffleModeChanged) {
//
//            }
//        )
//
//        changeObservers.append(
//            NotificationCenter.observe(name: .RepeatModeChanged) {
//
//            }
//        )
    }
    
    fileprivate func removeMusicAppChangeObservers() {
        for observer in changeObservers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    @IBAction func backFiveSeconds(_ sender: Any) {
        MusicController.shared.setPlayerPosition(position: b_progressSlider.doubleValue > 5 ? b_progressSlider.doubleValue - 5 : 0)
    }
    
    @IBAction func forwardFiveSeconds(_ sender: Any) {
        MusicController.shared.setPlayerPosition(position: b_progressSlider.doubleValue < Double(b_progressSlider.maxValue) ? b_progressSlider.doubleValue + 5 : Double(b_progressSlider.maxValue))
    }
    
    @IBAction func setPlayerPosition(_ sender: NSSlider) {
        MusicController.shared.setPlayerPosition(position: sender.doubleValue)
    }
    
    func updatePlayerStatus(playing: Bool) {
        print("updatePlayerStatus: \(playing)")
        if playing {
            b_playPause.image = NSImage(named: NSImage.Name("button-pause"))
        }
        else {
            b_playPause.image = NSImage(named: NSImage.Name("button-play"))
        }
    }
    
    func updateRepeatMode(repeatMode: String) {
//        print("repeatMode: \(repeatMode)")
        NSAnimationContext.runAnimationGroup({(context) -> Void in
        context.duration = 0.5
            switch repeatMode {
                case "off":
                    if(b_toggleRepeat.image != NSImage(named: NSImage.Name("button-loop")) || b_toggleRepeat.alphaValue != 0.4) {
                        b_toggleRepeat.animator().image = NSImage(named: NSImage.Name("button-loop"))
                        b_toggleRepeat.animator().alphaValue = 0.4
                    }
                case "all":
                    if(b_toggleRepeat.image != NSImage(named: NSImage.Name("button-loop")) || b_toggleRepeat.alphaValue != 1) {
                        b_toggleRepeat.animator().image = NSImage(named: NSImage.Name("button-loop"))
                        b_toggleRepeat.animator().alphaValue = 1
                    }
                case "one":
                    if(b_toggleRepeat.image != NSImage(named: NSImage.Name("button-loop-one")) || b_toggleRepeat.alphaValue != 1) {
                        b_toggleRepeat.animator().image = NSImage(named: NSImage.Name("button-loop-one"))
                        b_toggleRepeat.animator().alphaValue = 1
                    }
                default:
                    if(b_toggleRepeat.image != NSImage(named: NSImage.Name("button-loop")) || b_toggleRepeat.alphaValue != 0.4) {
                        b_toggleRepeat.animator().image = NSImage(named: NSImage.Name("button-loop"))
                        b_toggleRepeat.animator().alphaValue = 0.4
                    }
            }
        })
    }
    
    func updateShuffleState(shuffling: Bool) {
        NSAnimationContext.runAnimationGroup({(context) -> Void in
            context.duration = 0.5
            self.b_toggleShuffle.animator().alphaValue = MusicController.shared.currentProps!.isShuffling ? 1 : 0.4
        })
    }
    
    func getCover(filepath: URL) -> NSImage {
        var artwork: NSImage = NSImage(named: NSImage.Name("cover-placeholder"))!
        
        let metadata = AVURLAsset(url: filepath).commonMetadata
        let artworkItems = AVMetadataItem.metadataItems(from: metadata, filteredByIdentifier: AVMetadataIdentifier.commonIdentifierArtwork)
        
        if let artworkItem = artworkItems.first {
            if let imageData = artworkItem.dataValue {
                artwork = NSImage(data: imageData) ?? NSImage(named: NSImage.Name("cover-placeholder"))!
                artwork.size = NSSize(width: 216, height: 216)
            }
        }
        
        return artwork
    }
    
    func updateView(with track: Track) {
        let coverArt = getCover(filepath: track.path)
        
        self.l_title.stringValue = track.title
        self.l_artist.stringValue = track.artist
        self.b_totalDuration.title = "\(track.duration / 60):\( track.duration % 60 < 10 ? "0" : "" )\(track.duration % 60)"
        self.l_coverArt.image = coverArt
        self.l_unblurredCoverArt.image = coverArt
        self.b_progressSlider.maxValue = Double(track.duration)
        
        self.updatePlayerStatus(playing: MusicController.shared.currentProps!.isPlaying)
        self.updateShuffleState(shuffling: MusicController.shared.currentProps!.isShuffling)
        self.updateRepeatMode(repeatMode: MusicController.shared.currentProps!.repeatMode)
    }
    
    // Updates the slider position to the given seconds
    func setCurrentPlayerPosition(to seconds: Int) {
        self.b_progressSlider.intValue = Int32(seconds)
        self.b_currentPosition.title = seconds.intToLiteralDuration
    }
    
}
