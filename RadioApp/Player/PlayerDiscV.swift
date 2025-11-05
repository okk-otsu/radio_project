//
//  PlayerDiscV.swift
//  RadioApp
//  Created by B.RF Group on 03.11.2025.
//
import SwiftUI

struct PlayerDiscV: View {
    let coverImage: URL
    var body: some View {
        ZStack {
            Circle().foregroundColor(.primary_color)
                .frame(width: 300, height: 300).modifier(NeuShadow())
            ForEach(0..<15, id: \.self) { i in
                RoundedRectangle(cornerRadius: (150 + CGFloat((8 * i))) / 2)
                    .stroke(lineWidth: 0.25)
                    .foregroundColor(.disc_line)
                    .frame(width: 150 + CGFloat((8 * i)),
                           height: 150 + CGFloat((8 * i)))
            }
            AsyncImage(url: coverImage) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                } else {
                    Color.gray
                }
            }
            .frame(width: 120, height: 120)
            .cornerRadius(60)
        }
    }
}
