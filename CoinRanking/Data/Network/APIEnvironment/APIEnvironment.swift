//
//  APIEnvironment.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//


struct APIEnvironment: APIEnvironmentProtocol {
    static let production = APIEnvironment(baseURL: "https://api.coinranking.com/v2")
    let baseURL: String

    func endpoint(for path: String) -> String {
        return "\(baseURL)/\(path)"
    }
}
