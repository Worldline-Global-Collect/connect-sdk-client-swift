//
//  AuthenticationIndicator.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 09/03/2023.
//  Copyright © 2023 Worldline Global Collect. All rights reserved.
//

import Foundation

public class AuthenticationIndicator: ResponseObjectSerializable, Codable {
    public var name: String
    public var value: String

    public required init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
              let value = json["value"] as? String else {
            return nil
        }

        self.name = name
        self.value = value
    }
}
