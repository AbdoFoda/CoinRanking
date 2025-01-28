//
//  Coin+Formatting.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//
import UIKit

extension Coin {
    func priceFormatted() -> String {
        guard let priceDouble = Double(price) else { return "$0.00" }
        return String(format: "$%.2f", priceDouble)
    }
    
    func changeFormatted() -> String {
        guard let changeDouble = Double(change) else { return "0.00%" }
        return String(format: "%.2f%%", changeDouble)
    }
    
    func changeColor() -> UIColor {
        guard let changeDouble = Double(change) else { return .gray }
        return changeDouble > 0 ? .systemGreen : (changeDouble < 0 ? .systemRed : .gray)
    }
}
