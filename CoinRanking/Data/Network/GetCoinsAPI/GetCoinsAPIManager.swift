//
//  GetCoinsAPIManager.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 27.01.25.
//


import Foundation

class GetCoinsAPIManager: GetCoinsAPIProtocol {
    let session: URLSession
    let configuration: APIConfigurationProtocol
    let environment: APIEnvironmentProtocol

    init(session: URLSession = .shared,
         configuration: APIConfigurationProtocol = GetCoinsAPIConfiguration(),
         environment: APIEnvironmentProtocol = APIEnvironment.production
    ) {
        self.session = session
        self.configuration = configuration
        self.environment = environment
    }

    func fetchCoins(limit: Int, offset: Int, completion: @escaping (Result<[Coin], Error>) -> Void) {
        // Build URL
        let urlString = environment.endpoint(for: configuration.path)
        guard var urlComponents = URLComponents(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "tiers[]", value: "1") // Filter for Tier 1 coins
        ]

        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL Components", code: -1, userInfo: nil)))
            return
        }

        // Build Request
        var request = URLRequest(url: url)
        request.setValue(configuration.apiKey, forHTTPHeaderField: "x-access-token")

        // Perform Network Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            // Debug: Print Raw Data
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Raw JSON Response: \(jsonString)")
                    } else {
                        print("Failed to decode JSON to string.")
                    }

            do {
                let decodedResponse = try JSONDecoder().decode(CoinsResponse.self, from: data)
                completion(.success(decodedResponse.data.coins))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
