//
//  PaymentProductGroup.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class PaymentProductGroup: BasicPaymentProductGroup, PaymentItem {
    public var fields = PaymentProductFields()

    private enum CodingKeys: String, CodingKey {
        case fields
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let fieldsInput = try? container.decodeIfPresent([PaymentProductField].self, forKey: .fields) {
            for field in fieldsInput {
                self.fields.paymentProductFields.append(field)
            }
        }

        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(fields.paymentProductFields, forKey: .fields)

        try super.encode(to: encoder)
    }

    public func paymentProductField(withId paymentProductFieldId: String) -> PaymentProductField? {
        for field in fields.paymentProductFields where field.identifier.isEqual(paymentProductFieldId) {
            return field
        }
        return nil
    }
}
