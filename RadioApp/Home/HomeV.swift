//
//  HomeV.swift
//  RadioApp
//  Created by B.RF Group on 03.11.2025.
//
import SwiftUI

struct HomeV: View {
    @State private var searchTapped: Bool = false
    @StateObject var viewModel: HomeVM   // <-- не private

    var body: some View {
        ZStack {
            Color.primary_color.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    HomeHeaderV(headerStr: viewModel.headerStr, onTapSearch: { searchTapped.toggle() })

                    // список всех станций
                    HomePlaylistV(
                        playlists: viewModel.playlists,
                        onSelect: viewModel.selectMusic(music:)
                    )

                    Spacer().frame(height: 150)
                    Spacer()
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.displayPlayer) {
            if let model = viewModel.selectedMusic {
                PlayerV(
                    viewModel: PlayerVM(
                        model: model,
                        allStations: viewModel.playlists
                    )
                )
            }
        }
        .fullScreenCover(isPresented: $searchTapped) {
            Neuromorphism()
        }
    }
}


fileprivate struct HomePlaylistV: View {
    let playlists: [MusicM]
    let onSelect: (MusicM) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    ForEach(0..<playlists.count, id: \.self) { i in
                        let item = playlists[i]
                        Button(action: { onSelect(item) }) {
                            PlaylistV(name: item.name, coverImage: item.imageUrl)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, Constants.Sizes.HORIZONTAL_SPACING)
                        .padding(.top, 6)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .padding(.top, 36)
    }
}
