//
//  APIConfigurationProtocol.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//

protocol APIConfigurationProtocol {
    var path: String { get }
    var apiKey: String { get }
}


extension APIConfigurationProtocol {
    var apiKey: String {
        return "coinrankinga905c364498165f3dc6924a77c8f4fbb3c1ff662daf80bb2"
       // APIKeyManager.shared.getAPIKey() ?? ""
    }
}
