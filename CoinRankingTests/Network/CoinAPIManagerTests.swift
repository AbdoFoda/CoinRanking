//
//  CoinAPIManagerTests.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 27.01.25.
//

@testable import CoinRanking
import XCTest

import XCTest

class GetCoinsAPIManagerTests: XCTestCase {
    func testFetchCoinsSuccess() {
        // Mock response data
        let mockCoins = [
            Coin(uuid: "1", symbol: "BTC", name: "Bitcoin", color: "#f7931A", iconUrl: "", marketCap: "1000000", price: "50000", btcPrice: "1", listedAt: nil, change: "2.5", rank: 1, sparkline: nil, coinrankingUrl: "", contractAddresses: nil)
        ]
        let mockAPIManager = MockGetCoinsAPIManager()
        mockAPIManager.mockCoins = mockCoins

        let expectation = XCTestExpectation(description: "Fetch coins success")

        mockAPIManager.fetchCoins(limit: 10, offset: 0) { result in
            switch result {
            case .success(let coins):
                XCTAssertEqual(coins.count, 1)
                XCTAssertEqual(coins.first?.name, "Bitcoin")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }

        wait(for: [expectation], timeout: 1)
    }

    func testFetchCoinsFailure() {
        let mockAPIManager = MockGetCoinsAPIManager()
        mockAPIManager.mockError = NSError(domain: "TestError", code: -1, userInfo: nil)

        let expectation = XCTestExpectation(description: "Fetch coins failure")

        mockAPIManager.fetchCoins(limit: 10, offset: 0) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (TestError error -1.)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1)
    }
}
