//
//  PlayerVM.swift
//  RadioApp
//  Created by B.RF Group on 03.11.2025.
//
import Foundation

final class PlayerVM: ObservableObject {
    let model: MusicM
    @Published var liked = true
    @Published var isPlaying = false
    
    init(model: MusicM) {
        self.model = model
    }
}
