//
//  RadioPlayer.swift
//  MusicApp
//  Created by B.RF Group on 03.11.2025.
//
import AVKit
import Foundation

final class RadioPlayer: ObservableObject {
    static let shared = RadioPlayer()

    let player = AVPlayer()
    
    @Published var isPlaying = false
    @Published var efir: MusicM? = nil

    private init() { }
    
    func play(_ efir: MusicM) {
        guard let url = URL(string: efir.streamUrl) else {
            print("Invalid url: \(efir.streamUrl)")
            return
        }

        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)

        self.efir = efir
        player.volume = 1
        player.play()
        isPlaying = true
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    func stop() {
        pause()
        efir = nil
    }
}
