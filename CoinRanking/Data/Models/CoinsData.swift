//
//  CoinsData.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//
import Foundation

struct CoinsData: Codable {
    let stats: CoinsStats
    let coins: [Coin]
}
