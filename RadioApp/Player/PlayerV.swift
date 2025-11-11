//
//  PlayerV.swift
//  RadioApp
//  Created by B.RF Group on 03.11.2025.
//
import SwiftUI

fileprivate let HORIZONTAL_SPACING: CGFloat = 24

struct PlayerV: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PlayerVM   // VM приходит из HomeV
    
    var body: some View {
        ZStack {
            Color.primary_color.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                
                Spacer(minLength: 32)
                
                // Обложка станции
                PlayerDiscV(coverImage: viewModel.model.imageUrl)
                    .padding(.bottom, 16)
                
                // Название станции
                Text(viewModel.model.name)
                    .foregroundColor(.text_primary)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                volumeRow
                    .padding(.bottom, 40)
                
                controlRow
            }
            .padding(.horizontal, HORIZONTAL_SPACING)
            .padding(.bottom, HORIZONTAL_SPACING)
            .animation(.spring(), value: viewModel.isPlaying)
        }
    }
    
    // MARK: - Subviews
    
    private var header: some View {
        HStack(alignment: .center) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image.close
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .background(Color.primary_color)
                    .cornerRadius(20)
                    .modifier(NeuShadow())
            }
            
            Spacer()
            
            Button(action: { }) {
                Image.options
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(12)
                    .background(Color.primary_color)
                    .cornerRadius(20)
                    .modifier(NeuShadow())
            }
        }
        .padding(.top, 12)
    }
    
    private var volumeRow: some View {
        HStack(alignment: .center, spacing: 12) {
            Text("VOL")
                .foregroundColor(.text_primary)
                .bold()
            
            Slider(value: viewModel.volumeBinding, in: 0...1)
                .accentColor(.main_white)
            
            Button(action: {
                viewModel.liked.toggle()
            }) {
                (viewModel.liked ? Image.heart_filled : Image.heart)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
    }
    
    private var controlRow: some View {
        HStack(alignment: .center) {
            // Prev
            Button(action: {
                viewModel.playPrevious()
            }) {
                Image.next
                    .resizable()
                    .frame(width: 18, height: 18)
                    .rotationEffect(.degrees(180))
                    .padding(24)
                    .background(Color.primary_color)
                    .cornerRadius(40)
                    .modifier(NeuShadow())
            }
            
            Spacer()
            
            // Play / Pause
            Button(action: {
                viewModel.togglePlayPause()
            }) {
                Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.main_white)
                    .padding(24)
                    .background(Color.primary_color)
                    .cornerRadius(40)
                    .modifier(NeuShadow())
            }
            
            Spacer()
            
            // Next
            Button(action: {
                viewModel.playNext()
            }) {
                Image.next
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(24)
                    .background(Color.primary_color)
                    .cornerRadius(40)
                    .modifier(NeuShadow())
            }
        }
    }
}
