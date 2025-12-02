//
//  Validator.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class Validator: Codable {
    public var errors: [ValidationError] = []
    public var messageId: String = ""
    public var validationType: ValidationType = .type

    internal init() {}

    internal init(messageId: String, validationType: ValidationType) {
        self.messageId = messageId
        self.validationType = validationType
    }

    private enum CodingKeys: String, CodingKey {
        case messageId, validationType
    }

    public required init(from decoder: Decoder) throws {}

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(messageId, forKey: .messageId)
        try container.encodeIfPresent(validationType, forKey: .validationType)
    }

    internal func validate(value: String, for fieldId: String?) -> Bool {
        clearErrors()

        return true
    }

    internal func clearErrors() {
        errors.removeAll()
    }
}
