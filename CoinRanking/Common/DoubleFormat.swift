//
//  DoubleFormat.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//

extension Double {
    func formattedPrice() -> String {
        return String(format: "$%.2f", self)
    }
    
    func formattedPercentage() -> String {
        return String(format: "%.2f%%", self)
    }
}
