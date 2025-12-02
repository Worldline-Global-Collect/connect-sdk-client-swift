//
//  JOSEEncryptor.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

class JOSEEncryptor {
    var encryptor = Encryptor()

    convenience init(encryptor: Encryptor) {
        self.init()

        self.encryptor = encryptor
    }

    func generateProtectedHeader(withKey keyId: String) -> String {
        let header = "{\"alg\":\"RSA-OAEP\", \"enc\":\"A256CBC-HS512\", \"kid\":\"\(keyId)\"}"
        return header
    }

    func encryptToCompactSerialization(JSON: String, withPublicKey publicKey: SecKey, keyId: String) -> String {
        guard let protectedheader = generateProtectedHeader(withKey: keyId).data(using: String.Encoding.utf8),
            let AESKey = encryptor.generateRandomBytes(length: 32),
            let HMACKey = encryptor.generateRandomBytes(length: 32)
            else {
                return ""
        }
        let encodedProtectedHeader = protectedheader.base64URLEncode()

        var key = Data([UInt8](HMACKey))
        key.append([UInt8](AESKey), count: AESKey.count)
        let encryptedKey = encryptor.encryptRSA(data: key, publicKey: publicKey)
        let encodedKey = encryptedKey.base64URLEncode()

        guard let initializationVector = encryptor.generateRandomBytes(length: 16) else {
            return ""
        }
        let encodedIV = initializationVector.base64URLEncode()

        guard let additionalAuthenticatedData = encodedProtectedHeader.data(using: String.Encoding.ascii) else {
            return ""
        }
        // swiftlint:disable identifier_name
        let AL = computeAL(forData: additionalAuthenticatedData)
        // swiftlint:enable identifier_name

        guard let ciphertext =
                encryptor.encryptAES(
                    data: JSON.data(using: String.Encoding.utf8)!,
                    key: AESKey,
                    IV: initializationVector
                ) else {
            return ""
        }
        let encodedCiphertext = ciphertext.base64URLEncode()

        var authenticationData = additionalAuthenticatedData
        authenticationData.append(initializationVector)
        authenticationData.append(ciphertext)
        authenticationData.append(AL)
        guard let authenticationTag = encryptor.generateHMAC(data: authenticationData, key: HMACKey) else {
            return ""
        }
        let truncatedAuthenticationTag = authenticationTag.subdata(in: 0..<32)
        let encodedAuthenticationTag = truncatedAuthenticationTag.base64URLEncode()

        let components = [encodedProtectedHeader, encodedKey, encodedIV, encodedCiphertext, encodedAuthenticationTag]
        let concatenatedComponents = components.joined(separator: ".")

        return concatenatedComponents
    }

    func computeAL(forData data: Data) -> Data {
        var lengthInBits = data.count * 8
        // swiftlint:disable identifier_name
        var AL = Data(bytes: &lengthInBits, count: MemoryLayout<Int>.size)
        AL.reverse()
        return AL
        // swiftlint:enable identifier_name
    }
}
