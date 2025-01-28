//
//  SVGCache.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//


import SwiftUI
import WebKit

class SVGCache {
    static let shared = NSCache<NSString, UIImage>()
}

struct SVGWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false // Prevent scrolling
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let cacheKey = url.absoluteString as NSString
        
        if let cachedImage = SVGCache.shared.object(forKey: cacheKey) {
            webView.isHidden = true
            let imageView = UIImageView(image: cachedImage)
            imageView.frame = webView.bounds
            webView.superview?.addSubview(imageView)
        } else {
            let request = URLRequest(url: url)
            webView.load(request)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {  // Simulated caching delay
                self.captureSnapshot(webView, key: cacheKey)
            }
        }
    }

    private func captureSnapshot(_ webView: WKWebView, key: NSString) {
        webView.takeSnapshot(with: nil) { image, error in
            if let image = image {
                SVGCache.shared.setObject(image, forKey: key)
            }
        }
    }
}
