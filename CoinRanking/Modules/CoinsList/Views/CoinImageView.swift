//
//  CoinImageView.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//


import SwiftUI
import Kingfisher
import WebKit

struct CoinImageView: View {
    let imageUrl: String
    @State private var isLoading: Bool = true  // Track loading state
    
    var body: some View {
        ZStack {
            if isLoading {
                SkeletonView()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            if let url = URL(string: imageUrl) {
                if url.pathExtension.lowercased() == "svg" {
                    SVGWebView(url: url)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onAppear {
                            isLoading = false  // Hide skeleton when image loads
                        }
                } else {
                    KFImage(URL(string: imageUrl))
                        .placeholder { // Placeholder view while loading
                            SkeletonView()
                        }
                        .retry(maxCount: 3, interval: .seconds(2)) // Retry logic
                        .onProgress { receivedSize, totalSize in
                            print("Loading progress: \(receivedSize)/\(totalSize)")
                        }
                        .onSuccess { _ in
                            isLoading = false // Success: Stop skeleton
                        }
                        .onFailure { error in
                            print("Error loading image: \(error.localizedDescription)")
                            isLoading = false // Failure: Stop skeleton
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8)) 
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .onAppear { isLoading = false }
            }
        }
    }
}
