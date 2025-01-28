//
//  Coin.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 27.01.25.
//

import Foundation

struct Coin: Codable, Identifiable {
    var id: String { uuid } // For SwiftUI Identifiable conformance
    let uuid: String
    let symbol: String
    let name: String
    let color: String?
    let iconUrl: String
    let marketCap: String
    let price: String
    let btcPrice: String
    let listedAt: Int?
    let change: String
    let rank: Int
}
