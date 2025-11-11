//
//  HomeV.swift
//  RadioApp
//  Created by B.RF Group on 03.11.2025.
//
import SwiftUI

struct HomeV: View {
    @State private var searchTapped: Bool = false
    @StateObject private var viewModel = HomeVM()
    
    var body: some View {
        ZStack {
            Color.primary_color.edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    // Header
                    HomeHeaderV(
                        headerStr: viewModel.headerStr,
                        onTapSearch: { searchTapped.toggle() }
                    )
                    
                    // Playlists
                    HomePlaylistV(
                        playlists: viewModel.playlists,
                        onSelect: viewModel.selectMusic(music:)
                    )
                    
                    Spacer().frame(height: 150)
                    Spacer()
                }
            }
            .animation(.spring(), value: viewModel.playlists)
            .edgesIgnoringSafeArea([.horizontal, .bottom])
        }
        // Открываем плеер, когда выбрана станция
        .fullScreenCover(isPresented: $viewModel.displayPlayer) {
            if let model = viewModel.selectedMusic {
                PlayerV(
                    viewModel: PlayerVM(
                        model: model,
                        allStations: viewModel.playlists   // весь список для next/prev
                    )
                )
            }
        }
        // Экран поиска / неоморфизма
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
                        Button(action: {
                            onSelect(playlists[i])
                        }) {
                            PlaylistV(
                                name: playlists[i].name,
                                coverImage: playlists[i].imageUrl
                            )
                        }
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
