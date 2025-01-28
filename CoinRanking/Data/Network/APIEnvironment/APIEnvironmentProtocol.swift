//
//  APIEnvironmentProtocol.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//


protocol APIEnvironmentProtocol {
    var baseURL: String { get }
    func endpoint(for path: String) -> String
}