//
//  ViewController.swift
//  videoPlayer
//
//  Created by admin on 7/30/23.
//

import UIKit
import AVFoundation
import AVKit
class ViewController: UIViewController {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        videoContainerView.layer.addSublayer(playerLayer!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleControlsVisibility))
        videoContainerView.addGestureRecognizer(tapGesture)
        
        // Set up actions for UI buttons
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        backwardButton.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        muteButton.addTarget(self, action: #selector(muteButtonTapped), for: .touchUpInside)
        
        // Start playing the video
        player?.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = videoContainerView.bounds
    }
    
    @objc func toggleControlsVisibility() {
        // Implement hiding or showing controls when the video container view is tapped
    }
    
    @objc func playPauseButtonTapped() {
        if player?.rate == 0 {
            player?.play()
        } else {
            player?.pause()
        }
    }
    
    @objc func backwardButtonTapped() {
        let currentTime = player?.currentTime().seconds ?? 0
        let newTime = max(currentTime - 10, 0)
        let time = CMTimeMakeWithSeconds(newTime, preferredTimescale: 1)
        player?.seek(to: time,toleranceBefore: CMTime.zero,toleranceAfter: CMTime.zero)
    }
    
    @objc func forwardButtonTapped() {
        let currentTime = player?.currentTime().seconds ?? 0
        let duration = player?.currentItem?.duration.seconds ?? 0
        let newTime = min(currentTime + 10, duration)
        let time = CMTimeMakeWithSeconds(newTime, preferredTimescale: 1)
        player?.seek(to: time,toleranceBefore: CMTime.zero,toleranceAfter: CMTime.zero)
    }
    
    @objc func muteButtonTapped() {
//        player?.isMuted = !player!.isMuted
        if UIDevice.current.orientation.isLandscape {
            // Switch to landscape mode
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        } else {
            // Switch to portrait mode
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
    }
    
    @objc func qualityChanged() {
        // Implement logic to switch video quality based on the selected segment
        // You may need to have different video URLs for different qualities and replace the player item.
    }
}
