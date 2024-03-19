//
//  ConnectSDKError.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 27/11/2023.
//  Copyright © 2023 Worldline Global Collect. All rights reserved.
//

import Foundation

public enum ConnectSDKError: Int, Error {
    case connectSDKNotInitialized
    case publicKeyDecodeError
    case rsaKeyNotFound
}

extension ConnectSDKError: LocalizedError {
    public var errorDescription: String {
        switch self {
        case .connectSDKNotInitialized:
            return
                """
                ConnectSDK must be initialized before you can perform this operation.
                Initialize it by calling ConnectSDK.initialize()
                """
        case .publicKeyDecodeError:
            return "Failed to decode Public key."
        case .rsaKeyNotFound:
            return "Failed to find RSA key."
        }
    }
}
