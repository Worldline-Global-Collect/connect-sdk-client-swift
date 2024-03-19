//
//  SessionConfiguration.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 24/11/2023.
//  Copyright © 2023 Worldline Global Collect. All rights reserved.
//

public class SessionConfiguration: Decodable {
    public let clientSessionId: String
    public let customerId: String
    public let clientApiUrl: String
    public let assetUrl: String

    public init(clientSessionId: String, customerId: String, clientApiUrl: String, assetUrl: String) {
        self.clientSessionId = clientSessionId
        self.customerId = customerId
        self.clientApiUrl = clientApiUrl
        self.assetUrl = assetUrl
    }
}
