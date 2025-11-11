//
//  PlayerVM.swift
//  RadioApp
//  Created by B.RF Group on 03.11.2025.
//
import Foundation
import Combine
import SwiftUI

final class PlayerVM: ObservableObject {
    // Текущая станция, обновляется при переключении
    @Published var model: MusicM
    @Published var liked = false
    @Published var isPlaying = false

    private let playlist: [MusicM]
    private var currentIndex: Int

    private let radioPlayer = RadioPlayer.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(model: MusicM, allStations: [MusicM]) {
        // если плейлист пустой — хотя бы одна станция должна быть
        let list = allStations.isEmpty ? [model] : allStations
        self.playlist = list

        if let idx = list.firstIndex(of: model) {
            self.currentIndex = idx
            self.model = list[idx]
        } else {
            // если по какой-то причине нет в списке — берём первую
            self.currentIndex = 0
            self.model = list[0]
        }
        
        // автозапуск выбранной станции
        play()
        
        // синхронизируемся с RadioPlayer, чтобы кнопка показывала реальное состояние
        radioPlayer.$isPlaying
            .receive(on: RunLoop.main)
            .assign(to: \.isPlaying, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Управление плеером

    func play() {
        radioPlayer.play(model)
    }
    
    func pause() {
        radioPlayer.pause()
    }
    
    func togglePlayPause() {
        isPlaying ? pause() : play()
    }
    
    func playNext() {
        guard !playlist.isEmpty else { return }
        currentIndex = (currentIndex + 1) % playlist.count
        model = playlist[currentIndex]
        play()
    }
    
    func playPrevious() {
        guard !playlist.isEmpty else { return }
        currentIndex = (currentIndex - 1 + playlist.count) % playlist.count
        model = playlist[currentIndex]
        play()
    }
    
    // MARK: - Громкость

    var volumeBinding: Binding<Double> {
        Binding(
            get: { Double(self.radioPlayer.player.volume) },
            set: { self.radioPlayer.player.volume = Float($0) }
        )
    }
}
