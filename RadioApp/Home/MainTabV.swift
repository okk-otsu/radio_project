//
//  MainTabV.swift
//  RadioApp
//
//  Created by MacBook on 12.11.2025.
//

import SwiftUI

struct MainTabV: View {
    @StateObject private var homeVM = HomeVM() // общий VM для All

    var body: some View {
        TabView {
            HomeV(viewModel: homeVM)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("All")
                }

            FavoritesV()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
    }
}
