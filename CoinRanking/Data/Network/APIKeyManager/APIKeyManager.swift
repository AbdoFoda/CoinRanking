//
//  APIKeyManager.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//

import Foundation
import CryptoKit

class APIKeyManager: APIKeyManagerProtocol {
    static let shared = APIKeyManager()

    private init() {}

    // MARK: - Load Encrypted API Key
    private func loadEncryptedKey() -> (encryptedKey: String, encryptionKey: String)? {
        guard let path = Bundle.main.path(forResource: "SecureKeys", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let encryptedKey = dict["ENCRYPTED_API_KEY"] as? String,
              let encryptionKey = dict["Encryption_KEY"] as? String else {
            print("Failed to load keys from plist")
            return nil
        }
        return (encryptedKey, encryptionKey)
    }

    // MARK: - Decrypt API Key
    private func decryptKey(encryptedKey: String, key: SymmetricKey) -> String? {
        guard let encryptedData = Data(base64Encoded: encryptedKey) else { return nil }

        do {
            let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption failed: \(error)")
            return nil
        }
    }

    // MARK: - Get Decrypted API Key
    func getAPIKey() -> String? {
        guard let keys = loadEncryptedKey() else {
            print("No keys available")
            return nil
        }

        guard let symmetricKeyData = Data(base64Encoded: keys.encryptionKey) else {
            print("Failed to load symmetric key")
            return nil
        }
        let symmetricKey = SymmetricKey(data: symmetricKeyData)

        return decryptKey(encryptedKey: keys.encryptedKey, key: symmetricKey)
    }
}
