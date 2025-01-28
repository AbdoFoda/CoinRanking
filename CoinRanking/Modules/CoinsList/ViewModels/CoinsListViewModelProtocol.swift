//
//  CoinsListViewModelProtocol.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 27.01.25.
//

import Combine

protocol CoinsListViewModelProtocol: ObservableObject {
    var coins: [Coin] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var selectedSort: SortAttribute { get set }

    func fetchCoins()
    func loadMoreCoins()
    func sortCoins(by attribute: SortAttribute)
}
