//
//  ContentView.swift
//  SwiftUIRTSP
//
//  Created by Morris Richman on 9/27/23.
//

import SwiftUI
import AVFoundation
import AVKit

struct RTSPStreamView: View {
    // RTSP Stream URL
    private let rtspURL: URL // Replace with your RTSP stream URL

    // Initialize AVPlayer and AVPlayerLayer
    @State private var player: AVPlayer?
    @State private var playerLayer: AVPlayerLayer?
    
    // Initialize PiP view controller
    @State private var pipViewController: AVPictureInPictureController?
    
    init(rtspURL: URL) {
        self.rtspURL = rtspURL
        setupPlayer()
    }

    private func setupPlayer() {
        // Create AVPlayer and set its player item to the RTSP stream
        let playerItem = AVPlayerItem(url: rtspURL)
        player = AVPlayer(playerItem: playerItem)

        // Create AVPlayerLayer for video rendering
        let layer = AVPlayerLayer(player: player)
        
        playerLayer = layer
        playerLayer?.videoGravity = .resizeAspect

        // Initialize PiP controller
        pipViewController = AVPictureInPictureController(playerLayer: layer)
        
        // Start streaming
        player?.play()
    }

    var body: some View {
        VideoPlayer(player: player) {
            Text("Video playback failed.")
        }
        Button("Enter PiP") {
            pipViewController?.startPictureInPicture()
        }
    }
}

struct ContentView: View {
    var body: some View {
        RTSPStreamView(rtspURL: URL(string: "YOUR_RTSP_STREAM_URL_HERE")!)
            .frame(width: 320, height: 240) // Set your desired frame size
    }
}

#Preview {
    ContentView()
}
