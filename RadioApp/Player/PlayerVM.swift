//
//  PlayerVM.swift
//  RadioApp
//  Created by B.RF Group on 03.11.2025.
//
import Foundation
import Combine
import SwiftUI

final class PlayerVM: ObservableObject {
    @Published var model: MusicM
    @Published var liked: Bool
    @Published var isPlaying: Bool = false

    private let playlist: [MusicM]
    private var currentIndex: Int
    private let radioPlayer = RadioPlayer.shared
    private let fetcher = RadioFetcher.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(model: MusicM, allStations: [MusicM]) {
        let list = allStations.isEmpty ? [model] : allStations
        
        // сначала определяем индекс и модель локально
        let currentIdx = list.firstIndex(of: model) ?? 0
        let currentModel = list[currentIdx]
        
        // теперь можем безопасно инициализировать все stored properties
        self.playlist = list
        self.currentIndex = currentIdx
        self.model = currentModel
        self.liked = RadioFetcher.shared.isFavorite(currentModel) // без обращения к self
        self.isPlaying = false

        radioPlayer.$isPlaying
            .receive(on: RunLoop.main)
            .assign(to: \.isPlaying, on: self)
            .store(in: &cancellables)

        // автозапуск
        play()
    }
    
    // MARK: - Управление плеером
    func play() { radioPlayer.play(model) }
    func pause() { radioPlayer.pause() }
    func togglePlayPause() { isPlaying ? pause() : play() }

    // MARK: - Избранное
    func toggleLike() {
        fetcher.toggleFavorite(model)
        liked.toggle()
    }

    // MARK: - Переключение станций
    func playNext() {
        guard !playlist.isEmpty else { return }
        currentIndex = (currentIndex + 1) % playlist.count
        model = playlist[currentIndex]
        liked = fetcher.isFavorite(model)
        play()
    }

    func playPrevious() {
        guard !playlist.isEmpty else { return }
        currentIndex = (currentIndex - 1 + playlist.count) % playlist.count
        model = playlist[currentIndex]
        liked = fetcher.isFavorite(model)
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
