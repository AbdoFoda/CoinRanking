//
//  CoinsListHostingView.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//

import UIKit
import SwiftUI

struct CoinsListHostingView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewModel = CoinsListViewModel()
        return CoinListViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
