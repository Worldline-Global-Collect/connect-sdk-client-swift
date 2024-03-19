//
//  ThirdPartyStatus.swift
//  Pods
//
//  Created for Worldline Global Collect on 15/06/2017.
//

import UIKit

public enum ThirdPartyStatus: String, Codable {
    // swiftlint:disable identifier_name
    case Waiting = "WAITING"
    case Initialized = "INITIALIZED"
    case Authorized = "AUTHORIZED"
    case Completed = "COMPLETED"
    // swiftlint:enable identifier_name
}
