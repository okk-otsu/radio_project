//
//  FavoritesV.swift
//  RadioApp
//
//  Created by MacBook on 12.11.2025.
//

import SwiftUI

struct FavoritesV: View {
    @ObservedObject private var fetcher = RadioFetcher.shared
    @StateObject private var vm = HomeVM()   // только для selectMusic/displayPlayer

    var body: some View {
        ZStack {
            Color.primary_color.ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    HomeHeaderV(headerStr: "Favorites", onTapSearch: {})

                    ForEach(fetcher.favEfirs.indices, id: \.self) { i in
                        let item = fetcher.favEfirs[i]
                        Button(action: { vm.selectMusic(music: item) }) {
                            PlaylistV(name: item.name, coverImage: item.imageUrl)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, Constants.Sizes.HORIZONTAL_SPACING)
                        .padding(.top, 6)
                        .padding(.bottom, 40)
                    }

                    Spacer().frame(height: 120)
                }
            }
        }
        .fullScreenCover(isPresented: $vm.displayPlayer) {
            if let model = vm.selectedMusic {
                PlayerV(
                    viewModel: PlayerVM(
                        model: model,
                        // цикл по избранным; если пусто — по всем станциям
                        allStations: fetcher.favEfirs.isEmpty ? fetcher.efirs : fetcher.favEfirs
                    )
                )
            }
        }
    }
}
