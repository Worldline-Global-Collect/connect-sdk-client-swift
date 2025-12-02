//
//  ValidatorLength.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class ValidatorLength: Validator, ValidationRule {
    public var minLength = 0
    public var maxLength = 0

    internal init(minLength: Int?, maxLength: Int?) {
        self.minLength = minLength ?? 0
        self.maxLength = maxLength ?? 0

        super.init(messageId: "length", validationType: .length)
    }

    private enum CodingKeys: String, CodingKey {
        case minLength, maxLength
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.minLength = (try? container.decodeIfPresent(Int.self, forKey: .minLength)) ?? 0
        self.maxLength = (try? container.decodeIfPresent(Int.self, forKey: .maxLength)) ?? 0

        super.init(messageId: "length", validationType: .length)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(minLength, forKey: .minLength)
        try? container.encode(maxLength, forKey: .maxLength)

        try? super.encode(to: encoder)
    }

    public func validate(field fieldId: String, in request: PaymentRequest) -> Bool {
        guard let fieldValue = request.getValue(forField: fieldId) else {
            return false
        }

        return validate(value: fieldValue, for: fieldId)
    }

    internal override func validate(value: String, for fieldId: String?) -> Bool {
        self.clearErrors()

        if value.count < minLength || value.count > maxLength {
            let error =
                ValidationErrorLength(
                    errorMessage: self.messageId,
                    paymentProductFieldId: fieldId,
                    rule: self
                )
            error.minLength = minLength
            error.maxLength = maxLength
            errors.append(error)

            return false
        }

        return true
    }
}
