//
//  GetCoinsAPIProtocol.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 27.01.25.
//

import Foundation

protocol GetCoinsAPIProtocol {
    var session: URLSession { get }
    var configuration: APIConfigurationProtocol { get }
    var environment: APIEnvironmentProtocol { get }
    func fetchCoins(limit: Int, offset: Int, completion: @escaping (Result<[Coin], Error>) -> Void)
}
