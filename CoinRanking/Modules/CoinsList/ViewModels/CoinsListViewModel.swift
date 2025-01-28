//
//  CoinsListViewModel.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 27.01.25.
//

import Combine
import Foundation


class CoinsListViewModel: CoinsListViewModelProtocol {
    // MARK: - Published Properties
    @Published var coins: [Coin] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedSort: SortAttribute = .highestPrice {
        didSet {
            sortCoins(by: selectedSort)
        }
    }

    // MARK: - Private Properties
    private let apiManager: GetCoinsAPIProtocol
    private var currentPage = 0
    private let pageSize = 20
    private var canLoadMore = true

    // MARK: - Initializer
    init(apiManager: GetCoinsAPIProtocol = GetCoinsAPIManager()) {
        self.apiManager = apiManager
    }

    // MARK: - Fetch Coins
    func fetchCoins() {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        apiManager.fetchCoins(limit: pageSize, offset: currentPage * pageSize) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let newCoins):
                    if newCoins.isEmpty {
                        self.canLoadMore = false
                    } else {
                        self.coins.append(contentsOf: newCoins)
                        self.currentPage += 1
                        self.sortCoins(by: self.selectedSort) // Ensure new coins are sorted
                    }
                case .failure(let error):
                    self.errorMessage = self.handleError(error)
                }
            }
        }
    }

    // MARK: - Load More Coins
    func loadMoreCoins() {
        guard canLoadMore, !isLoading else { return }
        fetchCoins()
    }

    // MARK: - Sort Coins
    func sortCoins(by attribute: SortAttribute) {
        switch attribute {
        case .highestPrice:
            coins.sort { Double($0.price) ?? 0 > Double($1.price) ?? 0 }
        case .bestPerformance:
            coins.sort { Double($0.change) ?? 0 > Double($1.change) ?? 0 }
        }
    }

    // MARK: - Handle Error
    private func handleError(_ error: Error) -> String {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return "No internet connection. Please check your network and try again."
            case .timedOut:
                return "The request timed out. Please try again later."
            default:
                return "An unexpected error occurred. Please try again."
            }
        } else {
            return "Failed to fetch coins: \(error.localizedDescription)"
        }
    }
}
