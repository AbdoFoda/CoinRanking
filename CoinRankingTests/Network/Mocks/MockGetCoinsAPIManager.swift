//
//  MockGetCoinsAPIManager.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 27.01.25.
//

@testable import CoinRanking

class MockGetCoinsAPIManager: GetCoinsAPIProtocol {
    var mockCoins: [Coin] = []
    var mockError: Error?

    func fetchCoins(limit: Int, offset: Int, completion: @escaping (Result<[Coin], Error>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else {
            let paginatedCoins = Array(mockCoins.prefix(limit))
            completion(.success(paginatedCoins))
        }
    }
}

