//
//  PreparedPaymentRequest.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class PreparedPaymentRequest: Codable {

    public var encryptedFields: String
    public var encodedClientMetaInfo: String

    init(encryptedFields: String, encodedClientMetaInfo mediaInfo: String) {
        self.encryptedFields = encryptedFields
        self.encodedClientMetaInfo = mediaInfo
    }
}
