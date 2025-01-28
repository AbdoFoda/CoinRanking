//
//  CoinsStats.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//

import Foundation


struct CoinsStats: Codable {
    let total: Int
    let totalCoins: Int
    let totalMarkets: Int
    let totalExchanges: Int
    let totalMarketCap: String
    let total24hVolume: String
}
