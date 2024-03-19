//
//  SessionError.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/03/2017.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//
// swiftlint:disable identifier_name

@available(
    *,
    deprecated,
    message:
        """
        In a future release, this enum will be removed. The SDK will throw a ConnectSDKError instead.
        """
)
public enum SessionError: Error {
    case RuntimeError(String)
}
// swiftlint:enable identifier_name
