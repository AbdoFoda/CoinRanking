//
//  SkeletonView.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//

import SwiftUI

// Skeleton Placeholder View
struct SkeletonView: View {
    @State private var animate = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(
                LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1)]),
                               startPoint: .leading, endPoint: .trailing)
            )
            .opacity(animate ? 1.0 : 0.6)
            .animation(Animation.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: animate)
            .onAppear { animate = true }
    }
}
